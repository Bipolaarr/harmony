import 'package:flutter/material.dart';



class BasicAppButton extends StatelessWidget{

  final VoidCallback onPressed;
  final String title;
  final double ? height;

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    super.key}
    ); 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size.fromHeight(height ?? 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        // side: BorderSide(
        //   color: Colors.black, 
        //   width: 1,
        // ),
      ),
      onPressed: onPressed, 
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'SF Pro Rounded',
          fontWeight: FontWeight.bold, 
          color: Colors.black, 
          fontSize: 24
        ), 
      )
    );
  }

}