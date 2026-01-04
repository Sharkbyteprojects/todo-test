import 'package:flutter/material.dart';
import 'world_of_elements/settings.dart';
import 'world_of_elements/listitem.dart';

class DSTbar {
  const DSTbar(this.label, this.icon, this.selectedIcon, this.toEnter, this.badge);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final Widget toEnter;
  final bool badge;
}

List<DSTbar> destinations = <DSTbar>[ 
  DSTbar('ToDo', Icon(Icons.list_outlined), Icon(Icons.list), ListEle(), true),
  DSTbar('Settings', Icon(Icons.settings_outlined), Icon(Icons.settings), Settings(), false),
];
