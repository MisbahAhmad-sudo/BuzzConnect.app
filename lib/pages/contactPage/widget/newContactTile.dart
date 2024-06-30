import 'package:flutter/material.dart';

class newContactTile extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final VoidCallback ontap;
  const newContactTile({super.key, required this.btnName,  required this.icon, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: [
              Container(
                height: 70,
                width: 70,
                child: Icon(icon, size: 30,),
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(width: 20,),
              Text(btnName, style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
        ),
      ),
    );
  }
}
