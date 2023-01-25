class SubChipList {
  final String? subId;
  final List<String>? txtList;

  String? subName;

  SubChipList({
    required this.subName,
    required this.subId,
    required this.txtList,
  });
  factory SubChipList.empty(String id) => SubChipList(
        subId: id,
        txtList: ["", "", ""],
        subName: "SubList 1A",
      );

  @override
  String toString() => {
        "subId": subId,
        "subName": subName,
        "txtList": txtList,
      }.toString();
}
