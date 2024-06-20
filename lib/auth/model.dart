class User {
  final String id;
  final String username;
  final String branch;
  final String role;
  final String token;
  // final String password;
  // final List<DateTime> loggedIn;
  // final int version;

  User({
    required this.id,
    required this.username,
    required this.branch,
    required this.role,
    required this.token
    // required this.password,
    // required this.loggedIn,
    // required this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      branch: json['branch'],
      role: json['role'],
      token: json['token']
      // password: json['password'],
      // loggedIn: (json['loggedin'] as List).map((timestamp) => DateTime.parse(timestamp)).toList(),
      // version: json['__v'],
    );
  }
}
