(function () {
  // <-- Constants
  var HS_HAS_ERROR_CLASS = "hs-has-error";
  var KC_REGISTER_FORM_ID = "kc-register-form";
  var HS_ACKNOWLEDGEMENTS_FORM_GROUP_ID = "hs-acknowledgements-form-group";
  var HS_ACKNOWLEDGEMENTS_INPUT_ID = "hs-acknowledgements";
  // --> Constants

  // <-- Selectors
  function getRegistrationForm() {
    return document.getElementById(KC_REGISTER_FORM_ID);
  }
  function getHsAcknowledgementsFormGroup() {
    return document.getElementById(HS_ACKNOWLEDGEMENTS_FORM_GROUP_ID);
  }
  function getHsAcknowledgementsInput() {
    return document.getElementById(HS_ACKNOWLEDGEMENTS_INPUT_ID);
  }
  // --> Selectors

  // <-- Utils
  function getIsAcknowledgementsValid(acknowledgementsElement) {
    return acknowledgementsElement.checked === true;
  }
  // --> Utils

  // <-- Handlers
  var handleRegistrationFormSubmit = function (event) {
    var isAcknowledgedValid = getIsAcknowledgementsValid(
      event.target.acknowledgements
    );

    // Toggle the error class in the acknowledgement form group.
    getHsAcknowledgementsFormGroup().classList.toggle(
      HS_HAS_ERROR_CLASS,
      !isAcknowledgedValid
    );

    // If our custom conditions do not pass, we prevent the form from
    // submitting. Note that this behaviour will in essence create two
    // validation steps if the user has multiple errors on the form:
    // 1) Custom validation is ran in the browser
    // 2) Default validation is ran on the server
    //
    // This means that the user may have to fix errors twice. Not ideal
    // but this seemed like the most pragmatic approach.
    if (!isAcknowledgedValid) {
      event.preventDefault();
    }
  };
  var handleHsAcknowledgementsChange = function (event) {
    var hsAcknowledgementsFormGroup = getHsAcknowledgementsFormGroup();
    var isError = hsAcknowledgementsFormGroup.classList.contains(
      HS_HAS_ERROR_CLASS
    );
    var isNowValid = getIsAcknowledgementsValid(event.target);

    // When the form group still has an error label, but actually has a
    // valid value, remove the error value.
    if (isError && isNowValid) {
      hsAcknowledgementsFormGroup.classList.remove(HS_HAS_ERROR_CLASS);
    }
  };
  // --> Handlers

  document.addEventListener("DOMContentLoaded", function (event) {
    var registrationForm = getRegistrationForm();
    var hsAcknowledgementsInput = getHsAcknowledgementsInput();

    if (registrationForm) {
      registrationForm.addEventListener("submit", handleRegistrationFormSubmit);
    }

    if (hsAcknowledgementsInput) {
      hsAcknowledgementsInput.addEventListener(
        "change",
        handleHsAcknowledgementsChange
      );
    }
  });

  window.onunload = function () {
    var registrationForm = getRegistrationForm();
    var hsAcknowledgementsInput = getHsAcknowledgementsInput();

    if (registrationForm) {
      registrationForm.removeEventListener(
        "submit",
        handleRegistrationFormSubmit
      );
    }

    if (hsAcknowledgementsInput) {
      hsAcknowledgementsInput.removeEventListener(
        "change",
        handleHsAcknowledgementsChange
      );
    }
  };
})();
