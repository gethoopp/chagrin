extension StringValidate on String? {
  String? get validateEmail {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Email tidak boleh kosong";
    }
    if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(this!)) {
      return "Format email tidak valid";
    }

    if (this!.length < 6) {
      return "Masukkan email dengan benar";
    }

    return null;
  }

  String? get validatePassword {
    if (this == null) {
      return null;
    }
    if (this!.length < 6) {
      return "Password harus lebih dari 5 karakter";
    }
    return null;
  }

  String? validatePasswordCheck(String? originalPassword) {
    if (this == null) {
      return null;
    }
    if (this!.length < 6) {
      return "Password harus lebih dari 5 karakter";
    }
    if (this != originalPassword) {
      return "Password tidak sama";
    }
    return null;
  }

  String? getvalidateFirstName(int? minLength, int? maxLength) {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Nama Pengguna Minimal $minLength Karakter";
    }

    if (this!.length > maxLength!) {
      return "Nama Pengguna Maksimal $maxLength Karakter";
    }

    if (this!.contains(RegExp(r'\d'))) {
      return "Nama Pengguna tidak boleh mengandung angka";
    }
    if (this!.contains(RegExp(r'[@!#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh mengandung simbol";
    }

    if (this!.contains(RegExp(r'^[0-9]'))) {
      return "Nama Pengguna tidak boleh diawali dengan angka";
    }
    if (this!.contains(RegExp(r'^[A-Z]'))) {
      return "Nama Pengguna harus diawali dengan huruf kecil";
    }
    if (this!.contains(RegExp(r'^[!@#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh diawali dengan simbol";
    }

    return null;
  }

  String? validateLastName(int? minLength, int? maxLength) {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Nama Pengguna Minimal $minLength Karakter";
    }

    if (this!.length > maxLength!) {
      return "Nama Pengguna Maksimal $maxLength Karakter";
    }

    if (this!.contains(RegExp(r'\d'))) {
      return "Nama Pengguna tidak boleh mengandung angka";
    }
    if (this!.contains(RegExp(r'[@!#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh mengandung simbol";
    }

    if (this!.contains(RegExp(r'^[0-9]'))) {
      return "Nama Pengguna tidak boleh diawali dengan angka";
    }
    if (this!.contains(RegExp(r'^[A-Z]'))) {
      return "Nama Pengguna harus diawali dengan huruf kecil";
    }
    if (this!.contains(RegExp(r'^[!@#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh diawali dengan simbol";
    }

    return null;
  }

  String? validatePhoneNumber(int maxLength) {
    if (this == null) {
      return null;
    }

    if (this!.length <= 9) {
      return "Nomor harus lebih dari 9 karakter";
    }

    if (this!.isEmpty) {
      return "Nomor tidak boleh kosong";
    }

    if (!this!.startsWith('8')) {
      return "Nomor harus diawali angka 8";
    }

    if (this!.length > maxLength) {
      return "Maksimal 12 karakter";
    }

    return null;
  }

  String? get validatePhoneNumberPrefix {
    if (this == null) {
      return null;
    }

    return null;
  }
}
