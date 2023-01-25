// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildCategoryButton(
        {required String labelText, void Function()? onTap}) =>
    InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
            child: Text(
              labelText,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );

Widget buildOptionalChildWidget() => InkWell(
      onTap: () {},
      child: Container(
        height: 35,
        width: 250,
        decoration: BoxDecoration(color: Colors.amberAccent),
        child: Center(
          child: Text(
            "Optional Child Widget",
            style: GoogleFonts.rubik(
                textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  required String labelText,
  String? Function(String?)? validator,
  Icon? prefixIcon,
  Icon? suffixIcon,
  ValueChanged<String>? onSubmit,
  Function(String)? onChange,
  bool obscureText = false,
  VoidCallback? suffixFun,
  Function()? onTap,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 35, left: 35),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TextFormField(
          textAlign: TextAlign.center,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            // alignLabelWithHint: true,
            hintText: labelText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.black54, width: 1)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.black54, width: 1)),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: suffixIcon,
                    onPressed: suffixFun,
                  )
                : null,
          ),
          keyboardType: keyboardType,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          onTap: onTap,
          obscureText: obscureText,
        ),
      ),
    );

Widget defaultSubChip({
  required String title,
}) =>
    Column(
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
                  title,
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
    );
