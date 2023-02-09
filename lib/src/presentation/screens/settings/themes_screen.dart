import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/constants/app_colors.dart';
import 'package:innoscripta_test_task/src/core/constants/app_constraints.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/domain/blocs/settings/settings_bloc.dart';
import 'package:innoscripta_test_task/src/domain/entities/custom_theme/custom_theme.dart';
import 'package:innoscripta_test_task/src/presentation/app_router.dart';
import 'package:innoscripta_test_task/src/presentation/widgets/custom_app_bar.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        const customThemes = CustomTheme.appThemes;
        return Scaffold(
          appBar: CustomAppBar(
            title: L10n.of(context).themes,
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(AppConstraints.padding),
            itemCount: customThemes.length,
            itemBuilder: (_, i) {
              final customTheme = customThemes.elementAt(i);
              bool isSelected = customTheme == state.theme;
              return CupertinoButton(
                padding: EdgeInsets.all(AppConstraints.padding),
                child: Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white, width: 8.0),
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        customTheme.primaryColor,
                        customTheme.activeColor,
                        customTheme.secondaryColor,
                      ],
                    ),
                  ),
                  child: isSelected
                      ? Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.33),
                          ),
                        )
                      : null,
                ),
                onPressed: () {
                  if (isSelected) {
                    return context.router.back();
                  }
                  return context.read<SettingsBloc>().update(theme: customTheme);
                },
              );
            },
          ),
        );
      },
    );
  }
}
