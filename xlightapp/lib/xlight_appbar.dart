import 'package:flutter/material.dart';

AppBar getXLightAppBar(String title, [List<Widget> actions = const []]) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    actions: actions,
  );
}
