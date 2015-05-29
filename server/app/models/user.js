/*jslint node:true */

(function () {
    "use strict";
    /**
     * Module dependencies.
     */
    var mongoose = require('mongoose'),
        Schema = mongoose.Schema,
        schemaName,
        modelName;

	//Schema
    schemaName = new Schema({
        username: {type: String, required: true, unique: true},
        password: {type: String, required: true},
        role: {type: String}
    },
    {collection: 'user'});

    /**
     *Validator, maybe usefull for later 
     */
    
    /*
    schemaName.path('title').validate(function (val) {
        return (val !== undefined && val !== null && val.length >= 8);
    }, 'Invalid title');
	*/

	//Model
    modelName = "User";
    mongoose.model(modelName, schemaName);

}());