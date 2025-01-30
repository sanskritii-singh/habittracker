import 'package:flutter/material.dart';
class MyfloatingActionButton extends StatelessWidget {
  final Function()? onPressed;
  const MyfloatingActionButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed:onPressed,
    child: const Icon(Icons.add),);
  }
}
