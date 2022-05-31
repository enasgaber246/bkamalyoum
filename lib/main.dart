import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:overlay_support/overlay_support.dart';

import 'Screens/Splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSession().get("language") != null
      ? await translator.init(
          language: await await FlutterSession().get("langu"),
          languagesList: <String>['ar', 'en'],
          assetsDirectory: 'assets/langs/',
        )
      : print("Fffff");

  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: LocalizedApp(
        child: ScreenUtilInit(
          designSize: Size(1329, 2960),
          allowFontScaling: false,
          builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Color(0xFF4D8D8F),
                accentColor: Color(0x867bc2c4),
                primaryColorLight: Color(0xFFF2F8F8),
                dividerColor: Color(0xFF707070),
                fontFamily: 'Dubai',
                textTheme: const TextTheme(
                  headline1: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4D8D8F)),
                  headline2: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF4D8D8F)),
                  headline3: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF4D8D8F)),
                  subtitle1: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  subtitle2: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  bodyText1: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Dubai',
                  ),
                  bodyText2: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Dubai',
                    color: Colors.white,
                  ),
                ),
              ),
              home: Splash()),
        ),
      ),
    );
  }
}
