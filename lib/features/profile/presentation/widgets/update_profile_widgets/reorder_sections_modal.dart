import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

class ReorderSectionsModal extends StatefulWidget {
  final List<String> sectionOrder;
  final Function(List<String>) onReorder;

  const ReorderSectionsModal({
    required this.sectionOrder,
    required this.onReorder,
  });

  @override
  State<ReorderSectionsModal> createState() => _ReorderSectionsModalState();
}

class _ReorderSectionsModalState extends State<ReorderSectionsModal> {
  late List<String> _currentOrder;

  @override
  void initState() {
    super.initState();
    _currentOrder = List.from(widget.sectionOrder);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.reorder_sections, style: TextStyles.headline3),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Text(
            s.drag_sections_instruction,
            style: TextStyles.bodySmall.copyWith(
              color: ColorsManager.lightText,
            ),
          ),
          SizedBox(height: 24.h),

          // ✅ Compact reorderable list
          ReorderableListView(
            shrinkWrap: true,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = _currentOrder.removeAt(oldIndex);
                _currentOrder.insert(newIndex, item);
              });
            },
            children: _currentOrder.asMap().entries.map((entry) {
              final index = entry.key;
              final sectionKey = entry.value;

              return _buildReorderItem(sectionKey, index + 1, s);
            }).toList(),
          ),

          SizedBox(height: 24.h),

          CustomButton(
            text: s.apply_order,
            icon: Icons.check,
            onPressed: () {
              widget.onReorder(_currentOrder);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReorderItem(String sectionKey, int number, S s) {
    final title = sectionKey == 'personal'
        ? s.personal_information
        : s.body_measurements_and_goals;

    final icon = sectionKey == 'personal' ? Icons.person : Icons.fitness_center;

    return Container(
      key: ValueKey(sectionKey),
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: ColorsManager.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyles.font16WhiteRegular,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Icon(icon, color: ColorsManager.primaryGreen, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(title, style: TextStyles.font16PrimaryTextSemiBold),
          ),
          Icon(
            Icons.drag_handle,
            color: ColorsManager.primaryGreen,
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}
