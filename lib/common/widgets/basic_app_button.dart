import 'package:flutter/material.dart';



class BasicAppButton extends StatelessWidget{

  final VoidCallback onPressed;
  final String title;
  final double ? height;
  final double ? width;

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    super.key}
    ); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200, // Set your desired width
      height: height ?? 60, // Set your desired height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: onPressed, 
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'SF Pro Rounded',
            fontWeight: FontWeight.bold, 
            color: Colors.black, 
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}



