import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ErrorTextFormField extends StatelessWidget {
  String? error;
  final bool showIcon;
  final double iconSize;
  final double fontSize;
  final double marginTop;
  int? lengthText;

  ErrorTextFormField({
    super.key,
    this.error,
    this.lengthText,
    this.showIcon = true,
    this.iconSize = 26,
    this.fontSize = 13,
    this.marginTop = 0,
  });

  @override
  Widget build(BuildContext context) {
    return error != null && error!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: marginTop),
                Row(
                  children: [
                    //bisa ditambah asset gambar
                    // if (showIcon)
                    //   Image(
                    //     image: const AssetImage(),
                    //     width: 18.w,
                    //     height: 16.h,
                    //   ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 5.h),
                      child: Text(
                        error!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: "DM Sans Regular",
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

// ignore: must_be_immutable
class ErrorTextFormFieldProfileName extends StatelessWidget {
  String? error;
  final bool showIcon;
  final double iconSize;
  final double fontSize;
  final double marginTop;
  int? lengthText;

  ErrorTextFormFieldProfileName({
    super.key,
    this.error,
    this.lengthText,
    this.showIcon = true,
    this.iconSize = 26,
    this.fontSize = 13,
    this.marginTop = 0,
  });

  @override
  Widget build(BuildContext context) {
    return lengthText! == 23 || lengthText! <= 4
        ? Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: marginTop),
                Row(
                  children: [
                    if (showIcon)
                      Image(
                        image: const AssetImage('assets/icons/warning.png'),
                        width: 18.w,
                        height: 16.h,
                      ),

                    // Expanded(
                    //   child: Text(
                    //     error!,
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 2,
                    //     style: DartDroidFonts.normal(
                    //       color: DartdroidColor.redDarken40,
                    //       fontSize: fontSize,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
