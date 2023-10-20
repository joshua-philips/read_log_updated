import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/pages/authentication/onboard_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.pexels.com/photos/15001763/pexels-photo-15001763/free-photo-of-view-of-a-tower-at-sunset.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                child,
            errorBuilder: (context, error, stackTrace) => Container(
              decoration: BoxDecoration(
                color: AppColors.primary2,
              ),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primary2,
                ),
              );
            },
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.35, 1],
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
          const OnboardContent(),
        ],
      ),
    );
  }
}
