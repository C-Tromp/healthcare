/*jslint node: true */
"use strict";

var mongoose = require('mongoose'),
    Book = mongoose.model('Book');

exports.create = function (req, res) {

    var doc = new Book(req.body);

    doc.save(function (err) {

        var retObj = {
            meta: {
                "action": "create",
                'timestamp': new Date(),
                filename: __filename
            },
            doc: doc,
            err: err
        };

        return res.send(retObj);

    });

};

exports.list = function (req, res) {
    var conditions, fields, sort;

    conditions = {};
    fields = {};
    sort = {'modificationDate': -1};

    Book
        .find(conditions, fields)
        .sort(sort)
        .exec(function (err, doc) {

            var retObj = {
                meta: {
                    "action": "list",
                    'timestamp': new Date(),
                    filename: __filename
                },
                doc: doc, // array
                err: err
            };

            return res.send(retObj);

        });
};

exports.detail = function (req, res) {
    var conditions, fields;

    conditions = {_id: req.params._id};
    fields = {};

    Book
        .findOne(conditions, fields)
        .exec(function (err, doc) {
            var retObj = {
                meta: {"action": "detail", 'timestamp': new Date(), filename: __filename},
                doc: doc, // only the first document, not an array when using "findOne"
                err: err
            };
            return res.send(retObj);
        });
};

exports.updateOne = function (req, res) {

    var conditions =
        {_id: req.params._id},
        update = {
            title: req.body.doc.title || '',
            author: req.body.doc.author || '',
            description: req.body.doc.description || ''
        },
        options = {multi: false},
        callback = function (err, doc) {
            var retObj = {
                meta: {
                    "action": "update",
                    'timestamp': new Date(),
                    filename: __filename,
                    'doc': doc,
                    'update': update
                },
                doc: update,
                err: err
            };

            return res.send(retObj);
        };

    Book
        .findOneAndUpdate(conditions, update, options, callback);
};

exports.deleteOne = function (req, res) {
    var conditions, callback, retObj;

    conditions = {_id: req.params._id};
    callback = function (err, doc) {
        retObj = {
            meta: {
                "action": "delete",
                'timestamp': new Date(),
                filename: __filename
            },
            doc: doc,
            err: err
        };
        return res.send(retObj);
    };

    Book
        .remove(conditions, callback);
};
