import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/gen/colors.gen.dart';

class SelectroleBottomSheet extends StatelessWidget {
  SelectroleBottomSheet({super.key});

  final List<String> roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        roles.length,
        (index) => Column(
          children: [
            ListTile(
              onTap: () => context.pop(roles[index]),
              contentPadding: EdgeInsets.zero,
              minTileHeight: 0,
              minVerticalPadding: 16,
              title: Center(
                child: Text(
                  roles[index],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: ColorName.selectRoleFontColor),
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: ColorName.border,
            )
          ],
        ),
      ),
    );
  }
}
