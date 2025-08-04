extension StringExtensions on String? {
  String? get nullIfBlank {
    if (this == null || this!.trim().isEmpty) return null;
    return this;
  }
}

void logShouldNeverBeReached([dynamic value]) {
  // TODO: Implement proper logging
}
