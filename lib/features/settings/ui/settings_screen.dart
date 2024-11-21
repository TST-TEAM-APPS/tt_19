import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:tt_19/core/app_fonts.dart';
import 'package:tt_19/core/colors.dart';
import 'package:tt_19/services/mixins/config_mixin.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with ConfigMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _AppBar(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Feedback',
                style: AppFonts.bodyLarge
                    .copyWith(color: const Color(0xffFFFFEE).withOpacity(0.7)),
              ),
              const SizedBox(
                height: 20,
              ),
              _SettingsItem(
                title: 'Contact us',
                onTap: () async => await FlutterEmailSender.send(
                  Email(
                    recipients: ['govathotiamarsaichaitanya448@gmail.com'],
                    subject: 'Message to support', 
                    body: 'Thank you for your feedback!'
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              _SettingsItem(
                title: 'Rate us',
                onTap: () async => await InAppReview.instance.requestReview(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'About app',
                style: AppFonts.bodyLarge
                    .copyWith(color: const Color(0xffFFFFEE).withOpacity(0.7)),
              ),
              const SizedBox(
                height: 20,
              ),
              _SettingsItem(
                title: 'Privacy Policy',
                onTap: () => launchUrlString(privacyLink),
              ),
              const SizedBox(
                height: 5,
              ),
              _SettingsItem(
                title: 'Terms of use',
                onTap: () => launchUrlString(termsLink),
              ),
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'version 1.0.0',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final Function onTap;
  const _SettingsItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(2),
      child: InkWell(
        onTap: () {
          onTap();
        },
        highlightColor: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppFonts.bodyLarge.copyWith(color: AppColors.white),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Text(
          'Settings',
          style: AppFonts.displayMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox()
      ],
    );
  }
}
