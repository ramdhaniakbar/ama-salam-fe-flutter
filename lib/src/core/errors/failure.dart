abstract class Failure {
  final String errorMessage;
  final int errorCode;
  const Failure({required this.errorMessage, required this.errorCode});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage, required int errorCode}) : super(errorMessage: errorMessage, errorCode: errorCode);
}

class TypeFailure extends Failure {
  TypeFailure({required String errorMessage, required int errorCode}) : super(errorMessage: errorMessage, errorCode: errorCode);
}