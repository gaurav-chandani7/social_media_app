String? Function(String?, String) requiredValidator = (value, fieldName) {
  if (value != null && value.isNotEmpty) {
    return null;
  }
  return "$fieldName Required";
};

String? Function(String?) emailFieldValidator = (value) {
  if (value != null && value.isNotEmpty) {
    if (!validateEmail(value)) {
      return "Enter a Valid email";
    }
  } else {
    return "Email Required";
  }
  return null;
};

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}