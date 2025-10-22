import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/get_it.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theming/app_theme.dart';
import 'core/theming/cubit/theme_cubit.dart';
import 'core/theming/cubit/theme_state.dart';
import 'features/profile/presentation/cubits/localization/locale_cubit/locale_cubit.dart';
import 'features/profile/presentation/cubits/localization/locale_cubit/locale_state.dart';
import 'features/workout/presentation/cubit/workouts_cubit.dart';
import 'generated/l10n.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();

class FitrixApp extends StatelessWidget {
  final AppRouter appRouter;

  const FitrixApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => di.get<WorkoutsCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              final currentLocale = localeState.locale;

              return ScreenUtilInit(
                designSize: const Size(412, 917),
                minTextAdapt: true,
                splitScreenMode: true,
                child: MaterialApp(
                  navigatorKey: navigatorKey,
                  title: 'FitrixApp',
                  theme: AppTheme.getLightTheme(currentLocale),
                  darkTheme: AppTheme.getDarkTheme(currentLocale),
                  themeMode: themeState.themeMode,
                  locale: currentLocale,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: appRouter.generateRoute,
                  initialRoute: Routes.splashScreen,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
