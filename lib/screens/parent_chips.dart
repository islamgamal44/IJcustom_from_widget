// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:custom_from_widget/constants/app_constants.dart';
import 'package:custom_from_widget/models/chip.dart';
import 'package:custom_from_widget/models/sub_chip.dart';
import 'package:custom_from_widget/provider/data_provider.dart';
import 'package:custom_from_widget/screens/sub%20Chips.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../componentes.dart';
import '../models/category.dart';

class StateOne extends StatefulWidget {
  const StateOne({Key? key}) : super(key: key);

  @override
  State<StateOne> createState() => _StateOneState();
}

class _StateOneState extends State<StateOne> {
  TextEditingController textarea = TextEditingController();
  var id = Uuid();

  bool isLoading = true;
  ChipCategory? initCat;
  bool deleteMode = false;
  bool updateMode = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    // dataProvider.getInitCat();

    if (!mounted) return;
    ChipCategory? cat = dataProvider.getFirstCat;
    setState(() {
      isLoading = false;
    });
    initCat = cat;
  }

  Future<void> _showAlertDialogAddNewChip({
    bool? isUpdate = false,
    ParentChip? chipToUpdate,
  }) async {
    final controller = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        controller.text = chipToUpdate != null ? chipToUpdate.name! : "";

        return AlertDialog(
          // <-- SEE HERE
          title: const Text(AppConstants.addNewChip),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      label: Text(
                    AppConstants.chipName,
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                fetchData();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                if (isUpdate!) {
                  ParentChip updatedChip = ParentChip(
                    id: chipToUpdate!.id,
                    name: controller.text.trim(),
                    subChipList: chipToUpdate.subChipList,
                  );

                  Provider.of<DataProvider>(context, listen: false)
                      .updateParentChip(updatedChip);
                } else {
                  ParentChip newChip = ParentChip(
                    id: id.v1(),
                    name: controller.text.trim(),
                    subChipList: [
                      SubChipList.empty(id.v1()),
                    ],
                  );

                  Provider.of<DataProvider>(context, listen: false)
                      .addParentChip(newChip);
                }
                fetchData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final double spacing = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    buildCategoryButton(
                      context: context,
                      labelText: initCat!.catName!,
                      onTap: fetchData,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          updateParentWidgets(
                            title: AppConstants.addNewChip,
                            icon: Icons.add,
                            onPressed: _showAlertDialogAddNewChip,
                          ),
                          updateParentWidgets(
                            title: AppConstants.deleteChip,
                            icon: Icons.remove,
                            onPressed: () => setState(() {
                              deleteMode = !deleteMode;
                            }),
                          ),
                          updateParentWidgets(
                            title: AppConstants.updateChip,
                            icon: Icons.edit,
                            onPressed: () => setState(() {
                              updateMode = !updateMode;
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildChoiceChips(),
                    SizedBox(
                      height: 30,
                    ),
                    buildOptionalChildWidget(),
                    SizedBox(
                      height: 30,
                    ),
                    buildTextFieldWidget()
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildChoiceChips() {
    return Wrap(
      runSpacing: spacing,
      spacing: spacing,
      children: initCat!.parentChips!
          .map(
            (parentChip) => Stack(
              children: [
                InkWell(
                  onTap: () async {
                    String? response = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SubChipsScreen(
                          parentChip: parentChip,
                        ),
                      ),
                    );
                    if (response == "updateUI") {
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          parentChip.name!,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        if (parentChip.subChipList.length > 1)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "(${parentChip.subChipList.length.toString()})",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (deleteMode)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        onPressed: () {
                          Provider.of<DataProvider>(context, listen: false)
                              .deleteParentChip(parentChip);
                          fetchData();

                          setState(() {
                            deleteMode = false;
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                if (updateMode)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        onPressed: () => _showAlertDialogAddNewChip(
                          isUpdate: true,
                          chipToUpdate: parentChip,
                        ),
                        icon: Icon(
                          Icons.edit,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildTextFieldWidget() => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: Colors.black54,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textAlign: TextAlign.center,
              controller: textarea,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Label Text ...",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ),
      );
}
