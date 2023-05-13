import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary91 = Color(0xff65C0D4);
const Color primary20 = Color(0xff3D737F);
const Color primary40 = Color(0xff65C0D4);
const Color primary60 = Color(0xffA3D9E5);
const Color primary90 = Color(0xffE0F2F6);


const Color secondary = Color(0xffFFBA76);
const Color secondaryLight = Color(0xffFFF1E4);

const sizeIconBottomNavBar = 30.0;
const sizeIconBottomNavBarSelected = 40.0;

const paddingLabel = EdgeInsets.only(top: 20, bottom: 14);
const myPaddingForm = EdgeInsets.symmetric(horizontal: 13.0);
const marginBtnLogin = EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0, top: 10.0);
const marginBtnFormPrincipal = EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0, bottom: 25.0);
const marginBtnFormSecundario = EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0);
const myPaddingCard = EdgeInsets.only(left: 16.0, right: 16.0, top: 10);

class AppTheme {
  AppTheme();

  ThemeData theme() => ThemeData(
        colorSchemeSeed: primary40,
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleSmall: const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w500),
          titleMedium: const TextStyle(color: primary20, fontSize: 14.0, fontWeight: FontWeight.w400),
          headlineLarge: const TextStyle(color: primary40, fontSize: 25.0, fontWeight: FontWeight.w600),
          headlineMedium: const TextStyle(color: primary40, fontSize: 14.0, fontWeight: FontWeight.w400),
          bodyLarge: const TextStyle(color: primary40, fontSize: 12.0, fontWeight: FontWeight.w600),
          bodyMedium: const TextStyle(color: primary20, fontSize: 14.0, fontWeight: FontWeight.w400),
          displayMedium: const TextStyle(color: primary60, fontSize: 12.0, fontWeight: FontWeight.w400),
          labelLarge: const TextStyle(color: primary20, fontSize: 18.0, fontWeight: FontWeight.w700),
          labelMedium: const TextStyle(color: primary20, fontSize: 15.0, fontWeight: FontWeight.w400),
          labelSmall: const TextStyle(color: primary20, fontSize: 14.0, fontWeight: FontWeight.w700),
          displaySmall: const TextStyle(color: secondary, fontSize: 15.0, fontWeight: FontWeight.w600),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        cardTheme: const CardTheme(
          color: primary90,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: secondary,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: primary90,
          selectedItemColor: primary20,
          unselectedItemColor: primary20,
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
              backgroundColor: primary40,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              )),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: secondary, fontSize: 14.0, fontWeight: FontWeight.w400),
          hintStyle: const TextStyle(color: primary60, fontSize: 14.0, fontWeight: FontWeight.w400),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(color: primary40),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(color: primary60),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(color: secondary),
          ),
          prefixIconColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.focused)) {
              return secondary;
            }
            if (states.contains(MaterialState.error)) {
              return Colors.red;
            }
            return primary40;
          }),
          suffixIconColor: MaterialStateColor.resolveWith((states) => primary40),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: primary90,
          titleTextStyle: TextStyle(color: primary20, fontSize: 14.0, fontWeight: FontWeight.w400),
          contentTextStyle: TextStyle(color: primary40, fontSize: 14.0, fontWeight: FontWeight.w400),
          actionsPadding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: secondary),
      );
}
