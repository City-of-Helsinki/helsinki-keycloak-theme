const { HtmlValidate } = require("html-validate");

function validateTranslations(translationData) {
  const validator = new HtmlValidate({
    rules: {
      "no-self-closing": "off",
    },
  });

  const strippedTagsAndCurlyBracesPerKey = {};
  const untranslatedKeys = [];
  let isValid = true;

  const curlyBracesRegExp = /{(.*?)}/g;
  const tagRegExp = /<(.*?)>/g;
  const attributeRegExp = /"(.*?(?<!\\))"/g;
  const translationNeededRegExp = /^(EN:|SV:)|[> ](EN:|SV:)/g;
  const translationKeyValidationRegExp = /[^\w.\-_]/g;

  const getStrippedTagsAndCurlyBraces = (string) => {
    const tagProps = string.match(tagRegExp);
    const curlyBracesContents = string.match(curlyBracesRegExp);
    let result = tagProps ? tagProps.join("") : "";
    result = result.replace(attributeRegExp, '""');
    result += curlyBracesContents ? curlyBracesContents.join("") : "";
    return result;
  };

  const removeCurlyBraces = (string) => {
    return string.replace(curlyBracesRegExp, "");
  };

  const hasMatchingCurlyBraces = (string) => {
    return string.split("{").length === string.split("}").length;
  };

  const hasMatchingTags = (string) => {
    return string.split("<").length === string.split(">").length;
  };

  const getHTMLValidationErrors = (string) => {
    if (string.indexOf("<") === -1) {
      return "";
    }
    if (!hasMatchingTags(string)) {
      return "Opening and closing tag mismatch!";
    }
    const report = validator.validateString(removeCurlyBraces(string));
    return report.valid ? "" : report.results.join(" ");
  };

  const hasUntranslatedKeys = (string) => {
    return !!string.match(translationNeededRegExp);
  };

  const isKeyValid = (string) => {
    return !string.match(translationKeyValidationRegExp);
  };

  Object.entries(translationData).map(async ([sheetWithLang, data]) => {
    const rows = data.split(/[\n\r]/g);
    rows.forEach((row) => {
      const [key, value] = row.split(" = ");
      if (!hasMatchingCurlyBraces(value)) {
        console.log(
          `
          ----------- ERROR -------
          Opening and closing curly braces mismatch!
          Sheet: ${sheetWithLang}
          ${key} = ${value}
          More info in README.md
          `
        );
        isValid = false;
        return;
      }

      if (!isKeyValid(key)) {
        console.log(
          `
          ----------- ERROR -------
          Translation key is invalid
          Sheet: ${sheetWithLang}
          Key: ${key}
          More info in README.md
          `
        );
        isValid = false;
        return;
      }

      if (hasUntranslatedKeys(value)) {
        untranslatedKeys.push(`Sheet: ${sheetWithLang}, key: ${key}`);
      }

      const strippedTagsAndCurlyBraces = getStrippedTagsAndCurlyBraces(value);
      const previousStrippedTranslation = strippedTagsAndCurlyBracesPerKey[key];
      if (
        previousStrippedTranslation &&
        previousStrippedTranslation !== strippedTagsAndCurlyBraces
      ) {
        console.log(
          `
          *** Warning
          Possible translation interpolation or HTML mismatch!
          Stripped tags and curly braces was ${previousStrippedTranslation}, but is now ${strippedTagsAndCurlyBraces}
          Sheet: ${sheetWithLang}.
          ${key} = ${value}
          More info in README.md
          `
        );
      }
      strippedTagsAndCurlyBracesPerKey[key] = strippedTagsAndCurlyBraces;
      if (getHTMLValidationErrors(value)) {
        console.log(`
          ----------- ERROR -------
          Invalid HTML! 
          Sheet: ${sheetWithLang}
          ${key} = ${value}
          More info in README.md
          `);
        isValid = false;
      }
    });
  });

  if (untranslatedKeys.length) {
    console.log(
      `
      *** Warning
      Untranslated keys found!
      ${untranslatedKeys.join("\n")}
      More info in README.md
      `
    );
  }
  return isValid;
}

module.exports = validateTranslations;
