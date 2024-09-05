export 'package:epubx/epubx.dart' hide Image;

class ParagraphViewport {
  const ParagraphViewport({
    required this.itemIndex,
    required this.content,
    required this.screenCoverage,
  });

  final int itemIndex;
  final String content;
  final double screenCoverage;

  Map<String, dynamic> toJson() => {
        'itemIndex': itemIndex,
        'content': content,
        'screenCoverage': screenCoverage,
      };

  @override
  String toString() => 'itemIndex: $itemIndex, content: $content, screenCoverage: $screenCoverage';

  factory ParagraphViewport.fromJson(Map<String, dynamic> json) => ParagraphViewport(
        itemIndex: json['itemIndex'] as int,
        content: json['content'] as String,
        screenCoverage: json['screenCoverage'] as double,
      );
}
