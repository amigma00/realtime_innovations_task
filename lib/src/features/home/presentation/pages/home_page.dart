import 'package:flutter/material.dart';
import 'package:realtime_innovations_task/gen/assets.gen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blue,
          title: Text('Home Page', style: TextStyle(color: Colors.white)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Center(
          child: Assets.images.noEmployee.image(),
        ));
  }
}
