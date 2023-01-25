// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:custom_from_widget/data/core/componentes.dart';
import 'package:flutter/material.dart';

class SubChips extends StatefulWidget {
  const SubChips({Key? key}) : super(key: key);

  @override
  State<SubChips> createState() => _TestState();
}

class _TestState extends State<SubChips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                defaultSubChip(title: "Sub Chip "),
                SizedBox(height: 20),
                defaultAddButton(),
                SizedBox(height: 20),
                defaultSubChip(title: "Sub Chip "),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultButton(
                        buttonFunction: () {},
                        buttonText: 'Save',
                        buttonColor: Colors.green[800]),
                    SizedBox(
                      width: 5,
                    ),
                    defaultButton(
                        buttonFunction: () {},
                        buttonText: 'Delete',
                        buttonColor: Colors.red[800]),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
