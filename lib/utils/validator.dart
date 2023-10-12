class Validator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required.';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (value!.isEmpty) {
      return 'Required.';
    }
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email.';
    } else {
      return null;
    }
  }

  static String? validatePhone(String? value, [String? countryCode]) {
    Pattern pattern =
        r'^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';

    RegExp regex = RegExp(pattern as String);
    if (value!.isEmpty) {
      return 'Required.';
    } /*else if (!regex.hasMatch(value)) {
      return 'Please enter a mobile number.';
    }*/
    else if (countryCode != null && countryCode.isEmpty) {
      return 'Country code is Required';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Required.';
    }
    if (password.length < 6) {
      return 'Password too short.';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase.';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase.';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit.';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    } else {
      return null;
    }
  }
}
