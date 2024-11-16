int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTime = wordCount / 238;
  return readingTime.ceil();
}
