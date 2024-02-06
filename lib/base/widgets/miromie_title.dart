import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiromieTitle extends StatelessWidget {
  final double fontSize;
const MiromieTitle({ Key? key, required this.fontSize }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Text(
      "miromie",
      style: GoogleFonts.barlow(
          textStyle: TextStyle(
              fontSize: fontSize,
              color: const Color(
                0xFF6EC6CA,
              ),
              fontWeight: FontWeight.w700)),
    );
  }
}