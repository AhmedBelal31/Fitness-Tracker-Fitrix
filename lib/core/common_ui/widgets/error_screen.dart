import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLottieFile(),
              const SizedBox(height: 8),
              // Subtitle
              Align(
                alignment: Alignment.center,
                child: Text(
                  locale.not_found_subtitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A5568),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 32),
              Text(
                locale.not_found_description,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 48),

              Text(
                locale.contact_us_help,
                style: TextStyle(fontSize: 14, color: Color(0xFFA0AEC0)),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLottieFile() {
    return SizedBox(
      height: 300,
      width: 300,
      child: Lottie.asset(
        'assets/images/not_found.json',
        fit: BoxFit.contain,
        repeat: true,
        animate: true,
        frameRate: FrameRate(60),
      ),
    );
  }
}
