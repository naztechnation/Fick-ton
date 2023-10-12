
class ApiException implements Exception{
  final String message;
  ApiException(this.message);
  @override
  String toString(){
    return message;
  }
}

class NetworkException implements Exception{
  final String message;
  NetworkException(this.message);
  @override
  String toString(){
    return message;
  }
}

class BadRequestException implements Exception{
  final String? message;
  BadRequestException(this.message);
  @override
  String toString(){
    return message!;
  }
}

class UnauthorisedException implements Exception{
  final String? message;
  UnauthorisedException(this.message);
  @override
  String toString(){
    return message!;
  }
}

class FileNotFoundException implements Exception{
  final String? message;
  FileNotFoundException(this.message);
  @override
  String toString(){
    return message!;
  }
}

class AlreadyRegisteredException implements Exception{
  final String? message;
  AlreadyRegisteredException(this.message);
  @override
  String toString(){
    return message!;
  }
}