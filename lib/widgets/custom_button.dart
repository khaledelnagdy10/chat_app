import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key, required this.text,  this.onTap,});
  final String text;
   void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     
     onTap: onTap ,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Text(text,
                    style: const TextStyle(fontSize: 23, color: Colors.black))),
          )),
    );
  }
}
