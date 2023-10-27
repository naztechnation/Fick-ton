import 'package:equatable/equatable.dart';
import 'package:fikkton/model/auth_model/login.dart';

abstract class AccountStates extends Equatable {
  const AccountStates();
}

class InitialState extends AccountStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class AccountProcessing extends AccountStates {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoading extends AccountStates {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoaded extends AccountStates {
  final AuthData userData;
  const ResetPasswordLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class AccountLoaded extends AccountStates {
  final AuthData userData;
  const AccountLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class AccountUpdated extends AccountStates {
  final AuthData user;
  const AccountUpdated(this.user);
  @override
  List<Object> get props => [user];
}

class AccountPinChanged extends AccountStates {
  final String message;
  const AccountPinChanged(this.message);
  @override
  List<Object> get props => [message];
}

class OTPResent extends AccountStates {
  final String message;
  const OTPResent(this.message);
  @override
  List<Object> get props => [message];
}

class AccountLoggedOut extends AccountStates {
  final String message;
  const AccountLoggedOut(this.message);
  @override
  List<Object> get props => [message];
}

class AccountNetworkErr extends AccountStates {
  final String? message;
  const AccountNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class AccountApiErr extends AccountStates {
  final String? message;
  const AccountApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
