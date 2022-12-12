const through2 = require("through2");

const collectedFiles = [];

function collector() {
  return through2.obj(function (file, _, cb) {
    collectedFiles.push(file);
    cb(null, file);
  });
}

function get() {
  return collectedFiles;
}

module.exports = { collector, get };
