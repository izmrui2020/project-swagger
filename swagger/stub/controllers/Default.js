'use strict';

var utils = require('../utils/writer.js');
var Default = require('../service/DefaultService');

module.exports.personsGET = function personsGET (req, res, next) {
  Default.personsGET()
    .then(function (response) {
      utils.writeJson(res, response);
    })
    .catch(function (response) {
      utils.writeJson(res, response);
    });
};
