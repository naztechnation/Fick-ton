import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository.dart';
import '../../utils/exceptions.dart';
import 'account_states.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit({required this.accountRepository, required this.viewModel})
      : super(const InitialState());
  final AccountRepository accountRepository;
  final AccountViewModel viewModel;

  Future<void> registerUser({
    required String gender,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.registerUser(
        gender: gender,
        email: email,
        password: password,
        phone: phoneNumber,
      );

      await viewModel.setToken(user.token ?? '');
      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> loginUser(
      {required String password, required String email}) async {
    try {
      emit(AccountLoading());

      final userData =
          await accountRepository.loginUser(email: email, password: password);

      await viewModel.setToken(userData.token ?? '');
      emit(AccountUpdated(userData));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> verifyCode({required String code, required String token}) async {
    try {
      emit(AccountLoading());

      final userData =
          await accountRepository.verifyCode(code: code, token: token);

      await viewModel.setToken(userData.token ?? '');
      emit(AccountLoaded(userData));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.forgetPassword(
        email: email,
      );

      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    try {
      emit(ResetPasswordLoading());

      final user = await accountRepository.resetPassword(
        token: token,
        password: password,
      );

      emit(ResetPasswordLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
