import 'dart:io';

import 'package:akunku/bloc/Auth/auth_cubit.dart';
import 'package:akunku/extension/string_validate.dart';
import 'package:akunku/compound/compound.dart';

import 'package:akunku/model/common.dart';
import 'package:akunku/repository/auth_repository/auth.dart';
import 'package:akunku/widget/base_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth_form/auth_form_cubit.dart';

@RoutePage()
class LoginScreenAuth extends StatelessWidget {
  const LoginScreenAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthenticationBase();

    return RepositoryProvider<AuthRepository>.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(authRepository)),
          BlocProvider(create: (context) => AuthFormCubit()),
        ],
        child: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _isPasswordVisible = false;
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passContoller = TextEditingController();

  @override
  void dispose() {
    emailContoller.clear();
    passContoller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucces) {
          debugPrint("Yess berhasil login!!!");
        }
      },
      child: Scaffold(
        body: Stack(
          children: [_buildHeaderBackground(), _buildLoginForm(size)],
        ),
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Asset.backgroundAuthLogin),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLoginForm(Size size) {
    return BlocBuilder<AuthFormCubit, AuthFormState<LoginFormData>>(
      builder: (context, stateLogin) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 8,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontFamily: "DM Sans Bold",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                buildTextField(
                                  onChanged: (value) {
                                    context
                                        .read<AuthFormCubit>()
                                        .onChangeUsername(
                                          stateLogin.data!,
                                          value,
                                        );
                                  },
                                  label: "email",
                                  hint: 'Masukkan email kamu',
                                ),
                                ErrorTextFormField(
                                  error: stateLogin.data!.email.validateEmail,
                                ),
                                const SizedBox(height: 20),
                                buildPasswordField(
                                  onChanged: (value) {
                                    context
                                        .read<AuthFormCubit>()
                                        .onChangePassword(
                                          stateLogin.data!,
                                          value,
                                        );
                                  },
                                  isPassowrdVisible: _isPasswordVisible,
                                  onPressed: () {},
                                ),
                                ErrorTextFormField(
                                  error: stateLogin
                                      .data!
                                      .password
                                      .validatePassword,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,

                                  child: TextButton(
                                    onPressed: () {
                                      // Aksi untuk Lupa Kata Sandi
                                    },
                                    child: Text(
                                      'Lupa Kata Sandi?',
                                      style: TextStyle(
                                        fontFamily: "DM Sans Bold",
                                        fontWeight: FontWeight.w900,
                                        color: Colors.blue[300],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthError) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(state.message)),
                                      );
                                    }
                                    if (state is AuthSucces) {
                                      // Navigasi ke halaman selanjutnya
                                    }
                                  },
                                  builder: (context, state) {
                                    return BlocSelector<
                                      AuthFormCubit,
                                      AuthFormState<LoginFormData>,
                                      FormFieldData
                                    >(
                                      selector: (state) => FormFieldData(
                                        validate: [
                                          state.data!.email,
                                          state.data!.password,
                                        ],
                                        validateForm: [
                                          state.data!.email.validateEmail,
                                          state.data!.password.validatePassword,
                                        ],
                                      ),

                                      builder: (context, validateState) {
                                        final isLoading = state is AuthLoading;
                                        return buttonLoginTap(
                                          onTap: () {
                                            validateState.hasEmptyField ||
                                                    validateState
                                                        .hasInvalidField
                                                ? ""
                                                : context
                                                      .read<AuthCubit>()
                                                      .loginUser(
                                                        stateLogin.data!.email!,
                                                        stateLogin
                                                            .data!
                                                            .password!,
                                                        Platform
                                                            .operatingSystem,
                                                      );
                                          },
                                          size,

                                          text: isLoading ? "" : "Masuk",

                                          colorbtn:
                                              validateState.hasEmptyField ||
                                                  validateState
                                                      .hasInvalidField ||
                                                  isLoading
                                              ? Colors.grey.shade300
                                              : Colors.blue,
                                          validateState.hasEmptyField ||
                                                  validateState
                                                      .hasInvalidField ||
                                                  isLoading
                                              ? Colors.grey.shade300
                                              : Colors.blue,
                                          textColor:
                                              validateState.hasEmptyField &&
                                                  validateState.hasInvalidField
                                              ? Colors.black
                                              : Colors.white,
                                          child: isLoading
                                              ? const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.blue,
                                                        strokeWidth: 2,
                                                      ),
                                                )
                                              : null,
                                        );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "Belum ada akun?",
                                        style: TextStyle(
                                          fontFamily: "DM Sans Regular",
                                          fontWeight: FontWeight.w200,
                                        ),
                                        children: [
                                          WidgetSpan(
                                            child: SizedBox(width: 5.w),
                                          ),
                                          TextSpan(
                                            text: "Daftar",
                                            style: TextStyle(
                                              fontFamily: "DM Sans Regular",
                                              fontWeight: FontWeight.w200,
                                              color: Colors.blue,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.router.push(
                                                  ResgisteRoute(),
                                                );
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
