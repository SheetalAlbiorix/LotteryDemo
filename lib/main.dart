import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_flutter/constants/Constant.dart';
import 'x_res/my_res.dart';
import 'x_routes/routes.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: darkPurpleColor, //or set color with: Color(0xFF0000FF)
    ));

    return GetMaterialApp(
      theme: AppThemes.theme(),
      darkTheme: AppThemes.theme(),
      themeMode: AppThemes().init(),
      locale: MyTranslations.locale,
      fallbackLocale: MyTranslations.fallbackLocale,
      translations: MyTranslations(),
      initialRoute: RouterName.dashboard,
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages(),
    );
  }
}
