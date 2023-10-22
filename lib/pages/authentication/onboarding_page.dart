import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/pages/authentication/onboard_content.dart';
import 'package:books_log_migration/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
          FutureBuilder(
              future: onboardImage(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.network(
                    snapshot.data ?? "",
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) =>
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
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary2,
                  ),
                );
              }),
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

  Future<String> onboardImage(BuildContext context) async {
    FirestoreService firestoreService = context.read<FirestoreService>();
    return await firestoreService.getOnboardingImage();
  }
}
