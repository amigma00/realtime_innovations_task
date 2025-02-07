import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_task/src/constants/app_colors.dart';
import 'package:realtime_innovations_task/src/constants/app_images.dart';
import 'package:realtime_innovations_task/src/core/extension/sizebox_extension.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: ColorName.dividerColor,
            appBar: AppBar(
              centerTitle: false,
              title: Text('Home Page'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<HomeCubit>().onFabPressed(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: ColorName.primary,
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppImages.noEmployee, height: 240, width: 260),
                100.kheightBox
              ],
            ));
      },
    );
  }
}
