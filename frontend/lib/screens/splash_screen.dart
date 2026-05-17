import 'package:cloud_storage/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isFirstPhase = true;

  @override
  void initState() {
    super.initState();
    _playSplashAnimation();
  }

  Future<void> _playSplashAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isFirstPhase = false);
    }
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final startTop = (screenHeight / 2) - 110; 
    final finalTop = screenHeight * 0.12; 

    return Scaffold(
      backgroundColor: AppTheme.cardLight,
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutBack,
              top: _isFirstPhase ? (screenHeight / 2) : finalTop + 120,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _isFirstPhase ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 800),
                child: const Column(
                  children: [
                    Text(
                      'Cloud',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
                    ),
                    SizedBox(height: 30),
                    CupertinoActivityIndicator(color: Colors.white, radius: 15),
                  ],
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutBack,
              top: _isFirstPhase ? startTop : finalTop,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'app_icon',
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOutBack,
                    width: _isFirstPhase ? 220 : 100,
                    height: _isFirstPhase ? 220 : 100,
                    child: const Image(image: AssetImage('assets/icons/icon.png'), fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}