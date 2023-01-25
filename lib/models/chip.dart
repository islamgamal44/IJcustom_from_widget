import 'package:custom_from_widget/models/sub_chip.dart';

class ParentChip {
  String? id;
  List<SubChipList> subChipList;

  String? name;

  ParentChip({
    required this.id,
    required this.name,
    required this.subChipList,
  });

  @override
  String toString() => {
        "id": id,
        "name": name,
      }.toString();
}
