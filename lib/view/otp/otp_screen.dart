import 'package:akunku/bloc/Auth/login/auth_cubit.dart';
import 'package:akunku/bloc/Auth/otp/otp_cubit.dart';
import 'package:akunku/bloc/Timer/timer_count_cubit.dart';
import 'package:akunku/bloc/auth_form/otp_form/otp_form_cubit.dart';
import 'package:akunku/compound/compound.dart';
import 'package:akunku/extension/string_validate.dart';
import 'package:akunku/model/Otp/otp_field_data.dart';
import 'package:akunku/model/common.dart';
import 'package:akunku/repository/sending_otp/otp.dart';
import 'package:akunku/repository/sending_otp/otp_repository.dart';
import 'package:akunku/widget/base_widget.dart';
import 'package:akunku/widget/showtoast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

@RoutePage()
class OtpScreenRegister extends StatelessWidget {
  final String? email;
  const OtpScreenRegister(this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    final BaseSendsOtp otpRepository = OtpRepository();
    return RepositoryProvider.value(
      value: otpRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => OtpTimerCubit()..startTimer()),
          BlocProvider(create: (context) => OtpFormCubit()),
          BlocProvider(create: (context) => OtpCubit(otpRepository)),
        ],
        child: OtpScreen(email),
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  final String? email;

  const OtpScreen(this.email, {super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? isErrmsg;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            _buildHeaderBackground(),
            SizedBox(height: 20.h),
            _buildOtpInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return IconButton(
      iconSize: 25,
      color: Colors.black,
      onPressed: () {
        context.pop();
      },
      icon: const Icon(Icons.arrow_back, color: Colors.black),
    );
  }

  Widget _buildOtpInput() {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, otpstate) {
        if (otpstate is OtpSuccses) {
          context.replaceRoute(LoginRouteRoute());

          Future.delayed(Duration(microseconds: 200));
          {
            showCustomToast(context, otpstate.data, Colors.greenAccent);
          }
        }

        if (otpstate is OtpError) {
          setState(() {
            isErrmsg = otpstate.msg;
          });
        }
      },
      child: BlocBuilder<OtpFormCubit, OtpFormState<OtpFieldData>>(
        builder: (context, stateData) {
          return Padding(
            padding: EdgeInsets.only(left: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cek Email Kamu',
                  style: TextStyle(
                    fontFamily: "Dm Sans Semibold",
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Text.rich(
                  TextSpan(
                    text: 'Kode OTP sudah dikirim ke',
                    style: TextStyle(
                      fontFamily: "Dm Sans Regular",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    children: [
                      WidgetSpan(child: SizedBox(width: 2.w)),
                      TextSpan(
                        text: '${widget.email}\n',
                        style: TextStyle(
                          fontFamily: "Dm Sans Semibold",
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                      ),

                      TextSpan(
                        text: 'Masukkan untuk verifikasi akunmu.',
                        style: TextStyle(
                          fontFamily: "Dm Sans Regular",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      context.read<OtpFormCubit>().onChangeOtp(
                        stateData.data!,
                        value,
                      );
                    },

                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(20),
                      fieldHeight: 55.h,
                      fieldWidth: 50.w,
                      activeColor: Colors.blue,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                      errorBorderColor: Colors.red,
                    ),
                  ),
                ),
                ErrorTextFormField(
                  error: isErrmsg ?? stateData.data!.otp.validateOtpNumber,
                ),
                SizedBox(height: 20.h),
                BlocBuilder<OtpTimerCubit, int>(
                  builder: (context, state) {
                    if (state > 0) {
                      if (state >= 60) {
                        int minutes =
                            state ~/ 60; // Operator ~/ untuk pembagian integer

                        return Text(
                          "Kirim ulang dalam $minutes menit",
                          style: TextStyle(
                            fontFamily: "DM Sans Semibold",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      } else {
                        return Text.rich(
                          TextSpan(
                            text: "Belum dapat kodenya?",
                            style: TextStyle(
                              fontFamily: "DM Sans Semibold",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                            ),
                            children: [
                              TextSpan(
                                text: "Kirim ulang",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 15.sp,
                                  fontFamily: "DM Sans Semibold",
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 50.h),
                _buildOntapVerification(stateData.data!.otp),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOntapVerification(String? otp) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, stateOtp) {
        return BlocSelector<
          OtpFormCubit,
          OtpFormState<OtpFieldData>,
          FormFieldData
        >(
          selector: (state) => FormFieldData(
            validate: [state.data!.otp],

            validateForm: [state.data!.otp.validateOtpNumber],
          ),

          builder: (context, validastate) {
            final isloading = stateOtp is OtpLoading;
            return buttonLoginTap(
              onTap: () {
                validastate.hasEmptyField || validastate.hasInvalidField
                    ? ""
                    : context.read<OtpCubit>().sendsOtp(widget.email!, otp!);
              },
              size,
              text: isloading ? "" : "Verifikasi",

              colorbtn:
                  validastate.hasEmptyField ||
                      validastate.hasInvalidField ||
                      isloading
                  ? Colors.grey.shade300
                  : Colors.blue,
              validastate.hasEmptyField ||
                      validastate.hasInvalidField ||
                      isloading
                  ? Colors.grey.shade300
                  : Colors.blue,
              textColor:
                  validastate.hasEmptyField && validastate.hasInvalidField ||
                      isloading
                  ? Colors.black
                  : Colors.white,
              child: isloading
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
    );
  }
}
