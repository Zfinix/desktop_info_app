import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

themeData(context) => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.teal,
      textTheme: GoogleFonts.ubuntuTextTheme(
        Theme.of(context).textTheme,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
