import 'package:flutter/material.dart';

class ShoppableIcon extends StatelessWidget {
  final double size;
const ShoppableIcon({ Key? key, required this.size }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.45)
        ),
        child: Icon(Icons.shopping_bag_outlined, size: size, color: Colors.white,),
      ),
    );
  }
}