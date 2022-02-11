import 'package:flutter/material.dart';

@immutable
abstract class BlocState {
  const BlocState();
}

@immutable
class InitBlocState extends BlocState {
  const InitBlocState();
}

@immutable
class LoadingBlocState extends BlocState {
  const LoadingBlocState();
}

@immutable
class DoneBlocState extends BlocState {
  final dynamic result;

  const DoneBlocState(this.result);
}

@immutable
class ErrorBlocState extends BlocState {
  final String message;

  const ErrorBlocState(this.message);
}
