import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/app_text_field.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_button.dart';

class AddBoardScreen extends StatefulWidget {
  const AddBoardScreen({super.key});

  @override
  State<AddBoardScreen> createState() => _AddBoardScreenState();
}

class _AddBoardScreenState extends State<AddBoardScreen> {
  String name = '';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).hasFocus ? () => FocusScope.of(context).unfocus() : null,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(AppConstraints.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60.h),
              Text(
                L10n.of(context).howDoYouCallYourBoard,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.w,
                    ),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                controller: _controller,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(AppConstraints.padding),
          child: AppButton(
            title: L10n.of(context).add,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
