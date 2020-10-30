import 'package:flutter/material.dart';

createCircularProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

createLoader() {
  return Container(
    color: Colors.blue[100].withOpacity(0.4),
    child: new Padding(
      padding: const EdgeInsets.all(5.0),
      child: createCircularProgressIndicator(),
    ),
  );
}
