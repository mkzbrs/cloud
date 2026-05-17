import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    // Di sini Riverpod akan periksa token / PIN secara automatik nanti.
    // Buat masa ni, kita buat simulasi "loading" selama 2 saat.
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const LoginScreen()), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CupertinoColors.activeBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/icons/icon.png'),
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Cloud',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 40),
            CupertinoActivityIndicator(
              color: Colors.white,
              radius: 15,
            ),
          ],
        ),
      ),
    );
  }
}