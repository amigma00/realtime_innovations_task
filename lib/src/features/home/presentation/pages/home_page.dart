import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_task/gen/assets.gen.dart';
import 'package:realtime_innovations_task/gen/colors.gen.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
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
            body: Center(
              child: Assets.images.noEmployee.image(),
            ));
      },
    );
  }
}
