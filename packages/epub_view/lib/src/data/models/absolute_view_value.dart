export 'package:epubx/epubx.dart' hide Image;

class AbsoluteViewValue {
  const AbsoluteViewValue({
    required this.itemIndex,
    required this.itemLeadingEdge,
    required this.itemTrailingEdge,
  });

  final int itemIndex;
  final double itemLeadingEdge;
  final double itemTrailingEdge;

  bool isGreater(AbsoluteViewValue other) {
    if (itemIndex > other.itemIndex) {
      return true;
    } else if (itemIndex == other.itemIndex) {
      if ((itemLeadingEdge * 10).floor() < (other.itemLeadingEdge * 10).floor()) {
        return true;
      }
    }
    return false;
  }

  Map<String, dynamic> toJson() => {
        'itemIndex': itemIndex,
        'itemLeadingEdge': itemLeadingEdge,
        'itemTrailingEdge': itemTrailingEdge,
      };

  @override
  String toString() => 'itemIndex: $itemIndex, itemLeadingEdge: $itemLeadingEdge, itemTrailingEdge: $itemTrailingEdge';

  factory AbsoluteViewValue.fromJson(Map<String, dynamic> json) => AbsoluteViewValue(
        itemIndex: json['itemIndex'] as int,
        itemLeadingEdge: json['itemLeadingEdge'] as double,
        itemTrailingEdge: json['itemTrailingEdge'] as double,
      );
}
