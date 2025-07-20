import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAutoCloseDialog(BuildContext context, String message) {
  Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: AlertDialog(
      content: Text(
        message,
        style: TextStyle(fontFamily: "DM Sans Bold", fontSize: 15.sp),
      ),
      backgroundColor: Colors.grey,
    ),
  );
}
