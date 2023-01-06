import 'package:flutter/material.dart';

enum BottomTab {
  gifts('Подарки', Icons.card_giftcard),
  peoples('Люди', Icons.people),
  settings('Настройки', Icons.settings);

  const BottomTab(this.label, this.icon);

  final String label;
  final IconData icon;
}
