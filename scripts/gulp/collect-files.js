const through2 = require("through2");

const collectedFiles = {};

function collector(namespace) {
  const namedCollectedFiles = (collectedFiles[namespace] = []);

  return through2.obj(function (file, _, cb) {
    namedCollectedFiles.push(file);
    cb(null, file);
  });
}

function get(namespace) {
  return collectedFiles[namespace];
}

module.exports = { collector, get };
