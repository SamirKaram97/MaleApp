class LoginRequest
{
  String userName;
  String password;

  LoginRequest({required this.userName,required this.password});
}

class ForgotPasswordRequest
{
  String email;
  ForgotPasswordRequest({required this.email});
}


class RegisterRequest
{
  String userName;
  String password;
  String mobileNumber;
  String email;

  RegisterRequest({required this.password,required this.userName,required this.mobileNumber,required this.email});
}


