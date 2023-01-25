import 'package:custom_from_widget/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../componentes.dart';
import '../../models/sub_chip.dart';

class SubChipWidget extends StatefulWidget {
  final SubChipList subChipList;
  final String parentId;
  // final  retrieveDate;
  const SubChipWidget({
    super.key,
    required this.subChipList,
    required this.parentId,
    // required this.retrieveDate,
  });

  @override
  State<SubChipWidget> createState() => _SubChipWidgetState();
}

class _SubChipWidgetState extends State<SubChipWidget> {
  late SubChipList subChipList;
  final textField1 = TextEditingController();
  final textField2 = TextEditingController();
  final textField3 = TextEditingController();

  @override
  void initState() {
    subChipList = widget.subChipList;
    getData();
    super.initState();
  }

  void getData() {
    for (int i = 0; i < subChipList.txtList!.length; i++) {
      switch (i) {
        case 0:
          textField1.text = subChipList.txtList![i];
          break;
        case 1:
          textField2.text = subChipList.txtList![i];
          break;
        case 2:
          textField3.text = subChipList.txtList![i];
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            height: 35,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                subChipList.subName!,
                style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          defaultTextFormField(labelText: "label text", controller: textField1),
          defaultTextFormField(labelText: "label text", controller: textField2),
          defaultTextFormField(labelText: "label text", controller: textField3),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                      Colors.green,
                    ),
                  ),
                  onPressed: () {
                    SubChipList newSubList = SubChipList(
                        subName: subChipList.subName,
                        subId: subChipList.subId,
                        txtList: [
                          textField1.text,
                          textField2.text,
                          textField3.text
                        ]);

                    Provider.of<DataProvider>(context, listen: false)
                        .addOrUpdateSubChip(widget.parentId, newSubList);
                  },
                  child: const Text(
                    "Save",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
