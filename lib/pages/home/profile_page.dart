import 'package:books_log_migration/components/edit_name_dialog.dart';
import 'package:books_log_migration/configuration/app_colors.dart';
import 'package:books_log_migration/configuration/constants.dart';
import 'package:books_log_migration/pages/change_password_page.dart';
import 'package:books_log_migration/pages/profile_photo_page.dart';
import 'package:books_log_migration/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthService>().getCurrentUser();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.text,
              ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: const Color(0xFF757575).withOpacity(0.08),
              child: const ListTile(
                title: Text('My Profile'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ListTile(
                onTap: () {
                  Route route = MaterialPageRoute(
                      builder: (context) => ProfilePhotoPage(
                            photoUrl: user.photoURL!,
                          ));
                  Navigator.push(context, route);
                },
                minLeadingWidth: 60,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  foregroundImage: NetworkImage(user.photoURL!),
                  onForegroundImageError: (exception, stackTrace) =>
                      Text(user.displayName![0]),
                ),
                title: Text(user.displayName!),
                trailing: const Icon(CupertinoIcons.forward),
              ),
            ),
            const Settings(),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH8,
        Container(
          color: const Color(0xFF757575).withOpacity(0.08),
          child: const ListTile(
            title: Text('Settings'),
          ),
        ),
        gapH16,
        SettingListTile(
          onTap: () {
            showDialog(
                context: context, builder: (context) => const EditNameDialog());
          },
          title: 'Update Name',
          icon: FontAwesomeIcons.passport,
        ),
        SettingListTile(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (context) => const ChangePasswordPage());
            Navigator.push(context, route);
          },
          title: 'Change Password',
          icon: FontAwesomeIcons.lock,
        ),
        gapH8,
        SettingListTile(
          onTap: () async {
            await context.read<AuthService>().signOut();
            Navigator.popUntil(context, (route) => !Navigator.canPop(context));
          },
          title: 'Log out',
          isLogout: true,
          icon: Icons.logout_rounded,
        ),
      ],
    );
  }
}

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.title,
    required this.icon,
    this.trailingText,
    this.isLogout = false,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final String? trailingText;
  final bool isLogout;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 2),
      child: ListTile(
        onTap: onTap,
        minLeadingWidth: 20,
        leading: FaIcon(
          icon,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(color: isLogout ? AppColors.error : null),
        ),
        trailing: isLogout
            ? const SizedBox()
            : SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    trailingText != null
                        ? Text(trailingText!)
                        : const SizedBox(),
                    gapW4,
                    const Icon(CupertinoIcons.forward),
                  ],
                ),
              ),
      ),
    );
  }
}
