import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArchivedPage extends StatelessWidget {
  const ArchivedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('Welcome to archived page!',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
      
      ),
    );
  }
}