import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget{

  const BasicAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            shape: BoxShape.circle
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 15,
            color: Colors.white,
          )
        ),
        onPressed: () {
          Navigator.pop(context); 
        },
      ),
    ); 
  }

}