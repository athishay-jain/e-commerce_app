class AppExceptions {
  String title;
  String message;

  AppExceptions({required this.title, required this.message});

  @override
  String toString() {
    // TODO: implement toString
    return "$title :$message";
  }
}

class NetworkException extends AppExceptions {
  NetworkException({required String message})
    : super(title: "No Internet", message: message);
}

class ServerException extends AppExceptions {
  ServerException({required String message})
    : super(title: "Server Error", message: message);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException({required String message})
    : super(title: "Invalid Input", message: message);
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required String message})
    : super(title: "Unauthorized", message: message);
}
