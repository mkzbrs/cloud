import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: AssetImage('assets/icons/icon.png'),
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 24),
              const Text(
                'Cloud',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const Text(
                'Private Server Access',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 48),
              
              // Kotak Input 1: Access Key (Username)
              CupertinoTextField(
                padding: const EdgeInsets.all(16),
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Icon(Icons.person, color: CupertinoColors.systemGrey),
                ),
                placeholder: 'Username',
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),
              
              // Kotak Input 2: Secret Key (Password)
              CupertinoTextField(
                padding: const EdgeInsets.all(16),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(Icons.lock, color: CupertinoColors.systemGrey),
                ),
                placeholder: 'Password',
                obscureText: _obscureText,
                suffix: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: CupertinoColors.systemGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 32),
              
              // Butang Login
              CupertinoButton.filled(
                borderRadius: BorderRadius.circular(18),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    'Authenticate',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}