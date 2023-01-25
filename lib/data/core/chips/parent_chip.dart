import 'package:custom_from_widget/data/core/chips/sub_chip.dart';

class ParentChip {
  late final String id;
  late final String name;
  late final List<SubChip> subChip;

  ParentChip({
    required this.id,
    required this.name,
    required this.subChip,
  });
}
