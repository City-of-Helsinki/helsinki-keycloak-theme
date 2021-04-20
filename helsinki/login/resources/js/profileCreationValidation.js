(function () {
  // <-- Constants
  // match following class with kcFormGroupHasErrorClass in login/theme.properties
  var HS_HAS_ERROR_CLASS = "hs-has-error";
  var KC_CREATE_PROFILE_FORM_ID = "kc-create-profile-form";
  var KC_UPDATE_PROFILE_FORM_ID = "kc-update-profile-form";
  var HS_ACKNOWLEDGEMENTS_INPUT_ID = "hs-acknowledgements";
  var HS_ACKNOWLEDGEMENTS_FORM_GROUP_ID = "hs-acknowledgements-form-group";
  var SUBMIT_BUTTONS_SELECTOR =
    "#" +
    KC_CREATE_PROFILE_FORM_ID +
    " button, #" +
    KC_UPDATE_PROFILE_FORM_ID +
    " button";
  var RESPONSE_INPUT_ID = "kc-response";
  var HS_EMAIL_INPUT_ID = "hs-email";
  var HS_EMAIL_FORM_GROUP_ID = "hs-email-form-group";
  // --> Constants

  function isTextValidEmail(email) {
    // following regex is from backend's java implementation
    var tester = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
    if (!email) return false;

    if (email.length > 254) return false;

    var valid = tester.test(email);
    if (!valid) return false;

    // Further checking of some things regex can't handle
    var parts = email.split("@");
    if (parts[0].length > 64) return false;

    var domainParts = parts[1].split(".");
    if (
      domainParts.some(function (part) {
        return part.length > 63;
      })
    )
      return false;

    return true;
  }

  // <-- Selectors

  function getCreateProfileForm() {
    return document.getElementById(KC_CREATE_PROFILE_FORM_ID);
  }

  function getHsAcknowledgementsFormGroup() {
    return document.getElementById(HS_ACKNOWLEDGEMENTS_FORM_GROUP_ID);
  }

  function getHsAcknowledgementsInput() {
    return document.getElementById(HS_ACKNOWLEDGEMENTS_INPUT_ID);
  }

  function getSubmitButtons() {
    return document.querySelectorAll(SUBMIT_BUTTONS_SELECTOR);
  }

  function getResponseInput() {
    return document.getElementById(RESPONSE_INPUT_ID);
  }

  function getHsEmailInput() {
    return document.getElementById(HS_EMAIL_INPUT_ID);
  }

  function getEmailFormGroup() {
    return document.getElementById(HS_EMAIL_FORM_GROUP_ID);
  }

  function getUpdateProfileForm() {
    return document.getElementById(KC_UPDATE_PROFILE_FORM_ID);
  }

  // --> Selectors

  // <-- Utils
  function getIsCheckboxChecked() {
    const checkboxElement = getHsAcknowledgementsInput();
    return checkboxElement.checked === true;
  }

  function isEmailValid() {
    const inputElement = getHsEmailInput();
    return isTextValidEmail(inputElement.value);
  }

  function isDeclined() {
    return getResponseInput().getAttribute("value") === "decline";
  }

  function toggleAcknowledgementsErrors(isValid) {
    getHsAcknowledgementsFormGroup().classList.toggle(
      HS_HAS_ERROR_CLASS,
      !isValid
    );
  }

  function toggleEmailError(isValid) {
    getEmailFormGroup().classList.toggle(HS_HAS_ERROR_CLASS, !isValid);
  }

  function isUpdateTemplate() {
    return !!getUpdateProfileForm();
  }

  function getAndShowErrors() {
    const declined = isDeclined();
    const checkboxesAreValid = declined || getIsCheckboxChecked();
    const emailIsValid = declined || isEmailValid();
    toggleAcknowledgementsErrors(checkboxesAreValid);
    toggleEmailError(emailIsValid);
    return !checkboxesAreValid || !emailIsValid;
  }

  // --> Utils

  // <-- Handlers

  // prevent form submit without button click (mouse or kb)
  var handleFormSubmit = function (event) {
    event.preventDefault();
  };

  var handleCheckboxChange = function () {
    const isValid = getIsCheckboxChecked();
    toggleAcknowledgementsErrors(isValid);
  };

  var handleEmailChange = function () {
    const isValid = isEmailValid();
    if (isValid) {
      toggleEmailError(isValid);
    }
  };

  var handleSubmitButtonClick = function (event) {
    event.preventDefault();
    var responseInput = getResponseInput();
    responseInput.setAttribute("value", event.target.getAttribute("value"));
    if (isUpdateTemplate()) {
      getUpdateProfileForm().submit();
      return;
    }
    const hasErrors = getAndShowErrors();
    if (!hasErrors) {
      getCreateProfileForm().submit();
    }
  };
  // --> Handlers

  document.addEventListener("DOMContentLoaded", function () {
    var profileForm = getCreateProfileForm() || getUpdateProfileForm();
    var hsAcknowledgementsInput = getHsAcknowledgementsInput();
    var hsEmailInput = getHsEmailInput();
    var submitButtons = getSubmitButtons();
    if (profileForm) {
      profileForm.addEventListener("submit", handleFormSubmit);
    }

    if (hsAcknowledgementsInput) {
      hsAcknowledgementsInput.addEventListener("change", handleCheckboxChange);
    }

    if (hsEmailInput) {
      hsEmailInput.addEventListener("keyup", handleEmailChange);
    }

    if (submitButtons) {
      submitButtons.forEach(function (element) {
        element.addEventListener("click", handleSubmitButtonClick);
      });
    }
  });

  window.onunload = function () {
    var profileForm = getCreateProfileForm() || getUpdateProfileForm();
    var hsAcknowledgementsInput = getHsAcknowledgementsInput();
    var hsEmailInput = getHsEmailInput();
    var submitButtons = getSubmitButtons();

    if (profileForm) {
      profileForm.removeEventListener("submit", handleFormSubmit);
    }

    if (hsAcknowledgementsInput) {
      hsAcknowledgementsInput.removeEventListener(
        "change",
        handleCheckboxChange
      );
    }

    if (hsEmailInput) {
      hsEmailInput.removeEventListener("keyup", handleEmailChange);
    }

    if (submitButtons) {
      submitButtons.forEach(function (element) {
        element.removeEventListener("click", handleSubmitButtonClick);
      });
    }
  };
})();
