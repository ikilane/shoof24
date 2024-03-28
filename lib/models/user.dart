class UserInfo {
  final String username;
  final String password;
  final String message;
  final int auth;
  final String status;
  final String expDate;
  final String isTrial;
  final String activeCons;
  final String createdAt;
  final String maxConnections;
  final List<String> allowedOutputFormats;

  UserInfo({
    required this.username,
    required this.password,
    required this.message,
    required this.auth,
    required this.status,
    required this.expDate,
    required this.isTrial,
    required this.activeCons,
    required this.createdAt,
    required this.maxConnections,
    required this.allowedOutputFormats,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      username: json['username'],
      password: json['password'],
      message: json['message'],
      auth: json['auth'],
      status: json['status'],
      expDate: json['exp_date'],
      isTrial: json['is_trial'],
      activeCons: json['active_cons'],
      createdAt: json['created_at'],
      maxConnections: json['max_connections'],
      allowedOutputFormats: List<String>.from(json['allowed_output_formats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'message': message,
      'auth': auth,
      'status': status,
      'exp_date': expDate,
      'is_trial': isTrial,
      'active_cons': activeCons,
      'created_at': createdAt,
      'max_connections': maxConnections,
      'allowed_output_formats': allowedOutputFormats,
    };
  }
}

class ServerInfo {
  final String url;
  final String port;
  final String httpsPort;
  final String serverProtocol;
  final String rtmpPort;
  final String timezone;
  final int timestampNow;
  final String timeNow;

  ServerInfo({
    required this.url,
    required this.port,
    required this.httpsPort,
    required this.serverProtocol,
    required this.rtmpPort,
    required this.timezone,
    required this.timestampNow,
    required this.timeNow,
  });

  factory ServerInfo.fromJson(Map<String, dynamic> json) {
    return ServerInfo(
      url: json['url'],
      port: json['port'],
      httpsPort: json['https_port'],
      serverProtocol: json['server_protocol'],
      rtmpPort: json['rtmp_port'],
      timezone: json['timezone'],
      timestampNow: json['timestamp_now'],
      timeNow: json['time_now'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'port': port,
      'https_port': httpsPort,
      'server_protocol': serverProtocol,
      'rtmp_port': rtmpPort,
      'timezone': timezone,
      'timestamp_now': timestampNow,
      'time_now': timeNow,
    };
  }
}

class LoginResponse {
  final UserInfo userInfo;
  final ServerInfo serverInfo;

  LoginResponse({required this.userInfo, required this.serverInfo});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userInfo: UserInfo.fromJson(json['user_info']),
      serverInfo: ServerInfo.fromJson(json['server_info']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_info': userInfo.toJson(),
      'server_info': serverInfo.toJson(),
    };
  }
}