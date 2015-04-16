#!/bin/bash

export COMMIT_MESSAGE="Automatic Deployment: `date`"
export STAGE0=development
export STAGE1=test-static-analyzer-passed
export STAGE2=test-unit-tests-passed
export STAGE3=acceptance
export STAGE4=production
export TESTDIR="`pwd`/../../tests"
export JSLINT=$TESTDIR/static-analyzer/node_modules/jslint
export DIR=`pwd`

echo "`date` : " > "$PWD/log.log"
echo "`date` : Logging to $PWD/log.log" | tee -a "$PWD/log.log"

echo
echo "`date` #########################################"
echo "`date` # Preflight checks"
echo "`date` #########################################"
echo
# make sure jslint is installed
if [[ ! -d $JSLINT ]]; then
	#install jslint locally
	echo "`date` Please install jslint first." | tee -a "$DIR/log.log"
	echo "`date`   jslint is expected to be installed in $TESTDIR/static-analyzer/." | tee -a "$DIR/log.log"
	exit 1
fi

echo | tee -a "$DIR/log.log"
echo "`date` #########################################" | tee -a "$DIR/log.log"
echo "`date` # STAGE0, development" | tee -a "$DIR/log.log"
echo "`date` #########################################" | tee -a "$DIR/log.log"
echo | tee -a "$DIR/log.log"

git checkout $STAGE0 | tee -a "$DIR/log.log"
git pull | tee -a "$DIR/log.log"

echo | tee -a "$DIR/log.log"
echo "`date` #########################################" | tee -a "$DIR/log.log"
echo "`date` # STAGE1, static-analyzer" | tee -a "$DIR/log.log"
echo "`date` #########################################" | tee -a "$DIR/log.log"
echo | tee -a "$DIR/log.log"

git checkout $STAGE1 | tee -a "$DIR/log.log"

git merge --no-edit $STAGE0 | tee -a "$DIR/log.log"
git commit -am "Merging from $STAGE0 to $STAGE1: `date`" | tee -a "$DIR/log.log"

cd $TESTDIR/static-analyzer
./run_lint.sh > static-analyzer-results.log

if [ -f $TESTDIR/static-analyzer/error_log.txt ]; then
	echo "`date` =~=~=~=~= ERRORS: No commit for branch 'test' was performed. =~=~=~=~=" | tee -a "$DIR/log.log"
	echo "`date` =~=~=~=~= Resolve the conflicts before continuing.           =~=~=~=~=" | tee -a "$DIR/log.log"
	git checkout $STAGE0 | tee -a "$DIR/log.log"
	exit 1
fi

git merge --commit -m "MERGE: `date`" $STAGE0 | tee -a "$DIR/log.log"
git commit -am "TEST: `date`" | tee -a "$DIR/log.log"

git push origin $STAGE1 | tee -a "$DIR/log.log"

echo "`date` #########################################" | tee -a "$DIR/log.log"
echo "`date` # STAGE2, unit-tests" | tee -a "$DIR/log.log"
echo "`date` #########################################" | tee -a "$DIR/log.log"

cd "$TESTDIR/../server"
export NODE_ENV=test
node bin/www.js &
export my_child_PID=$!
sleep 4
echo "`date` *********** nodemon started with process id = $my_child_PID" | tee -a log.log

git checkout $STAGE2 | tee -a "$DIR/log.log"

cd "$TESTDIR/unit-tests"

rm -fr unit-tests-results.log | tee -a "$DIR/log.log"

# Run the unit test
npm test

# kill nodemon
kill -9 $my_child_PID

# count fail occurences
UNIT_TEST_ERRORS=`grep -ci 'fail' unit-tests-results.log`

<<<<<<< HEAD
<<<<<<< HEAD
echo ">>>>> $UNIT_TEST_ERRORS <<<<<"

=======
if [ -z $UNIT_TEST_ERRORS ]; then
=======
if [ -z "$UNIT_TEST_ERRORS" ]; then
<<<<<<< HEAD
>>>>>>> development
    echo echo "=~=~=~=~= ERRORS ERRORS ERRORS =~=~=~=~=" | tee -a "$DIR/log.log"
	echo "  Could not execute the tests" | tee -a "$DIR/log.log"
=======
    echo echo "`date` =~=~=~=~= ERRORS ERRORS ERRORS =~=~=~=~=" | tee -a "$DIR/log.log"
	echo "`date`   Could not execute the tests" | tee -a "$DIR/log.log"
>>>>>>> development
    exit 1
fi
>>>>>>> development

if [ $UNIT_TEST_ERRORS -ne 0 ]; then
    echo echo "`date` =~=~=~=~= ERRORS ERRORS ERRORS =~=~=~=~=" | tee -a "$DIR/log.log"
	echo "`date`   Did not pass the unit-tests" | tee -a "$DIR/log.log"
	exit 1
fi

if [ -f ./test/static-analyzer/error_log.txt ]; then
	echo "=~=~=~=~= ERRORS: No commit for branch 'test' was performed. =~=~=~=~=" | tee -a "$DIR/log.log"
	echo "=~=~=~=~= Resolve the conflicts before continuing.           =~=~=~=~=" | tee -a "$DIR/log.log"
	git checkout $STAGE0 | tee -a "$DIR/log.log"
	exit 1
fi

git merge --no-edit $STAGE0 | tee -a "$DIR/log.log"
git commit -am "Merging from $STAGE0 to $STAGE1: `date`" | tee -a "$DIR/log.log"

git push origin $STAGE2 | tee -a "$DIR/log.log"

# Reset
echo "`date` Checking out $STAGE0" | tee -a "$DIR/log.log"
git checkout $STAGE0 | tee -a "$DIR/log.log"


