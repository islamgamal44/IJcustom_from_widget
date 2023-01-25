// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:custom_from_widget/modules/sub%20Chips.dart';
import 'package:flutter/material.dart';

import '../data/core/componentes.dart';

class StateOne extends StatefulWidget {
  const StateOne({Key? key}) : super(key: key);

  @override
  State<StateOne> createState() => _StateOneState();
}

class _StateOneState extends State<StateOne> {
  TextEditingController textarea = TextEditingController();
  final double spacing = 8;

  List<String> choiceChips = [
    "chip 1",
    "chip 2",
    "chip 3",
    "chip 4",
    "chip 5",
    "chip 6",
    "chip 7",
    "chip 8",
    "chip 9",
    "chip n",
  ];

  int _selected = 0;
  List<Widget> getList() {
    List<Widget> newlist = [];

    for (int i = 0; i < choiceChips.length; i++) {
      ChoiceChip newChip = ChoiceChip(
        selectedColor: Colors.blue[800],
        backgroundColor: Color(0xFF64B5F6),
        onSelected: (value) {
          if (value) {
            setState(() {
              _selected = i;
            });
          }

          switch (_selected) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SubChips()),
              );
              log("selected 1");
              break;
            case 1:
              log("selected 2");
              break;
            case 2:
              log("selected 3");
              break;
            case 3:
              log("selected 4");
              break;
            case 4:
              log("selected 5");
              break;
            case 5:
              log("selected 6");
              break;
            case 6:
              log("selected 7");
              break;
            case 7:
              log("selected 8");
              break;
            case 8:
              log("selected 9");
              break;
            case 9:
              log("selected n");
              break;
          }
        },
        label: Text(choiceChips[i]),
        selected: _selected == i,
      );
      newlist.add(newChip);
    }
    return newlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildCategoryButton(labelText: 'Category 1'),
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
      children: getList(),
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
