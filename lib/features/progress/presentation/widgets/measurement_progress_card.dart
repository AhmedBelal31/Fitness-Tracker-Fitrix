import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/progress_models.dart';

class MeasurementProgressCard extends StatelessWidget {
  final MeasurementCardsResponse cards;
  final MeasurementCardType type;

  const MeasurementProgressCard({
    super.key,
    required this.cards,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final cardData = _getCardData(s);

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: cardData.gradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: cardData.gradient.colors.first.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(cardData),
          SizedBox(height: 16.h),
          _buildStatsContainer(cardData, s), // ✅ Pass localization
        ],
      ),
    );
  }

  Widget _buildHeader(_CardData cardData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildIconAndTitle(cardData), _buildChangeBadge(cardData)],
    );
  }

  Widget _buildIconAndTitle(_CardData cardData) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(cardData.icon, color: Colors.white, size: 14.sp),
        ),
        SizedBox(width: 4.w),
        Text(
          cardData.title,
          style: TextStyles.font16WhiteSemiBold.copyWith(
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChangeBadge(_CardData cardData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            cardData.isGoodChange ? Icons.trending_down : Icons.trending_up,
            size: 14.sp,
            color: Colors.white,
          ),
          SizedBox(width: 4.w),
          Text(
            '${cardData.change.abs().toStringAsFixed(1)} ${cardData.unit}',
            style: TextStyles.font12WhiteSemiBold.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsContainer(_CardData cardData, S locale) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(
            locale.current2,
            cardData.lastValue.toStringAsFixed(1),
            cardData.unit,
          ),
          _buildDivider(),
          _buildStat(
            locale.start,
            cardData.firstValue.toStringAsFixed(1),
            cardData.unit,
          ),
          _buildDivider(),
          _buildStat(
            locale.goal,
            cardData.goal != null ? cardData.goal!.toStringAsFixed(1) : '-',
            cardData.goal != null ? cardData.unit : '',
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyles.font12Bold.copyWith(
            color: Colors.black.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        RichText(
          text: TextSpan(
            text: value,
            style: TextStyles.font18WhiteBold.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
            ),
            children: [
              TextSpan(
                text: ' $unit',
                style: TextStyles.font10WhiteRegular.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
      ),
    );
  }

  _CardData _getCardData(S s) {
    switch (type) {
      case MeasurementCardType.weight:
        return _CardData(
          title: s.weight,
          icon: Icons.monitor_weight,
          gradient: ColorsManager.weightCardGradient,
          firstValue: cards.weightCard.firstWeight,
          lastValue: cards.weightCard.lastWeight,
          goal: cards.weightCard.weightGoal,
          change: cards.weightCard.weightLost,
          unit: s.kg,
          isPositiveGood: false,
        );

      case MeasurementCardType.bodyFat:
        return _CardData(
          title: s.body_fat,
          icon: Icons.water_drop,
          gradient: ColorsManager.bodyFatCardGradient,
          firstValue: cards.bodyFatCard.firstBodyFat,
          lastValue: cards.bodyFatCard.lastBodyFat,
          goal: cards.bodyFatCard.bodyFatGoal,
          change: cards.bodyFatCard.bodyFatLost,
          unit: '%',
          isPositiveGood: false,
        );

      case MeasurementCardType.muscleMass:
        return _CardData(
          title: s.muscle_mass,
          icon: Icons.fitness_center,
          gradient: ColorsManager.muscleMassCardGradient,
          firstValue: cards.muscleMassCard.firstMuscleMass,
          lastValue: cards.muscleMassCard.lastMuscleMass,
          goal: cards.muscleMassCard.muscleMassGoal,
          change: cards.muscleMassCard.muscleMassGained,
          unit: s.kg,
          isPositiveGood: true,
        );
    }
  }
}

class _CardData {
  final String title;
  final IconData icon;
  final LinearGradient gradient;
  final double firstValue;
  final double lastValue;
  final double? goal;
  final double change;
  final String unit;
  final bool isPositiveGood;

  _CardData({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.firstValue,
    required this.lastValue,
    required this.goal,
    required this.change,
    required this.unit,
    required this.isPositiveGood,
  });

  bool get isGoodChange => isPositiveGood
      ? change >
            0 // Muscle gain: positive is good
      : change < 0; // Weight/fat loss: negative is good
}
