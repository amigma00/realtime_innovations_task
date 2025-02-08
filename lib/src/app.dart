import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:realtime_innovations_task/src/constants/app_colors.dart';
import 'package:realtime_innovations_task/src/core/di/service_locator.dart';
import 'package:realtime_innovations_task/src/core/routes/router.dart';
import 'package:realtime_innovations_task/src/core/theme/app_bar_theme.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/cubit/home_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeCubit>(),
        )
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          restorationScopeId: 'app',
          theme: ThemeData(
              appBarTheme: appBarTheme,
              colorScheme: ColorScheme.light(primary: ColorName.primary),
              primaryColor: ColorName.primary),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
