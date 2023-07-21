import 'package:beegain/db/db.dart';
import 'package:beegain/models/auth/auth_model.dart';
import 'package:beegain/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  onLogin({required name, required psw}) async {
    try {
      emit(AuthLoading());
      var res = await authRepository.login(name: name, psw: psw);
      if (res['status'] == "ok") {
        var result = res['data'] as AuthModel;
        await DbService().setUser(result);
        emit(AuthLoadSuccess(data: result.data));
      } else {
        emit(AuthLoadError(error: res['message']));
      }
    } catch (e) {
      emit(AuthLoadError(error: e.toString()));
    }
  }
}
