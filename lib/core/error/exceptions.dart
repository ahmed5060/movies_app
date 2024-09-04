class ErrorModelException implements Exception {
  final String errorMessage;

  ErrorModelException({required this.errorMessage});

  factory ErrorModelException.fromJson(Map<String, dynamic> json) {
    return ErrorModelException(errorMessage: json['message']);
  }
}

// code => 500
class ServerException implements Exception {}

// code => 401
class UnauthorizedException implements Exception {

}

class ConnectionTimeoutException implements Exception {}

// todo status code change
class AnotherAccountException implements Exception {}

class InternetException implements Exception {}

class EmptyCoinsException implements Exception {}

class BanException implements Exception {
  final String errorMessage;

  factory BanException.fromJson(Map<String, dynamic> json) {
    return BanException(json['message']);
  }
  BanException(this.errorMessage) : super();
}
