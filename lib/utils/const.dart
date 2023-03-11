import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justdoit/views/login_page.dart';

class AppColors {
  // Define the colors of the application

  static const darkBlue = Color(0xFF1A2937);
  static const aqua = Color(0xFF18B0AF);
  static const white = Color(0xFFF3FAFF);
  static const black = Color(0xFF00091A);
  static const lightGray = Color(0xFF647384);
  static const red = Color(0xFFc80815);

  static const profilePicColor = <Color>[
    Color(0xFF18B0AF),
    Color(0xFF118BCD),
    Color(0xFF6C70BF),
    Color(0xFFD881C7),
    Color(0xFF984F98),
    Color(0xFFA73060),
    Color(0xFF007B7B),
    Color(0xFF8B1B00),
    Color(0xFF8A9CDE),
    Color(0xFF5469A7),
    Color(0xFF9AA548),
    Color(0xFF006540),
    Color(0xFFEEE8A9),
    Color(0xFFA93700),
    Color(0xFF96F7B1),
    Color(0xFF5DBE7C),
    Color(0xFF20884A),
  ];
}

class AppRoutes {
  static const loginPage = '/';
  static const todoPage = '/todos';
}

class AppResources {
  static String defaultFont = GoogleFonts.poppins().fontFamily.toString();

  static Widget homePage = LoginPage();

  // Constants for the username field
  static const usernameHint = "Nom d'utilisateur";
  static const onUsernameNull = "Veuillez renseigner votre nom d'utilisateur";

  // Constants for the password field
  static const passwordHint = "Mot de passe";
  static const onPasswordNull = "Veuillez renseigner votre mot de passe";

  // Constants for welcome message
  static const welcomeTitle = "Bonjour !";
  static const welcomeSubtitle = "Veuillez vous connecter à votre compte.";

  // Constants for button text
  static const loginBtnText = "Se connecter";
  static const connexionEnCours = "Connexion ...";

  // Constants for searchBar text
  static const taskSearchHint = "Rechercher une tâche...";
}

class Utils {
  static void navigateToPage(var context, var page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static String parseName(String name, int? letterLimit) {
    // separate each word
    var parts = name.split(' ');
    var initial = '';

    // check length
    if (parts.length > 1) {
      // check max limit
      if (letterLimit != null) {
        for (var i = 0; i < letterLimit; i++) {
          // combine the first letters of each word
          initial += parts[i][0];
        }
      } else {
        // this default, if word > 1
        initial = parts[0][0] + parts[1][0];
      }
    } else {
      // this default, if word <=1
      initial = parts[0][0];
    }
    return initial.toUpperCase();
  }
}
