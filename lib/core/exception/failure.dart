import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}
