class ApiEndpoints {
  static const String baseUrl = 'https://fasio-backend.onrender.com'; // live
  // static const String baseUrl = 'https://insights-backend-d04s.onrender.com'; // live
  // static const String baseUrl = 'http://localhost:3000'; // Windows
  // static const String baseUrl = 'http://localhost:3000'; // Windows

  // static const String baseUrl = 'http://127.0.0.1:3000';  //chrome
  // static const String baseUrl = "http://192.168.1.100:3000"; // Fixed backend port
  static const String login = '$baseUrl/signin';
  static const String signUp = '$baseUrl/signup';
}
