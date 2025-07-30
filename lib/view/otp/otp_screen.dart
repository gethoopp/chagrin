import 'package:akunku/bloc/Timer/timer_count_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class OtpScreenRegister extends StatelessWidget {
  final String? email;
  const OtpScreenRegister(this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpTimerCubit()..startTimer(),
      child: OtpScreen(email),
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
              children: [TextSpan(text: '${widget.email}')],
            ),
          ),
        ],
      ),
    );
  }
}
