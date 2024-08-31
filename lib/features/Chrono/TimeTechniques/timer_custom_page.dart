import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Chrono/TimeTechniques/timer_end_page.dart';

class TimerCustomPage extends StatefulWidget {
  final String timerTitle;
  final int workMinutes;
  final int breakMinutes;
  final bool isPomodoro;

  const TimerCustomPage({
    super.key,
    required this.timerTitle,
    required this.workMinutes,
    required this.breakMinutes,
    this.isPomodoro = true,
  });

  @override
  State<TimerCustomPage> createState() => _TimerCustomPageState();
}

class _TimerCustomPageState extends State<TimerCustomPage> {
  late int _totalSeconds;
  bool _isWorkTime = true;
  Timer? _timer;
  int? _selectedButtonIndex;

  @override
  void initState() {
    super.initState();
    _resetTimer(); // Initialize the timer with work or break time
  }

  void _resetTimer() {
    _totalSeconds =
        (_isWorkTime ? widget.workMinutes : widget.breakMinutes) * 60;
    _timer?.cancel(); // Stop any existing timer
    setState(() {
      _selectedButtonIndex = null;
    });
  }

  void _startTimer() {
    // Start the timer and decrease totalSeconds every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalSeconds > 0) {
        setState(() {
          _totalSeconds--;
        });
      } else {
        _onTimerComplete(); // Handle timer completion
      }
    });
    setState(() {
      _selectedButtonIndex = 0; // Update UI for start button
    });
  }

  void _pauseTimer() {
    _timer?.cancel(); // Pause the timer
    setState(() {
      _selectedButtonIndex = 1; // Update UI for pause button
    });
  }

  void _onTimerComplete() {
    _pauseTimer();
    if (_isWorkTime) {
      // If work time is complete, switch to break time
      _isWorkTime = false;
      _resetTimer();
      _startTimer(); // Start the break timer
    } else {
      _showEndPage(); // If break time is complete, show end page
    }
  }

  void _showEndPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TimerEndPage(timerTitle: widget.timerTitle),
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    // Format the remaining time in MM:SS format
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: true,
      appBarColor: const Color(0xFF1B1B1B),
      backgroundColor: const Color(0xFF1B1B1B),
      pageTitle: '',
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF1B1B1B), Color(0xFF818181)],
          ),
        ),
        child: Column(
          children: [
            // Display the title of the timer technique
            Text(
              widget.timerTitle,
              textAlign: TextAlign.center,
              style: ChronoStyles.timerTitlePageStyle,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            if (!_isWorkTime)
              const Text(
                ChronoConstants.breakTime,
                style: ChronoStyles.timerBreakStyle,
              ),
            // Display the remaining time
            Text(
              _formatTime(_totalSeconds),
              style: ChronoStyles.timeSessionStyle,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            // Timer control buttons (start, pause, reset)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: _startTimer,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: _selectedButtonIndex == 0
                          ? AppColor.pink
                          : AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ChronoAssetsPath.playIcon,
                        width: 60,
                        height: 60,
                        colorFilter: ColorFilter.mode(
                          _selectedButtonIndex == 0
                              ? AppColor.white
                              : AppColor.pink,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _pauseTimer,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: _selectedButtonIndex == 1
                          ? AppColor.pink
                          : AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: SvgPicture.asset(ChronoAssetsPath.pauseIcon,
                        width: 60,
                        height: 60,
                        colorFilter: ColorFilter.mode(
                          _selectedButtonIndex == 1
                              ? AppColor.white
                              : AppColor.pink,
                          BlendMode.srcIn,
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _resetTimer(); // Reset the timer
                      _selectedButtonIndex = 2; // Update UI for reset button
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: _selectedButtonIndex == 2
                          ? AppColor.pink
                          : AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: SvgPicture.asset(ChronoAssetsPath.replayIcon,
                        width: 60,
                        height: 60,
                        colorFilter: ColorFilter.mode(
                          _selectedButtonIndex == 2
                              ? AppColor.white
                              : AppColor.pink,
                          BlendMode.srcIn,
                        )),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }
}
