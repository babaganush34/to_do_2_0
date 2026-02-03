import 'package:flutter/material.dart';

import '../../services/app_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    AppPreferences.instance.setOnboardingSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 20,
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const Scaffold(body: Center(child: Text("Home"))),
                  ),
                ),
                child: const Text(
                  "Пропустить",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) =>
                        setState(() => _currentIndex = index),
                    children: [_buildFirstPage(), _buildSecondPage()],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) => _buildDot(index)),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentIndex > 0
                          ? TextButton(
                              onPressed: () => _controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              ),
                              child: const Text(
                                "Назад",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : const SizedBox(width: 80),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () {
                          if (_currentIndex == 1) {
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: Text(
                          _currentIndex == 1 ? "Начать" : "Далее",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
        const SizedBox(height: 40),
        const Text(
          "Добро пожаловать!",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(
            "Организуйте свою жизнь с Todoist — приложение для управления задачами",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.checklist_rtl, size: 150, color: Colors.blue),
        const SizedBox(height: 40),
        const Text(
          "Все задачи в одном месте",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(
            "Добавляйте, упорядочивайте и управляйте задачами на день, неделю и месяц",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.done_all, color: Colors.white, size: 60),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? Colors.blue
            : Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
