// Login Model
class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

// Signup Model
class SignupModel {
  final String name;
  final int age; // Changed from String to int
  final String email;
  final String password;

  SignupModel({
    required this.name,
    required this.age,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age, // Already an int, no conversion needed
        'email': email,
        'password': password
      };
}
