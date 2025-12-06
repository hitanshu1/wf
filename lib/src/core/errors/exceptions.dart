import '../../config/constants/strings.dart';

class AppException implements Exception {
  final _msg;
  final _prefix;
  AppException([this._msg, this._prefix]);

  @override
  String toString() {
    return "$_prefix $_msg";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? msg])
    : super(msg, ExceptionPrefix.errorDuringCommunication);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? msg])
    : super(msg, ExceptionPrefix.invalidInput);
}

class BadRequestException extends AppException {
  BadRequestException([String? msg])
    : super(msg, ExceptionPrefix.invalidRequest);
}

class UnAuthoriseException extends AppException {
  UnAuthoriseException([String? msg])
    : super(msg, ExceptionPrefix.unAuthoriseRequest);
}

class InformationalException extends AppException {
  InformationalException([String? msg])
    : super(msg, ExceptionPrefix.someInformationalRequest);
}

class RedirectionStatusException extends AppException {
  RedirectionStatusException([String? msg])
    : super(msg, ExceptionPrefix.redirectionStatusRequest);
}

class NotFoundException extends AppException {
  NotFoundException([String? msg])
    : super(msg, ExceptionPrefix.notFoundRequest);
}

class ErrorFromServerSideException extends AppException {
  ErrorFromServerSideException([String? msg])
    : super(msg, ExceptionPrefix.errorFromServerSide);
}

class ServerRequestTimeOutException extends AppException {
  ServerRequestTimeOutException([String? msg])
    : super(msg, ExceptionPrefix.serverRequestTimeOut);
}

class ClientException extends AppException {
  ClientException([String? msg])
    : super(msg, ExceptionPrefix.errorFromClientSide);
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
