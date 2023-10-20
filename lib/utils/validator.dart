class UserInfoValidator {
  static RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$',
  );

  static RegExp passwordCharactersCheck =
      RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)');

  static bool isEmailValid(String email) {
    return emailRegex.hasMatch(email);
  }

  //To validate entered password
  static bool validatePassword(String pass) {
    var password = pass.trim();
    if (passwordCharactersCheck.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }
}
