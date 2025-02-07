abstract class Failure {
  final String message;

  const Failure({required this.message});
}

// Specific Failures
class ServerFailure extends Failure {
  const ServerFailure({super.message = "Server Failure"});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = "Cache Failure"});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = "No Internet Connection"});
}
