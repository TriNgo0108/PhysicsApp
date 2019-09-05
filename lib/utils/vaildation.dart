class Validation{
  static String validateEmail(String email) {
    if (email == null) return 'Email can\'t empty';
    var isValid = RegExp(r"^[a-zA-Z0-9]+@+[a-zA-Z0-9]+\.[a-zA-Z0-9]+").hasMatch(email);
    if (!isValid) return 'Email is invalid ';
    return null;
  }
  static String validatePass(String pass){
    if (pass == null) return 'Password can\'t empty';
    else{
      if (pass.length<6 ) return 'Password at least six character';
    }
    return null;
  }
  static String validateName(String name){
    if (name.isEmpty) return 'Name can\'t empty ';
    return null;
  }
}