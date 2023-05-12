import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    required BuildContext context,
    required super.content,
    super.key,
  }) : super(
          backgroundColor: Theme.of(context).colorScheme.background,
        );
}
