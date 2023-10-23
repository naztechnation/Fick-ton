import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model/view_models/account_view_model.dart';
import 'provider/items.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';

Future<void> main() async {


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PageIndexProvider(), lazy: false),
      ChangeNotifierProvider(create: (_) => AccountViewModel(), lazy: false),
      // ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
    ], 
    child: const Fikkton(),
  ));
}

class Fikkton extends StatelessWidget {
  const Fikkton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      theme: ThemeData(fontFamily: AppStrings.montserrat),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
