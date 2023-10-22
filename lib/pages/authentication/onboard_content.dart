import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/pages/authentication/login_page.dart';
import 'package:books_log_migration/pages/authentication/register_page.dart';
import 'package:flutter/material.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({
    super.key,
  });

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late final Future<bool> futureOperation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Revolutionize your reading',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            gapH16,
            const Text(
              'This app will help you keep track of the literary adventures you’ve experienced and ensure you never miss out on an exciting new release.',
              textAlign: TextAlign.center,
            ),
            gapH24,
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => const RegisterPage());
                        Navigator.push(context, route);
                      },
                      child: const Text('Register'),
                    ),
                    gapH8,
                    OutlinedButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => const LoginPage());
                        Navigator.push(context, route);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.transparent),
                      ),
                      child: const Text('Sign in'),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
