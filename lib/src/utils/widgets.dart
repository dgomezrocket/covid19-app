import 'package:flutter/material.dart';

Widget createCircularProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget createLoader() {
  return Container(
    color: Colors.blue[100]?.withOpacity(0.4),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: createCircularProgressIndicator(),
    ),
  );
}
