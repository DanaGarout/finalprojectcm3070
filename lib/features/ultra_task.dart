import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/bottom_navigation_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Chrono/chrono_screen_page.dart';
import 'package:ultratasks/features/Home/home_screen_page.dart';
import 'package:ultratasks/features/Tasks/tasks_screen_page.dart';
import 'Profile/profile_screen_page.dart';

class UltraTask extends StatefulWidget {
  const UltraTask({super.key});

  @override
  State<UltraTask> createState() => _UltraTaskState();
}

class _UltraTaskState extends State<UltraTask> {
  int _currentIndex =
      0; // Tracks the current index of the bottom navigation bar

  final List<Widget> _children = [
    const HomeScreenPage(), // Home screen widget
    const TasksScreenPage(), // Tasks screen widget
    const ChronoScreenPage(), // Chrono screen widget
    const ProfileScreenPage(), // Profile screen widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey01, // Background color for the scaffold
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            AppColor.brown, // Background color for the bottom navigation bar
        selectedItemColor: AppColor.pink, // Color for the selected item
        unselectedItemColor: AppColor.white, // Color for the unselected items
        currentIndex: _currentIndex, // Current selected index
        selectedLabelStyle: BottomNavigationStyles.selectedBottomNavStyle,
        unselectedLabelStyle: BottomNavigationStyles.unselectedBottomNavStyle,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index on item tap
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              UltraTaskMainAssets.homeSvg,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? AppColor.pink : AppColor.white,
                BlendMode.srcIn,
              ),
            ),
            label: HomeConstants.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              UltraTaskMainAssets.taskSvg,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? AppColor.pink : AppColor.white,
                BlendMode.srcIn,
              ),
            ),
            label: TasksConstants.tasks,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              UltraTaskMainAssets.chronoSvg,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? AppColor.pink : AppColor.white,
                BlendMode.srcIn,
              ),
            ),
            label: ChronoConstants.chrono,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              UltraTaskMainAssets.profileSvg,
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? AppColor.pink : AppColor.white,
                BlendMode.srcIn,
              ),
            ),
            label: ProfileConstants.profile,
          ),
        ],
      ),
      body: _children[
          _currentIndex], // Display the selected screen based on the index
    );
  }
}
