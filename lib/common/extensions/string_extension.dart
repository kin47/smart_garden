extension StringExtension on String? {
  static const int maxLengthPrefixEmail = 64;
  static const int maxLengthSuffixEmail = 255;

  String get formatPrice => this!.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );

  bool get isValidPassword {
    if (this == null || this!.isEmpty) return false;
    return RegExp(
      r'''^(?!.*\s)(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[.?_!@#%&/]).{8,}$''',
    ).hasMatch(this!.trim());
  }

  bool get isValidEmail {
    if (this == null || this!.isEmpty) return false;
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this!.trim()) &&
        isValidLengthEmail;
  }

  bool get isValidLengthEmail {
    if (this == null || this!.isEmpty) return false;
    if (this!.contains("@")) {
      return this!.trim().split("@")[0].length <= maxLengthPrefixEmail &&
          this!.trim().split("@")[1].length <= maxLengthSuffixEmail;
    } else {
      return false;
    }
  }

  String get userEmail {
    if (this == null || this!.isEmpty) return '';
    return '${this!.trim().split("@")[0]}_user@${this!.trim().split("@")[1]}';
  }

  String get username {
    if (this == null || this!.isEmpty) return '';
    return this!.trim().split("@")[0];
  }
}
