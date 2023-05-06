import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> plantDropdownItems = <String>[
  'Cassava (Kappa)',
  'Coconut (Thenga)',
].map<DropdownMenuItem<String>>((String value) {
  return DropdownMenuItem<String>(
    value: value,
    child: Text(
      value,
      style: const TextStyle(color: Colors.white),
    ),
  );
}).toList();
