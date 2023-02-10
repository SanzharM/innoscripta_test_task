import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/core/services/alert_controller.dart';
import 'package:innoscripta_test_task/src/domain/blocs/board/board_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/app_text_field.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/buttons/app_button.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/sheet_app_bar.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  late TextEditingController _controller;

  String title = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardBloc, BoardState>(
      listener: (context, state) {
        if (state is BoardCreatedState) {
          context.router.back();
          return AlertController.showMessage(
            L10n.of(context).taskCreated,
            isSuccess: true,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: FocusScope.of(context).hasFocus ? () => FocusScope.of(context).unfocus() : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppConstraints.borderRadiusTLR,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            padding: EdgeInsets.all(AppConstraints.padding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SheetAppBar(
                  title: L10n.of(context).newTask,
                ),
                SizedBox(height: AppConstraints.padding),
                AppTextField(
                  controller: _controller,
                  label: L10n.of(context).task,
                ),
                const Spacer(),
                AppButton(
                  title: L10n.of(context).create,
                  isLoading: state.isLoading,
                  onPressed: _controller.text.isEmpty
                      ? null
                      : () {
                          context.read<BoardBloc>().createTask(_controller.text);
                        },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
