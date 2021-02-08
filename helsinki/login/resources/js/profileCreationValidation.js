(function () {
  // <-- Constants
  var HS_HAS_ERROR_CLASS = "hs-has-error";
  var KC_CREATE_PROFILE_FORM_ID = "kc-create-profile-form";
  var HS_ACKNOWLEDGEMENTS_INPUT_ID = "hs-acknowledgements";
  var HS_ACKNOWLEDGEMENTS_FORM_GROUP_ID = "hs-acknowledgements-form-group";
  var SUBMIT_BUTTONS_SELECTOR = "#" + KC_CREATE_PROFILE_FORM_ID + " button";
  var RESPONSE_INPUT_ID = "kc-response";
  // --> Constants

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

  // --> Selectors

  // <-- Utils
  function getIsCheckboxChecked(checkboxElement) {
    return checkboxElement.checked === true;
  }

  function isFormValid() {
    const isDeclined = getResponseInput().getAttribute("value") === "decline";
    if (isDeclined) {
      return true;
    }
    return getIsCheckboxChecked(getHsAcknowledgementsInput());
  }

  function toggleErrors(isValid) {
    // Toggle the error class in the form groups.
    getHsAcknowledgementsFormGroup().classList.toggle(
      HS_HAS_ERROR_CLASS,
      !isValid
    );
  }

  // --> Utils

  // <-- Handlers

  // prevent form submit without button click (mouse or kb)
  var handleFormSubmit = function (event) {
    event.preventDefault();
  };

  var handleCheckboxChange = function () {
    toggleErrors(isFormValid());
  };

  var handleSubmitButtonClick = function (event) {
    event.preventDefault();
    var responseInput = getResponseInput();
    responseInput.setAttribute("value", event.target.getAttribute("value"));
    const isValid = isFormValid();
    toggleErrors(isValid);
    if (isValid) {
      getCreateProfileForm().submit();
    }
  };
  // --> Handlers

  document.addEventListener("DOMContentLoaded", function () {
    var createProfileForm = getCreateProfileForm();
    var hsAcknowledgementsInput = getHsAcknowledgementsInput();
    var submitButtons = getSubmitButtons();
    if (createProfileForm) {
      createProfileForm.addEventListener("submit", handleFormSubmit);
    }

    if (hsAcknowledgementsInput) {
      hsAcknowledgementsInput.addEventListener("change", handleCheckboxChange);
    }
    if (submitButtons) {
      submitButtons.forEach(function (element) {
        element.addEventListener("click", handleSubmitButtonClick);
      });
    }
  });

  window.onunload = function () {
    var createProfileForm = getCreateProfileForm();
    var hsAcknowledgementsInput = getHsAcknowledgementsInput();
    var submitButtons = getSubmitButtons();

    if (createProfileForm) {
      createProfileForm.removeEventListener("submit", handleFormSubmit);
    }

    if (hsAcknowledgementsInput) {
      hsAcknowledgementsInput.removeEventListener(
        "change",
        handleCheckboxChange
      );
    }

    if (submitButtons) {
      submitButtons.forEach(function (element) {
        element.removeEventListener("click", handleSubmitButtonClick);
      });
    }
  };
})();
