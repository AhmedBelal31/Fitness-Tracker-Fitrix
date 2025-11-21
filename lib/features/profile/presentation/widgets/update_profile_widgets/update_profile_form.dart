import 'package:fitrix/features/profile/presentation/widgets/update_profile_widgets/personal_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/data/models/params/update_profile_params.dart';
import '../../cubits/update_profile_cubit/update_profile_cubit.dart';
import '../../cubits/update_profile_cubit/update_profile_state.dart';
import 'measurements_section.dart';
import 'section_reorder_bottom_sheet.dart';
import 'update_profile_form_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'profile_tutorial.dart';
import 'dart:convert';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/common_ui/widgets/custom_button.dart';
import 'update_profile_validators.dart';

class UpdateProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UpdateProfileFormController controller;
  final AnimationController animController;

  const UpdateProfileForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.animController,
  });

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final GlobalKey _heightKey = GlobalKey();
  final GlobalKey _weightKey = GlobalKey();
  final GlobalKey _bodyFatKey = GlobalKey();
  final GlobalKey _muscleMassKey = GlobalKey();

  // TutorialCoachMark? _tutorialCoachMark;
  final _validators = UpdateProfileValidators();

  List<String> _sectionOrder = ['personal', 'measurements'];
  final Map<String, bool> _expandedSections = {
    'personal': true,
    'measurements': true,
  };

  static const String _sectionOrderKey = 'profile_section_order';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadSectionOrder();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  Future<void> _loadSectionOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getString(_sectionOrderKey);

    if (savedOrder != null) {
      final List<dynamic> decoded = jsonDecode(savedOrder);
      setState(() {
        _sectionOrder = decoded.cast<String>();
      });
    }
  }

  Future<void> _saveSectionOrder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sectionOrderKey, jsonEncode(_sectionOrder));
  }

  Future<void> _checkAndShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenTutorial = prefs.getBool('has_seen_profile_tutorial') ?? false;

    if (!hasSeenTutorial) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) _showTutorial();
      });
    }
  }

  void _showTutorial() async {
    setState(() {
      _expandedSections['measurements'] = true;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    // _tutorialCoachMark = ProfileTutorial.createTutorial(
    //   context: context,
    //   heightKey: _heightKey,
    //   weightKey: _weightKey,
    //   bodyFatKey: _bodyFatKey,
    //   muscleMassKey: _muscleMassKey,
    //   onFinish: () async {
    //     final prefs = await SharedPreferences.getInstance();
    //     await prefs.setBool('has_seen_profile_tutorial', true);
    //   },
    // );
    // _tutorialCoachMark?.show(context: context);
  }

  void _showReorderBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SectionReorderBottomSheet(
        currentOrder: _sectionOrder,
        onReorder: (newOrder) {
          setState(() {
            _sectionOrder = newOrder;
          });
          _saveSectionOrder();
        },
      ),
    );
  }

  void _submitProfile() {
    if (!widget.formKey.currentState!.validate()) return;

    final formData = widget.controller.getFormData();

    int genderInt = 1;
    if (widget.controller.selectedGender == 'Female') {
      genderInt = 2;
    }

    final params = UpdateProfileParams(
      firstName: formData['firstName'] as String,
      lastName: formData['lastName'] as String,
      gender: genderInt,
      phoneNumber: formData['phoneNumber'] as String?,
      birthDate: formData['birthDate'] as DateTime?,
      heightCm: formData['heightCm'] != null
          ? (formData['heightCm'] as double).toInt()
          : null,
      weightKg: formData['weightKg'] as double?,
      weightGoal: formData['goalWeightKg'] as double?,
      bodyFatPercent: formData['bodyFatPercentage'] as double?,
      bodyFatGoal: formData['goalBodyFatPercentage'] as double?,
      muscleMassKg: formData['muscleMassKg'] as double?,
      muscleMassGoal: formData['goalMuscleMassKg'] as double?,
    );

    context.read<UpdateProfileCubit>().updateProfile(params);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _AnimatedItem(
            controller: widget.animController,
            index: 2,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: OutlinedButton.icon(
                onPressed: _showReorderBottomSheet,
                icon: Icon(
                  Icons.swap_vert,
                  color: ColorsManager.getPrimaryGreen(context),
                ),
                label: Text(
                  s.reorder_sections,
                  style: TextStyle(
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),
          ..._sectionOrder.map((section) => _buildSection(section, s, isDark)),
          SizedBox(height: 24.h),
          _AnimatedItem(
            controller: widget.animController,
            index: 3,
            child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
              builder: (context, state) {
                return CustomButton(
                  text: s.saveChanges,
                  icon: Icons.save,
                  isLoading: state.isLoading,
                  onPressed: state.isLoading
                      ? null
                      : () {
                          setState(() {});
                          if (widget.formKey.currentState!.validate() &&
                              _validators.validateGender(
                                    widget.controller.selectedGender,
                                    context,
                                  ) ==
                                  null) {
                            _submitProfile();
                          }
                        },
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSection(String section, S s, bool isDark) {
    return Container(
      key: ValueKey(section),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: _expandedSections[section] ?? true,
        onExpansionChanged: (expanded) {
          setState(() => _expandedSections[section] = expanded);
        },
        title: Text(
          _getSectionTitle(section, s),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        trailing: Icon(
          _expandedSections[section] ?? true
              ? Icons.expand_less
              : Icons.expand_more,
          color: ColorsManager.getPrimaryGreen(context),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _getSectionContent(section),
          ),
        ],
      ),
    );
  }

  String _getSectionTitle(String section, S s) {
    switch (section) {
      case 'personal':
        return s.personal_information;
      case 'measurements':
        return s.body_measurements_and_goals;
      default:
        return '';
    }
  }

  Widget _getSectionContent(String section) {
    switch (section) {
      case 'personal':
        return PersonalInfoSection(controller: widget.controller);
      case 'measurements':
        return MeasurementsSection(
          controller: widget.controller,
          heightKey: _heightKey,
          weightKey: _weightKey,
          bodyFatKey: _bodyFatKey,
          muscleMassKey: _muscleMassKey,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _tutorialCoachMark?.finish();
    super.dispose();
  }
}

class _AnimatedItem extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const _AnimatedItem({
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final delay = (index * 0.08).clamp(0.0, 0.7);
    final end = (delay + 0.3).clamp(delay + 0.1, 1.0);

    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay, end, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
