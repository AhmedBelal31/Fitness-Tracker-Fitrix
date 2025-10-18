import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'font_weight_helper.dart';

class TextStyles {
  // =================================================================
  // 🎯 SEMANTIC TEXT STYLES (Recommended for UI consistency)
  // =================================================================

  /// Large headlines for splash screens and main titles
  static TextStyle get headline1 => TextStyle(
    fontSize: 32.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
    letterSpacing: 1.2,
  );

  static TextStyle get font16PrimaryTextSemiBold => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.semiBold,
  );

  /// Medium headlines for screen titles
  static TextStyle get headline2 => TextStyle(
    fontSize: 28.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
    letterSpacing: 0.8,
  );

  /// Small headlines for section titles
  static TextStyle get headline3 => TextStyle(
    fontSize: 24.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.semiBold,
    letterSpacing: 0.5,
  );

  /// Subtitle text for descriptions
  static TextStyle get subtitle1 => TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.medium,
  );

  /// Smaller subtitle text
  static TextStyle get subtitle2 => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.lightText,
    fontWeight: FontWeightHelper.regular,
  );

  /// Main body text
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.regular,
    height: 1.5,
  );

  /// Secondary body text
  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.regular,
    height: 1.4,
  );

  /// Small body text
  static TextStyle get bodySmall => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.lightText,
    fontWeight: FontWeightHelper.regular,
    height: 1.3,
  );

  /// Button text styles
  static TextStyle get buttonLarge => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.semiBold,
    letterSpacing: 0.5,
  );

  static TextStyle get buttonMedium => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.medium,
    letterSpacing: 0.3,
  );

  /// Caption and helper text
  static TextStyle get caption => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.lightText,
    fontWeight: FontWeightHelper.regular,
  );

  /// Label text for forms
  static TextStyle get labelLarge => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.medium,
  );

  // =================================================================
  // 🏋️‍♀️ FITNESS-SPECIFIC TEXT STYLES
  // =================================================================

  /// Workout titles
  static TextStyle get workoutTitle => TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.bold,
    letterSpacing: 0.5,
  );

  /// Exercise names
  static TextStyle get exerciseName => TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.semiBold,
  );

  /// Metric numbers (calories, steps, etc.)
  static TextStyle get metricNumber => TextStyle(
    fontSize: 24.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.bold,
  );

  /// Metric labels
  static TextStyle get metricLabel => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.medium,
    letterSpacing: 0.5,
  );

  /// Progress percentage
  static TextStyle get progressText => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.semiBold,
  );

  /// Timer display
  static TextStyle get timerText => TextStyle(
    fontSize: 28.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // =================================================================
  // 🎨 COLOR-BASED TEXT STYLES
  // =================================================================

  // Primary Green Styles
  static TextStyle get font32PrimaryGreenBold => TextStyle(
    fontSize: 32.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font24PrimaryGreenSemiBold => TextStyle(
    fontSize: 24.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get font20PrimaryGreenMedium => TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle get font16PrimaryGreenRegular => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font14PrimaryGreenSemiBold => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.primaryGreen,
    fontWeight: FontWeightHelper.semiBold,
  );

  // Secondary Green Styles
  static TextStyle get font20SecondaryGreenBold => TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.secondaryGreen,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font16SecondaryGreenMedium => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.secondaryGreen,
    fontWeight: FontWeightHelper.medium,
  );

  // Primary Text Styles
  static TextStyle get font28PrimaryTextBold => TextStyle(
    fontSize: 28.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font24PrimaryTextBold => TextStyle(
    fontSize: 24.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font20PrimaryTextSemiBold => TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get font18PrimaryTextMedium => TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle get font16PrimaryTextRegular => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font14PrimaryTextMedium => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle get font12PrimaryTextRegular => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.regular,
  );

  // Secondary Text Styles
  static TextStyle get font20SecondaryTextMedium => TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle get font18SecondaryTextRegular => TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font16SecondaryTextMedium => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle get font14SecondaryTextRegular => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font12SecondaryTextRegular => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.secondaryText,
    fontWeight: FontWeightHelper.regular,
  );

  // Light Text Styles
  static TextStyle get font16LightTextRegular => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.lightText,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font14LightTextRegular => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.lightText,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font12LightTextRegular => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.lightText,
    fontWeight: FontWeightHelper.regular,
  );

  // White Text Styles
  static TextStyle get font24WhiteBold => TextStyle(
    fontSize: 24.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font20WhiteSemiBold => TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get font18WhiteMedium => TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle get font16WhiteRegular => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font14WhiteMedium => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle get font12WhiteRegular => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.regular,
  );

  // Error/Success/Warning Styles
  static TextStyle get font16ErrorBold => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.error,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font14ErrorRegular => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.error,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font16SuccessBold => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.success,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font14SuccessRegular => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.success,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font16WarningBold => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.warning,
    fontWeight: FontWeightHelper.bold,
  );

  // =================================================================
  // 📱 SIZE-BASED TEXT STYLES
  // =================================================================

  // Extra Large Styles (30sp+)
  static TextStyle get font36Bold =>
      TextStyle(fontSize: 36.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font32Bold =>
      TextStyle(fontSize: 32.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font30Regular =>
      TextStyle(fontSize: 30.sp, fontWeight: FontWeightHelper.regular);

  // Large Styles (24-28sp)
  static TextStyle get font28Bold =>
      TextStyle(fontSize: 28.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font26SemiBold =>
      TextStyle(fontSize: 26.sp, fontWeight: FontWeightHelper.semiBold);

  static TextStyle get font24Bold =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font24SemiBold =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeightHelper.semiBold);

  static TextStyle get font24Regular =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeightHelper.regular);

  // Medium Styles (18-22sp)
  static TextStyle get font22Bold =>
      TextStyle(fontSize: 22.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font20Bold =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font20SemiBold =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeightHelper.semiBold);

  static TextStyle get font20Medium =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeightHelper.medium);

  static TextStyle get font20Regular =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeightHelper.regular);

  static TextStyle get font18Bold =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font18SemiBold =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeightHelper.semiBold);

  static TextStyle get font18Medium =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeightHelper.medium);

  static TextStyle get font18Regular =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeightHelper.regular);

  // Small Styles (14-16sp)
  static TextStyle get font16Bold =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font16SemiBold =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeightHelper.semiBold);

  static TextStyle get font16Medium =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeightHelper.medium);

  static TextStyle get font16Regular =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeightHelper.regular);

  static TextStyle get font14Bold =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font14SemiBold =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeightHelper.semiBold);

  static TextStyle get font14Medium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeightHelper.medium);

  static TextStyle get font14Regular =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeightHelper.regular);

  // Extra Small Styles (10-12sp)
  static TextStyle get font12Bold =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font12SemiBold =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeightHelper.semiBold);

  static TextStyle get font12Medium =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeightHelper.medium);

  static TextStyle get font12Regular =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeightHelper.regular);

  static TextStyle get font10Bold =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeightHelper.bold);

  static TextStyle get font10Regular =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeightHelper.regular);

  // =================================================================
  // 🎯 UTILITY METHODS
  // =================================================================

  /// Create a custom text style with specific color
  static TextStyle withColor(TextStyle baseStyle, Color color) {
    return baseStyle.copyWith(color: color);
  }

  /// Create a custom text style with specific font weight
  static TextStyle withWeight(TextStyle baseStyle, FontWeight weight) {
    return baseStyle.copyWith(fontWeight: weight);
  }

  /// Create a custom text style with specific letter spacing
  static TextStyle withLetterSpacing(TextStyle baseStyle, double spacing) {
    return baseStyle.copyWith(letterSpacing: spacing);
  }

  /// Create a custom text style with specific line height
  static TextStyle withLineHeight(TextStyle baseStyle, double height) {
    return baseStyle.copyWith(height: height);
  }

  // Add these to the White Text Styles section (around line 280)

  static TextStyle get font16WhiteSemiBold => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get font12WhiteSemiBold => TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get font18WhiteBold => TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font10WhiteRegular => TextStyle(
    fontSize: 10.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.regular,
  );

  // Add these after the existing white text styles section

  static TextStyle get font14WhiteSemiBold => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.whiteText,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get font18PrimaryTextBold => TextStyle(
    fontSize: 18.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font14PrimaryTextRegular => TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get font20PrimaryTextBold => TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font16PrimaryTextBold => TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.primaryText,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle get font13Regular =>
      TextStyle(fontSize: 13.sp, fontWeight: FontWeightHelper.regular);

  static TextStyle get font11Regular =>
      TextStyle(fontSize: 11.sp, fontWeight: FontWeightHelper.regular);
}
