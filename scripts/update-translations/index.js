const config = require("../config");
const getTranslationSources = require("./getTranslationSources");
const getTranslationDataFromSources = require("./getTranslationDataFromSources");
const convertTranslationData = require("./convertTranslationData");
const writeTranslations = require("./writeTranslations");
const validateTranslations = require("./validateTranslations");

async function fetchTranslations(sheetId, module, languages, output, debug) {
  const translationSources = getTranslationSources(sheetId, module, languages);
  const translationData = await getTranslationDataFromSources(
    translationSources,
    debug
  );
  const convertedTranslationData = await convertTranslationData(
    translationData,
    debug
  );
  if (validateTranslations(convertedTranslationData)) {
    await writeTranslations(output, convertedTranslationData, debug);
  } else {
    console.log(`
    ---- ERROR ----
    VALIDATION FAILED!
    Translations NOT updated for module ${module}
    `);
  }
}

config.MODULES.forEach((module) => {
  fetchTranslations(
    config.TRANSLATION_SHEET_ID,
    module,
    config.LANGUAGES,
    `./helsinki/${module}/messages`
  );
});
