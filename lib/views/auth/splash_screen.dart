import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  late List<AnimationController> _letterControllers;
  late List<Animation<double>> _letterAnimations;

  late AnimationController _subheadingController;
  late Animation<double> _subheadingAnimation;

  final String title = "GLAMIFY";

  @override
  void initState() {
    super.initState();

    // --- Logo animation ---
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoController.forward();

    // --- Letters animation ---
    _letterControllers = List.generate(title.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );
    });

    _letterAnimations = List.generate(title.length, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _letterControllers[index], curve: Curves.elasticOut),
      );
    });

    // Start letters animation one by one after logo animation
    _logoController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        for (var controller in _letterControllers) {
          controller.forward();
          await Future.delayed(const Duration(milliseconds: 150));
        }
        _subheadingController.forward(); // start subheading after letters
      }
    });

    // --- Subheading animation (bounce) ---
    _subheadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _subheadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _subheadingController, curve: Curves.elasticOut),
    );

    // Navigate to onboarding after 4 seconds
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    for (var controller in _letterControllers) {
      controller.dispose();
    }
    _subheadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color teal = Color(0xFF008080);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [teal, teal],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- Logo ---
              ScaleTransition(
                scale: _logoAnimation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.spa,
                    size: 50,
                    color: teal,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Title letters ---
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(title.length, (index) {
                  return AnimatedBuilder(
                    animation: _letterAnimations[index],
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _letterAnimations[index].value,
                        child: Text(
                          title[index],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 8),

              // --- Subheading (bounce effect) ---
              AnimatedBuilder(
                animation: _subheadingAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _subheadingAnimation.value,
                    child: const Text(
                      'Your Beauty, Our Priority',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
