import 'package:flutter/material.dart';
import 'pages/root.dart';
import 'theme/colors.dart';

void main() => runApp(const SparkApp());

class SparkApp extends StatelessWidget {
  const SparkApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spark',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.flameEnd,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          color: AppColors.surface,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.flameEnd,
          secondary: AppColors.accentEnd,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Root(),
    );
  }
}
