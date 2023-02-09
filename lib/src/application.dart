import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/l10n/generated/l10n.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board_list/board_list_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/nav_bar/nav_bar_bloc.dart';
import 'package:innoscripta_test_task/src/domain/blocs/time_tracking/time_tracking_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/theme/app_theme.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  static const title = 'Innoscripta';

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBarBloc>(
          create: (_) => NavBarBloc(),
        ),
        BlocProvider<BoardListBloc>(
          create: (_) => BoardListBloc()..fetch(),
        ),
        BlocProvider<TimeTrackingBloc>(
          create: (_) => TimeTrackingBloc(Ticker()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: Application.title,

            // Routing
            navigatorKey: AppRouter.state,
            routes: AppRouter.routes,
            initialRoute: AppRouter.initialRoute,
            onGenerateRoute: AppRouter.onGenerateRoute,

            // Theme
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeAnimationCurve: Curves.bounceInOut,
            themeAnimationDuration: const Duration(milliseconds: 300),

            // Localization
            locale: const Locale('en'),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
