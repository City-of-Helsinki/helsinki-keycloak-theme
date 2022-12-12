/* eslint-env node */

const gulp = require("gulp");
const sass = require("gulp-sass")(require("sass"));
const rename = require("gulp-rename");
const gulpRev = require("gulp-rev-all");
const collectFiles = require("./scripts/gulp/collect-files");
const replace = require("gulp-replace");

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
      gulpRev.revision({
        transformFilename: (file) => {
          return file.basename;
        },
      })
    )
    .pipe(
      rename((path, file) => {
        const originalFullPath = file.history[0];
        const originalFileName = trimFromStart(
          originalFullPath,
          `${file.cwd}/`
        );

        path.dirname = "";
        path.basename = SASS_FILES[originalFileName].basename;
      })
    )
    .pipe(collectFiles.collector())
    .pipe(gulp.dest("./helsinki/login/resources/css"));
}

function updateStylesInThemeProperties() {
  const versionedFileNames = collectFiles.get().map((file) => {
    return `${file.basename}?v=${file.revHash.substring(0, 8)}`;
  });
  // Include login.css from the Keycloak base theme
  const cssFileNames = ["login.css"].concat(versionedFileNames);
  const cssFilePaths = cssFileNames.map((f) => `css/${f}`).join(" ");

  return gulp
    .src("helsinki/login/theme.properties")
    .pipe(replace(/^styles=.+$/m, `styles=${cssFilePaths}`))
    .pipe(gulp.dest("helsinki/login"));
}

exports.default = gulp.series(processStyleFiles, updateStylesInThemeProperties);
