import 'package:doctr/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderChip extends StatelessWidget {
  final String headerText;
  final void Function(String type) onTap;
  const HeaderChip({Key? key, required this.onTap, required this.headerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(headerText),
      child: Container(
        decoration: const BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            headerText,
            style: GoogleFonts.ptSans(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
