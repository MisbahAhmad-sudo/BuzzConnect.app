import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color color;
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
            child: Text(
          text,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,),
        )),
      ),
    );
  }
}
