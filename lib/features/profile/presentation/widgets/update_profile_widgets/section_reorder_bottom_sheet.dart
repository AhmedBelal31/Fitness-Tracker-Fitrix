// lib/features/profile/presentation/widgets/update_profile_widgets/section_reorder_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../generated/l10n.dart';

class SectionReorderBottomSheet extends StatefulWidget {
  final List<String> currentOrder;
  final Function(List<String>) onReorder;

  const SectionReorderBottomSheet({
    super.key,
    required this.currentOrder,
    required this.onReorder,
  });

  @override
  State<SectionReorderBottomSheet> createState() =>
      _SectionReorderBottomSheetState();
}

class _SectionReorderBottomSheetState extends State<SectionReorderBottomSheet> {
  late List<String> _tempOrder;

  @override
  void initState() {
    super.initState();
    _tempOrder = List.from(widget.currentOrder);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.scaffoldBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorsManager.lightText.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Row(
            children: [
              Icon(
                Icons.swap_vert,
                color: ColorsManager.primaryGreen,
                size: 28.sp,
              ),
              SizedBox(width: 12.w),
              Text(s.reorder_sections, style: TextStyles.font20PrimaryTextBold),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            s.drag_to_reorder_sections,
            style: TextStyles.font14SecondaryTextRegular,
          ),
          SizedBox(height: 24.h),

          // Reorderable List
          Container(
            constraints: BoxConstraints(maxHeight: 0.5.sh),
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorsManager.lightBorder),
            ),
            child: ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: _tempOrder.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final item = _tempOrder.removeAt(oldIndex);
                  _tempOrder.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                final section = _tempOrder[index];
                return _buildSectionItem(section, index, s);
              },
            ),
          ),
          SizedBox(height: 24.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: ColorsManager.lightBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    s.cancel,
                    style: TextStyles.font14PrimaryTextMedium,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onReorder(_tempOrder);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(s.section_order_saved),
                        backgroundColor: ColorsManager.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    backgroundColor: ColorsManager.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(s.save, style: TextStyles.font14WhiteMedium),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionItem(String section, int index, S s) {
    return Container(
      key: ValueKey(section),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorsManager.scaffoldBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.primaryGreen.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: ColorsManager.primaryGreen.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Icon(
              _getSectionIcon(section),
              color: ColorsManager.primaryGreen,
              size: 24.sp,
            ),
          ),
        ),
        title: Text(
          _getSectionTitle(section, s),
          style: TextStyles.font16PrimaryTextSemiBold,
        ),
        trailing: Icon(
          Icons.drag_handle,
          color: ColorsManager.lightText,
          size: 24.sp,
        ),
      ),
    );
  }

  IconData _getSectionIcon(String section) {
    switch (section) {
      case 'personal':
        return Icons.person;
      case 'measurements':
        return Icons.monitor_weight;
      default:
        return Icons.info;
    }
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
}
