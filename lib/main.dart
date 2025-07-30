import 'package:akunku/bloc/Auth/login/auth_cubit.dart';
import 'package:akunku/bloc/connectivity/connectivity_cubit.dart';
import 'package:akunku/compound/compound.dart';
import 'package:akunku/repository/auth_repository/auth.dart';
import 'package:akunku/repository/connection/base_connection.dart';
import 'package:akunku/repository/connection/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthenticationBase();
    final BaseConnection connection = Connection(connectivity: connectivity);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: connection),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(authRepository)),
          BlocProvider(
            create: (context) =>
                ConnectivityCubit(connectionService: connection)..initialize(),
          ),
        ],
        child: ScreenUtilInit(
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
                const Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hant',
                ),
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
        ),
      ),
    );
  }
}
