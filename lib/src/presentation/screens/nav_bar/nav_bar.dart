import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innoscripta_test_task/src/core/l10n/l10n_service.dart';
import 'package:innoscripta_test_task/src/presentation/screens/home/home_screen.dart';
import 'package:innoscripta_test_task/src/presentation/screens/nav_bar/bloc/nav_bar_bloc.dart';
import 'package:innoscripta_test_task/src/presentation/screens/settings/settings_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final tabs = const [HomeScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: tabs.elementAt(state.currentIndex),
          ),
          bottomNavigationBar: CupertinoTabBar(
            currentIndex: state.currentIndex,
            onTap: context.read<NavBarBloc>().changeTab,
            backgroundColor: Colors.transparent,
            height: 64.h,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
