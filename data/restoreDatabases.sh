#!/bin/bash

# groep10-prd keeps its data
for db in groep10-dev groep10-tst groep10-acc
do
    echo "Dropping $db"
    mongo $db --eval "db.dropDatabase()"
    echo "Restoring $db"
    mongorestore -d $db seed
done
