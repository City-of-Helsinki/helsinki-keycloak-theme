/* eslint-env node */

const gulp = require("gulp");
const sass = require("gulp-sass")(require("sass"));
const rename = require("gulp-rename");

const SASS_FILES = {
  "sass/hds/index.scss": { basename: "hds" },
  "sass/shared/index.scss": { basename: "shared" },
  "sass/login/index.scss": { basename: "hs-login" },
};

function trimFromStart(str, prefix) {
  return str.startsWith(prefix) ? str.substring(prefix.length) : str;
}

function processStyleFiles() {
  const sourceFiles = Object.keys(SASS_FILES);

  return gulp
    .src(sourceFiles)
    .pipe(sass.sync().on("error", sass.logError))
    .pipe(
      rename((path, file) => {
        const originalFullPath = file.history[0];
        const originalFileName = trimFromStart(
          originalFullPath,
          `${file.cwd}/`
        );

        path.basename = SASS_FILES[originalFileName].basename;
      })
    )
    .pipe(gulp.dest("./helsinki/login/resources/css"));
}

exports.default = processStyleFiles;
