// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/auth_provider.dart';
// import 'providers/groups_provider.dart';
// import 'providers/expense_provider.dart';
// import 'providers/statistics_provider.dart';
// import 'providers/friend_provider.dart';
// import 'providers/activity_provider.dart';
// import 'services/friend_service.dart';
// import 'services/expense_service.dart';
// import 'services/statistics_service.dart';
// import 'screens/login_screen.dart';
// import 'screens/home_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => GroupsProvider()),
//         ChangeNotifierProvider(create: (_) => ExpenseProvider(ExpenseService())),
//         ChangeNotifierProvider(create: (_) => StatisticsProvider(StatisticsService())),
//         ChangeNotifierProvider(create: (_) => FriendProvider(FriendService())),
//         ChangeNotifierProvider(create: (_) => ActivityProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Splitwise Clone',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.green,
//           brightness: Brightness.light,
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.green,
//             foregroundColor: Colors.white,
//           ),
//           floatingActionButtonTheme: const FloatingActionButtonThemeData(
//             backgroundColor: Colors.green,
//           ),
//         ),
//         home: Consumer<AuthProvider>(
//           builder: (context, auth, _) {
//             return auth.isAuthenticated ? const HomeScreen() : const LoginScreen();
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splitwise_flutter/core/app_authentication_state/app_authentication_state.dart';
import 'package:splitwise_flutter/core/constants/app_string_constants.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/utilities/appKeys.dart';
import 'package:splitwise_flutter/core/utilities/configs/themes/core_theme.dart';
import 'package:splitwise_flutter/core/utilities/environment/environment_configurations.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/route_generator.dart';
import 'package:splitwise_flutter/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ensureInitialized
  await EasyLocalization.ensureInitialized();

  // init environment
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: EnvironmentsVariables.production,
  );

  // init Environments Variables
  EnvironmentsVariables().initConfig(environment);

  // init Hive ( data storage )
  await Hive.initFlutter();
  Hive.registerAdapter(AppAuthenticationStateEnumAdapter());

  // init get it for all Dependencies
  getIt.registerSingleton(Dio());
  configureDependencies();
  await getIt.allReady();

  runApp(
    EasyLocalization(
      path: 'assets/translation',
      supportedLocales: const [Locale('ar'), Locale('en')],
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      assetLoader: const CodeGenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialChild();
  }
}

class MaterialChild extends StatefulWidget {
  const MaterialChild({super.key});

  @override
  State<MaterialChild> createState() => _MaterialChildState();
}

class _MaterialChildState extends State<MaterialChild> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: AppKeys.materialKey,
          debugShowCheckedModeBanner: false,
          title: AppStringConstants.appName,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          theme: themeLight,
          darkTheme: themeDark,
          themeMode: ThemeMode.light,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
