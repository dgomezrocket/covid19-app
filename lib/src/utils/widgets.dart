import 'package:flutter/material.dart';

createCircularProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

createLoader() {
  return new Container(
    child: new Padding(
      padding: const EdgeInsets.all(5.0),
      child: createCircularProgressIndicator(),
    ),
  );
}
