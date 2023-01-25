import 'dart:developer';

import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically
import 'package:custom_from_widget/models/category.dart';
import 'package:custom_from_widget/models/chip.dart';
import 'package:custom_from_widget/models/sub_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class DataProvider with ChangeNotifier {
  var uuid = const Uuid();

  ChipCategory? _initCat;

  int xId = 1;
  String yId = "A";

  void getInitCat() {
    final initCat = ChipCategory(
      catName: "Category Name",
      catId: uuid.v1(),
      parentChips: [
        ParentChip(
          id: uuid.v1(),
          name: "Chip 1",
          subChipList: [
            SubChipList.empty(uuid.v1()),
          ],
        ),
      ],
    );
    _initCat = initCat;
    notifyListeners();
  }

  void changeCatName(String name) {
    _initCat!.catName = name;
    notifyListeners();
  }

  void addParentChip(ParentChip addChip) {
    _initCat!.parentChips!.add(addChip);
    log(addChip.toString());
    notifyListeners();
  }

  void deleteParentChip(ParentChip delChip) {
    log(delChip.toString());
    int delIndex = _initCat!.parentChips!
        .indexWhere((parentChip) => parentChip.id == delChip.id);
    log(delIndex.toString());
    _initCat!.parentChips!.removeAt(delIndex);
    notifyListeners();
  }

  void updateParentChip(ParentChip updatedChip) {
    log(updatedChip.toString());
    int updatedIndex = _initCat!.parentChips!
        .indexWhere((parentChip) => parentChip.id == updatedChip.id);

    log(updatedIndex.toString());

    _initCat!.parentChips![updatedIndex] = updatedChip;
    notifyListeners();
  }

  void addOrUpdateSubChip(String parentId, SubChipList subChip) {
    int index =
        _initCat!.parentChips!.indexWhere((element) => element.id == parentId);

    final isExistSubChip = _initCat!.parentChips![index].subChipList
        .firstWhereOrNull((element) => element.subId == subChip.subId);

    if (isExistSubChip == null) {
      log("test add ");
      _initCat!.parentChips![index].subChipList.add(subChip);
    } else {
      log("test update ");

      final subChipIndex = _initCat!.parentChips![index].subChipList
          .indexWhere((element) => element.subId == subChip.subId);
      _initCat!.parentChips![index].subChipList[subChipIndex] = subChip;
    }

    notifyListeners();
  }

  void deleteSubChip(String parentId, SubChipList subChip) {
    int index =
        _initCat!.parentChips!.indexWhere((element) => element.id == parentId);
    final subChipIndex = _initCat!.parentChips![index].subChipList
        .indexWhere((element) => element.subId == subChip.subId);

    _initCat!.parentChips![index].subChipList.removeAt(subChipIndex);
    notifyListeners();
  }

  void updateSubChipList(String parentId, List<SubChipList> subChipList) {
    log(subChipList.toString());
    int index =
        _initCat!.parentChips!.indexWhere((element) => element.id == parentId);

    _initCat!.parentChips![index].subChipList = subChipList;

    notifyListeners();
  }

  List<SubChipList> getParentSubList(String parentId) {
    int index =
        _initCat!.parentChips!.indexWhere((element) => element.id == parentId);

    log(_initCat!.parentChips![index].subChipList.length.toString());
    return _initCat!.parentChips![index].subChipList;
  }

  ChipCategory? get getFirstCat => _initCat;
}
