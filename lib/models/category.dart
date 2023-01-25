import 'package:custom_from_widget/models/chip.dart';

class ChipCategory {
  String? catId;
  List<ParentChip>? parentChips;
  String? catName;

  ChipCategory({
    required this.catName,
    required this.catId,
    required this.parentChips,
  });
}
