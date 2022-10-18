import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_test/core/constants/strings.dart';
import 'package:weather_test/core/injection/service_locator.dart';
import 'package:weather_test/presentation/cubit/app_cubit.dart';
import 'package:weather_test/presentation/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringContsants.appName,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: TextTheme(
          headline1: GoogleFonts.assistant(
              textStyle: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          )),
          subtitle1: GoogleFonts.nunito(
              textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
          subtitle2: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
          bodyText1: GoogleFonts.nunito(
              textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          )),
        ),
      ),
      home: BlocProvider(
        create: (context) => sl<AppCubit>(),
        child: const MyHomePage(title: StringContsants.homePageTitle),
      ),
    );
  }
}
