import 'package:akunku/compound/routes.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppRouter _appRouter;
  @override
  void initState() {
    _appRouter = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          supportedLocales: [
            const Locale('en'),
            const Locale('el'),
            const Locale.fromSubtags(
              languageCode: 'zh',
              scriptCode: 'Hans',
            ), // Generic Simplified Chinese 'zh_Hans'
            const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
          ],
          localizationsDelegates: [
            CountryLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _appRouter.config(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
