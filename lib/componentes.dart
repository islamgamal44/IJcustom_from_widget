// ignore_for_file: prefer_const_constructors

import 'package:custom_from_widget/constants/app_constants.dart';
import 'package:custom_from_widget/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> _showAlertDialogToUpdateCateName(
  BuildContext context,
  VoidCallback update,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      final controller = TextEditingController();

      return AlertDialog(
        // <-- SEE HERE
        title: const Text(AppConstants.updateCatName),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  label: Text(
                    AppConstants.catName,
                  ),
                ),
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
              Provider.of<DataProvider>(context, listen: false)
                  .changeCatName(controller.text);
              update();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget buildCategoryButton({
  required BuildContext context,
  required String labelText,
  required VoidCallback onTap,
}) =>
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  labelText,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _showAlertDialogToUpdateCateName(context, onTap),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
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
                fontWeight: FontWeight.bold,
              ),
            ),
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

Widget defaultAddButton() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 60,
            width: 220,
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Additional Sub \nChip 1n',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                )),
              ),
            )),
        SizedBox(
          width: 5,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.black54,
              size: 45,
            ))
      ],
    );

Widget defaultButton({
  Color? buttonColor,
  required Function() buttonFunction,
  required String buttonText,
}) =>
    Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: buttonColor),
      child: MaterialButton(
        onPressed: buttonFunction,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget updateParentWidgets({
  required String title,
  required IconData icon,
  required void Function()? onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            title,
          ),
        ),
      ],
    ),
  );
}
