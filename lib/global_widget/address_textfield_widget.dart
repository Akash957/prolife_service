
import 'package:flutter/material.dart';

Widget addressTextFieldWidget(
    {required TextEditingController controller,
    required String hintText,
    required String label,
    TextInputType? inputType,
    bool isRequired = false
    }) {
    return TextFormField(
        controller:  controller,
        keyboardType: inputType,
        decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey,width: 2)
            ),
        ),
        validator: (value) {
          if(isRequired && (value == null || value.trim().isEmpty)){
              return '$label is required';
          }
          return null;
        },
    );
}
