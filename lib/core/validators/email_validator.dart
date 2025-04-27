class EmailValidator {
  static bool isValid(String email) {
    if (email.isEmpty) return false;
    final regex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return regex.hasMatch(email.trim());
  }
}
