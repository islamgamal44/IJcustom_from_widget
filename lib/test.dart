// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:custom_from_widget/componentes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Center(
                        child: Text(
                          "Sub Chip 1A",
                          style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
                defaultTextFormField(labelText: "label text"),
                defaultTextFormField(labelText: "label text"),
                defaultTextFormField(labelText: "label text"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
