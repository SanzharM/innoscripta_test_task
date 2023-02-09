import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/domain/blocs/task/task_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/app_text_field.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';

class TaskDescriptionScreen extends StatelessWidget {
  const TaskDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: context.read<TaskBloc>().state.task.description,
    );
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final task = state.task;
        return GestureDetector(
          onTap: FocusScope.of(context).hasFocus ? () => FocusScope.of(context).unfocus() : null,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: const CustomAppBar(),
            body: Padding(
              padding: EdgeInsets.all(AppConstraints.padding),
              child: Column(
                children: [
                  Flexible(
                    child: AppTextField(
                      controller: controller,
                      textInputType: TextInputType.text,
                      maxLines: null,
                      withBorder: false,
                      autofocus: true,
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.all(AppConstraints.padding),
              child: AppButton(
                title: L10n.of(context).add,
                isLoading: state.isLoading,
                onPressed: controller.text.isEmpty
                    ? null
                    : () {
                        if (controller.text != task.description) {
                          context.read<TaskBloc>().update(
                                task.copyWith(description: controller.text),
                              );
                        }
                        context.router.back();
                      },
              ),
            ),
          ),
        );
      },
    );
  }
}
