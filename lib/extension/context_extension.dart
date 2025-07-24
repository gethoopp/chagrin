import 'package:akunku/bloc/Auth/login/auth_cubit.dart';
import 'package:akunku/model/profile/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtension on BuildContext {
  ProfieUser? get user {
    final state = read<AuthCubit>().state;
    if (state is AuthSucces) return state.data;
    return null;
  }
}
