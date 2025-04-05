int calculateReadingTime(String content) {
  final words = content.split(RegExp(r'\s+')).length;

  return (words / 255).ceil();
}
