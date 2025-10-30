int calculateReadingTime(String content) {
  final wordCount = content.trim().split(RegExp(r'\s+')).length;
  final readingTimeMinutes = (wordCount / 200).ceil();
  return readingTimeMinutes;
}
