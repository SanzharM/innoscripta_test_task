import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_icon_button.dart';

class SheetAppBar extends StatelessWidget {
  const SheetAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 4.w,
          width: 48.w,
          margin: EdgeInsets.symmetric(
            horizontal: AppConstraints.padding,
          ),
          decoration: BoxDecoration(
            borderRadius: AppConstraints.borderRadius,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
          ),
        ),
        SizedBox(height: AppConstraints.padding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.0,
              child: AppIconButton.close(context),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(width: AppConstraints.padding),
            AppIconButton.close(context),
          ],
        ),
      ],
    );
  }
}
