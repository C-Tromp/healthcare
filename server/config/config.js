/*jslint node:true*/
module.exports = {
    deployment: {
        port: 3333,
        repoUrl: "https://github.com/theotheu/cria-seed",
        user: "theo.theunissen0@gmail.com",
        to: "theo.theunissen@gmail.com",
        userName: "CRIA-testert",
        password: "<topSecret!>"
    },
    development: {
        db: 'mongodb://server3.tezzt.nl/groep10-dev',    // change books with your database
        port: 3000,                             // change with your port number
        debug: true                             // set debug to true|false
    },
    test: {
        db: 'mongodb://server3.tezzt.nl/groep10-tst',    // change books with your database
        port: 3001,                             // change with your port number
        debug: true                             // set debug to true|false
    },
    acceptance: {
        db: 'mongodb://server3.tezzt.nl/groep10-acc',    // change books with your database
        port: 3002,                             // change with your port number
        debug: true                             // set debug to true|false
    },
    production: {
        db: 'mongodb://server3.tezzt.nl/groep10-prd',    // change books with your database
        port: 1337,                             // change with your port number
        debug: false                            // set debug to true|false
    }
};
