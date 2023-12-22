String? validateName(String? name) {
  // Name should contain only letters and spaces
  RegExp nameRegExp = RegExp(r'^[A-Za-z ]+$');
  if (name == null || name.isEmpty) {
    return 'Name is required.';
  } else if (!nameRegExp.hasMatch(name)) {
    return 'Invalid name format.';
  }
  return null; // Return null when the validation passes
}

String? validateEmail(String? email) {
  // Basic email pattern validation
  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
  if (email == null || email.isEmpty) {
    return 'Email is required.';
  } else if (!emailRegExp.hasMatch(email)) {
    return 'Invalid email format.';
  }
  return null; // Return null when the validation passes
}

String? validatePassword(String? password) {
  // Password should have at least 6 characters
  if (password == null || password.isEmpty) {
    return 'Password is required.';
  } else if (password.length < 8) {
    return 'Password should contain at least 8 characters.';
  }
  return null; // Return null when the validation passes
}
