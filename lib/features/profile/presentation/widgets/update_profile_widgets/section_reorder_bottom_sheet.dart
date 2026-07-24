import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/app_colors.dart';
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

class _SectionReorderBottomSheetState extends State<SectionReorderBottomSheet>
    with SingleTickerProviderStateMixin {
  late List<String> _tempOrder;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _tempOrder = List.from(widget.currentOrder);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
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
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color:
                    (isDark
                            ? ColorsManager.darkBorder
                            : ColorsManager.lightBorder)
                        .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.getPrimaryGreen(
                      context,
                    ).withValues(alpha: isDark ? 0.2 : 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.swap_vert,
                    color: ColorsManager.getPrimaryGreen(context),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.reorder_sections,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        s.drag_to_reorder_sections,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              constraints: BoxConstraints(maxHeight: 0.5.sh),
              decoration: BoxDecoration(
                color: isDark
                    ? ColorsManager.darkInputBackground
                    : ColorsManager.lightInputBackground,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isDark
                      ? ColorsManager.darkBorder
                      : ColorsManager.lightBorder,
                ),
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
                  return _buildSectionItem(_tempOrder[index], index, s, isDark);
                },
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(
                        color: isDark
                            ? ColorsManager.darkBorder
                            : ColorsManager.lightBorder,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      s.cancel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.getPrimaryText(context),
                      ),
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
                      backgroundColor: ColorsManager.getPrimaryGreen(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      s.save,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? ColorsManager.darkScaffold
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionItem(String section, int index, S s, bool isDark) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(section),
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 100)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: isDark ? 0.2 : 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Icon(
                _getSectionIcon(section),
                color: ColorsManager.getPrimaryGreen(context),
                size: 24.sp,
              ),
            ),
          ),
          title: Text(
            _getSectionTitle(section, s),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          trailing: Icon(
            Icons.drag_handle,
            color: ColorsManager.getSecondaryText(context),
            size: 24.sp,
          ),
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
