class User{
  int _id           = 0;
  String _firstName = "";
  String _lastName  = "";
  String _gender    = "";
  String _phone     = "";
  String _email     = "";
  String _token     = "";

  User(int id,String firstName,String lastName,String gender,String phone,String email,String token){
    _id         = id;
    _firstName  = firstName;
    _lastName   = lastName;
    _gender     = gender;
    _phone      = phone;
    _email      = email;
    _token      = token;
  }

  //Setters
  void setFirstName(String firstName) => _firstName = firstName;
  void setLastName(String lastName)   => _lastName = lastName;
  void setGender(String gender)       => _gender = gender;
  void setPhone(String phone)         => _phone = phone;
  void setEmail(String email)         => _email = email;

  //Getters
  int getId()        => _id;
  String getFirstName() => _firstName;
  String getLastName()  => _lastName;
  String getGender()    => _gender;
  String getPhone()     => _phone;
  String getEmail()     => _email;
  String getToken()     => _token;
}