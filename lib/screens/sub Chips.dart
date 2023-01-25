// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:custom_from_widget/models/chip.dart';
import 'package:custom_from_widget/models/sub_chip.dart';
import 'package:custom_from_widget/screens/sub_list_widget/sub_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';
import '../provider/data_provider.dart';

class SubChipsScreen extends StatefulWidget {
  final ParentChip parentChip;
  const SubChipsScreen({
    Key? key,
    required this.parentChip,
  }) : super(key: key);

  @override
  State<SubChipsScreen> createState() => _SubChipsScreenState();
}

class _SubChipsScreenState extends State<SubChipsScreen> {
  late ParentChip parentChip;
  late List<SubChipList> subChipList;
  var id = Uuid();
  bool deleteMode = false;
  bool updateMode = false;
  bool isLoading = true;
  @override
  void initState() {
    parentChip = widget.parentChip;
    fetchData(parentChip.id!);
    super.initState();
  }

  void fetchData(String parentId) async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    // dataProvider.getInitCat();

    if (!mounted) return;
    List<SubChipList> cat = dataProvider.getParentSubList(parentId);
    setState(() {
      isLoading = false;
    });
    subChipList = cat;
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
          title: const Text(AppConstants.addSubChip),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      label: Text(
                    AppConstants.subChipName,
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                if (isUpdate!) {
                } else {
                  SubChipList newSubChip = SubChipList(
                    subName: controller.text,
                    subId: id.v1(),
                    txtList: ["", "", ""],
                  );
                  setState(() {
                    subChipList.add(newSubChip);
                  });
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop("updateUI");
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("SubList for ${parentChip.name} "),
        actions: [
          IconButton(
            onPressed: _showAlertDialogAddNewChip,
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: subChipList
                                .map(
                                  (subList) => Column(
                                    children: [
                                      SubChipWidget(
                                        key: ValueKey(subList.subId),
                                        subChipList: subList,
                                        parentId: parentChip.id!,
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color?>(
                                              Colors.red,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              isLoading = true;
                                              int index = subChipList
                                                  .indexWhere((element) =>
                                                      element.subId ==
                                                      subList.subId);

                                              Provider.of<DataProvider>(context,
                                                      listen: false)
                                                  .deleteSubChip(
                                                      parentChip.id!, subList);
                                              fetchData(parentChip.id!);
                                            });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Delete"),
                                              Icon(Icons.delete)
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: ElevatedButton(
      //           onPressed: () {
      //             Provider.of<DataProvider>(context, listen: false)
      //                 .updateSubChipList(parentChip.id!, subChipList);
      //           },
      //           child: Text("Save"),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
