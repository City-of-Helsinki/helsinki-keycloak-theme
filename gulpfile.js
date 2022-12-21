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
const STYLES_THEME_PROPERTIES_KEY = "styles";

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
    .pipe(collectFiles.collector(STYLES_THEME_PROPERTIES_KEY))
    .pipe(gulp.dest("./helsinki/login/resources/css"));
}

function updateThemeProperties(fileType, filePath, prependedFileNames = []) {
  const versionedFileNames = collectFiles.get(fileType).map((file) => {
    return `${file.basename}?v=${file.revHash.substring(0, 8)}`;
  });

  const allFileNames = prependedFileNames.concat(versionedFileNames);
  const allFilePaths = allFileNames.map((f) => `${filePath}/${f}`).join(" ");

  return gulp
    .src("helsinki/login/theme.properties")
    .pipe(
      replace(
        new RegExp(`^${fileType}=.+$`, "m"),
        `${fileType}=${allFilePaths}`
      )
    )
    .pipe(gulp.dest("helsinki/login"));
}

function updateStylesInThemeProperties() {
  // Include login.css from the Keycloak base theme
  return updateThemeProperties(STYLES_THEME_PROPERTIES_KEY, "css", [
    "login.css",
  ]);
}

exports.default = gulp.series(processStyleFiles, updateStylesInThemeProperties);
