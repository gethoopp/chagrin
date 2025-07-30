import 'package:akunku/bloc/Auth/register/register_cubit.dart';
import 'package:akunku/bloc/auth_form/register_form/register_form_cubit.dart';
import 'package:akunku/extension/string_validate.dart';
import 'package:akunku/model/common.dart';
import 'package:akunku/repository/auth_repository/base_auth.dart';
import 'package:akunku/widget/base_widget.dart';
import 'package:akunku/widget/showtoast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:akunku/compound/compound.dart';

@RoutePage()
class ResgisteAuth extends StatelessWidget {
  final AuthRepository authRepository;
  const ResgisteAuth({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RegisterCubit(authRepository)),
          BlocProvider(create: (context) => RegisterFormCubit()),
        ],
        child: RegisterAccountScreen(),
      ),
    );
  }
}

class RegisterAccountScreen extends StatefulWidget {
  const RegisterAccountScreen({super.key});

  @override
  State<RegisterAccountScreen> createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool isChecked = false;
  String? messageError;
  Country selectedCountry = Country(
    phoneCode: '62',
    countryCode: 'ID',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Indonesia',
    example: '812345678',
    displayName: 'Indonesia',
    displayNameNoCountryCode: 'Indonesia',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, registerDataState) {
        if (registerDataState is RegisterErr) {
          setState(() {
            messageError = registerDataState.message;
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 100.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  context.pop();
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Asset.backgroundAuthLogin),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<RegisterFormCubit, RegisterFormState<RegisterData>>(
              builder: (context, stateRaegister) {
                return SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        buildTextField(
                          label: 'Nama Lengkap',
                          hint: 'Masukkan nama lengkap kamu',
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            setState(() {
                              context
                                  .read<RegisterFormCubit>()
                                  .onChangeUsername(
                                    stateRaegister.data!,
                                    value,
                                  );
                            });
                          },
                          isHaseror:
                              (stateRaegister.data!.username
                                  .getvalidateFirstName(3, 150) !=
                              null),
                        ),
                        ErrorTextFormField(
                          error: stateRaegister.data!.username
                              .getvalidateFirstName(3, 150),
                        ),
                        const SizedBox(height: 16),
                        _buildPhoneField(
                          context,
                          onChanged: (value) {
                            setState(() {
                              context
                                  .read<RegisterFormCubit>()
                                  .onChangeNumberPhone(
                                    stateRaegister.data!,
                                    value,
                                  );
                            });
                          },
                          selectedCountry: selectedCountry,
                          isHaseror:
                              stateRaegister.data!.numberPhone
                                  .validatePhoneNumber(
                                    12,
                                    selectedCountry.phoneCode,
                                  )
                                  ?.isNotEmpty ??
                              false,
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                        ),

                        ErrorTextFormField(
                          error: stateRaegister.data!.numberPhone
                              .validatePhoneNumber(
                                12,
                                selectedCountry.phoneCode,
                              ),
                        ),
                        const SizedBox(height: 16),
                        buildTextField(
                          label: 'Email',
                          hint: 'Masukkan email kamu',
                          onChanged: (value) {
                            context.read<RegisterCubit>().resetState();
                            setState(() {
                              messageError = null;
                              context.read<RegisterFormCubit>().onChangeEmail(
                                stateRaegister.data!,
                                value,
                              );
                            });
                          },
                          isHaseror:
                              stateRaegister
                                  .data
                                  ?.email
                                  ?.validateEmail
                                  ?.isNotEmpty ??
                              false,
                        ),
                        ErrorTextFormField(
                          error:
                              stateRaegister.data!.email.validateEmail ??
                              messageError,
                        ),
                        const SizedBox(height: 16),
                        buildPasswordField(
                          isPassowrdVisible: _isPasswordVisible,
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              context
                                  .read<RegisterFormCubit>()
                                  .onChangePassword(
                                    stateRaegister.data!,
                                    value,
                                  );
                            });
                          },
                          isHaseror:
                              stateRaegister
                                  .data!
                                  .password
                                  .validatePassword
                                  ?.isNotEmpty ??
                              false,
                        ),
                        ErrorTextFormField(
                          error: stateRaegister.data!.password.validatePassword,
                        ),
                        const SizedBox(height: 16),
                        buildPasswordField(
                          isPassowrdVisible: _isConfirmPasswordVisible,
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              context
                                  .read<RegisterFormCubit>()
                                  .onChangePasswordCheck(
                                    stateRaegister.data!,
                                    value,
                                  );
                            });
                          },
                          isHaseror:
                              stateRaegister.data!.checkPassword
                                  .validatePasswordCheck(
                                    stateRaegister.data!.password,
                                  ) !=
                              null,
                        ),
                        ErrorTextFormField(
                          error: stateRaegister.data!.checkPassword
                              .validatePasswordCheck(
                                stateRaegister.data!.password,
                              ),
                        ),
                        const SizedBox(height: 24),

                        _buildTermsAndConditions(
                          isChecked: isChecked,
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        BlocConsumer<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterSucces) {
                              final data = state.data;
                              showCustomToast(
                                context,
                                data["message"],
                                Colors.greenAccent,
                              );
                              context.pushRoute(
                                OtpRouteRegister(
                                  email: stateRaegister.data!.email,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return BlocSelector<
                              RegisterFormCubit,
                              RegisterFormState<RegisterData>,
                              FormFieldData
                            >(
                              selector: (state) => FormFieldData(
                                validate: [
                                  state.data!.username,
                                  selectedCountry.phoneCode,
                                  state.data!.numberPhone,
                                  state.data!.email,
                                  state.data!.password,
                                  state.data!.checkPassword,
                                ],
                                validateForm: [
                                  state.data!.username.getvalidateFirstName(
                                    3,
                                    150,
                                  ),
                                  state.data!.numberPhone.validatePhoneNumber(
                                    12,
                                    selectedCountry.phoneCode,
                                  ),
                                  state
                                      .data!
                                      .prefixNumber
                                      .validatePhoneNumberPrefix,
                                  state.data!.email.validateEmail,
                                  state.data!.password.validatePassword,
                                  state.data!.checkPassword
                                      .validatePasswordCheck(
                                        state.data!.password,
                                      ),
                                  isChecked,
                                ],
                              ),
                              builder: (context, validateState) {
                                final isLoading = state is RegisterLoading;
                                return buttonLoginTap(
                                  onTap: () {
                                    validateState.hasEmptyField ||
                                            validateState.hasInvalidField
                                        ? ""
                                        : context
                                              .read<RegisterCubit>()
                                              .registerUser(
                                                stateRaegister.data!.username!,
                                                stateRaegister.data!.email!,
                                                stateRaegister.data!.password!,
                                                stateRaegister
                                                    .data!
                                                    .checkPassword!,
                                                selectedCountry.phoneCode,
                                                stateRaegister
                                                    .data!
                                                    .numberPhone!,
                                              );
                                  },
                                  size,
                                  text: isLoading ? "" : "Daftar",

                                  colorbtn:
                                      validateState.hasEmptyField ||
                                          validateState.hasInvalidField ||
                                          isLoading
                                      ? Colors.grey.shade300
                                      : Colors.blue,
                                  validateState.hasEmptyField ||
                                          validateState.hasInvalidField ||
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
                                          child: CircularProgressIndicator(
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
                        const SizedBox(height: 24),

                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontFamily: "DM Sans Regular",
                              ),
                              children: [
                                const TextSpan(text: 'Sudah punya akun? '),
                                TextSpan(
                                  text: 'Masuk',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.replaceRoute(LoginRouteRoute());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPhoneField(
  BuildContext context, {
  void Function(String)? onChanged,
  bool isHaseror = false,
  required Country selectedCountry,
  required void Function(Country) onSelect,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nomor Whatsapp',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    countryListTheme: CountryListThemeData(
                      bottomSheetHeight: 500.h,
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8),
                          ),
                        ),
                      ),
                    ),
                    onSelect: onSelect,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        selectedCountry.flagEmoji,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 4),
                      Text('+${selectedCountry.phoneCode}'),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  onChanged: onChanged,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '81234567890',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isHaseror ? Colors.red : Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isHaseror ? Colors.red : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Widget _buildTermsAndConditions({
  required void Function(bool?)? onChanged,
  required void Function()? onTap,
  bool? isChecked,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 24,
        width: 24,
        child: radioButtonCheck(isChecked: isChecked!, onTap: onTap),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontFamily: "DM Sans Regular",
            ),
            children: [
              const TextSpan(text: 'Dengan mendaftar, saya menyetujui '),
              TextSpan(
                text: 'Syarat dan Ketentuan Akunmu',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
              const TextSpan(text: ' serta '),
              TextSpan(
                text: 'Kebijakan Privasi',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
