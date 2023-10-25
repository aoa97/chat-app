import 'package:chat/core/utils/helpers.dart';
import 'package:flutter/material.dart';

abstract class FieldValidators {
  static FormFieldValidator<String?> validateName() {
    const patternName = r'^[\u0621-\u064A\040\a-zA-Z,.\-]+$';
    return (value) {
      if (value!.isEmpty) {
        return "Please enter your name";
      } else if (value.trim().length < 2) {
        return "Name must be more than 2 chars";
      } else if (value.trim().length > 30) {
        return "Name must be 30 chatrs at most";
      } else if (!checkPattern(pattern: patternName, value: value.trim())) {
        return "Please enter a valid name";
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String?> validateEmail() {
    const patternEmail = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    return (value) {
      if (value!.isEmpty) {
        return "Please enter email";
      } else if (!checkPattern(pattern: patternEmail, value: value)) {
        return "Please enter a valid email";
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String?> validatePassword() {
    return (value) {
      if (value!.isEmpty) {
        return "Please enter password";
      } else if (value.length < 8) {
        return "Password length must be more than 8 chars";
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String?> validateBio() {
    return (value) {
      if (value!.isNotEmpty && value.length < 8) {
        return "Bio length should be 8 chars or more";
      } else if (value.isNotEmpty && value.length > 40) {
        return "Bio length should not exceed 40 chars";
      } else {
        return null;
      }
    };
  }
}
