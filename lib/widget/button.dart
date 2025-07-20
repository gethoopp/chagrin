import 'package:akunku/extension/string_validate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonLogin(
  Size size, {
  required String text,
  required bool obs,
  required TextEditingController controll,
  required String? Function(String)? validator, // Callback untuk validasi
  required String? Function(String)? onChanged,
  TextInputType? textInput, // calllback untuk onchanged function
}) {
  return SizedBox(
    width: size.width * 0.85,
    child: TextFormField(
      onChanged: onChanged,
      controller: controll,
      obscureText: obs,
      keyboardType: textInput,
      decoration: InputDecoration(
        errorText: validator?.call(controll.text), // Panggil fungsi validasi
        focusColor: Colors.blue[600],
        hoverColor: Colors.blue[600],
        fillColor: Colors.blue[600],
        labelText: text,
        labelStyle: GoogleFonts.outfit(fontSize: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}

SizedBox buttonLoginTap(
  Size size,
  Color? colorbtns, {
  required String text,
  required Color colorbtn,
  required Color textColor,
  Function()? onTap,
  Widget? child,
}) {
  return SizedBox(
    width: double.infinity,
    height: size.height * 0.06,
    child: TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(colorbtn),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: colorbtns ?? Colors.blue),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      child:
          child ??
          Text(
            text,

            style: TextStyle(
              color: textColor,
              fontFamily: "DM Sans Regular",
              fontWeight: FontWeight.w300,
            ),
          ),
    ),
  );
}

// Helper widget untuk membuat text field umum
Widget buildTextField({
  // required TextEditingController controller,
  required String label,
  required String hint,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontFamily: "DM Sans Semibold",
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        // controller: controller,
        onChanged: onChanged,
        validator: (value) => value.validateEmail,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: "DM Sans Regular",
            fontWeight: FontWeight.w200,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    ],
  );
}

// Helper widget khusus untuk password field
Widget buildPasswordField({
  // required TextEditingController controller,
  required bool isPassowrdVisible,
  void Function(String)? onChanged,
}) {
  return StatefulBuilder(
    builder: (BuildContext, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kata Sandi',
            style: TextStyle(
              fontFamily: "DM Sans Semibold",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            onChanged: onChanged,

            obscureText: !isPassowrdVisible,
            decoration: InputDecoration(
              hintText: 'Masukkan kata sandi kamu',
              hintStyle: TextStyle(
                fontFamily: "DM Sans Regular",
                fontWeight: FontWeight.w200,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isPassowrdVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPassowrdVisible = !isPassowrdVisible;
                  });
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
