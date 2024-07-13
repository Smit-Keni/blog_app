int calculateReadingTime(String content){
  final wordCount = content.split(RegExp(r"\s")).length;

  final readingTime = wordCount / 250;
  return readingTime.ceil().toInt();
}