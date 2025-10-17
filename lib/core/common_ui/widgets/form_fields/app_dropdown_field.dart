import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theming/app_colors.dart';
import '../../../theming/styles.dart';

// class AppDropdownField extends StatelessWidget {
//   final String label;
//   final String hintText;
//   final String? value;
//   final List<String> items;
//   final bool enabled;
//   final bool isRequired;
//   final ValueChanged<String?> onChanged;
//
//   const AppDropdownField({
//     super.key,
//     required this.label,
//     required this.hintText,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.enabled = true,
//     this.isRequired = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(isRequired ? '$label *' : label, style: TextStyles.subtitle1),
//         SizedBox(height: 8.h),
//         DropdownButtonFormField<String>(
//           value: value,
//           hint: Text(
//             hintText,
//             style: TextStyles.bodyMedium.copyWith(
//               color: Colors.grey[600], // ✅ Same as AppTextField
//             ),
//           ),
//           items: items.map((item) {
//             return DropdownMenuItem(
//               value: item,
//               child: Text(
//                 item,
//                 style: TextStyles.bodyMedium.copyWith(
//                   color: ColorsManager.primaryText,
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: enabled ? onChanged : null,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: ColorsManager.inputBackground,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 16.h,
//             ),
//           ),
//           dropdownColor: ColorsManager.cardBackground,
//           icon: Icon(Icons.arrow_drop_down, color: ColorsManager.primaryText),
//           style: TextStyles.bodyMedium.copyWith(
//             color: ColorsManager.primaryText,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theming/app_colors.dart';
import '../../../theming/styles.dart';

class AppDropdownField extends StatefulWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final bool enabled;
  final bool isRequired;
  final ValueChanged<String?> onChanged;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.enabled = true,
    this.isRequired = false,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isRequired ? '${widget.label} *' : widget.label,
          style: TextStyles.subtitle1,
        ),
        SizedBox(height: 8.h),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: _isOpen
                ? [
                    BoxShadow(
                      color: ColorsManager.primaryGreen.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: DropdownButtonFormField<String>(
            value: widget.value,
            hint: Text(
              widget.hintText,
              style: TextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
            ),
            items: widget.items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyles.bodyMedium.copyWith(
                    color: ColorsManager.primaryText,
                  ),
                ),
              );
            }).toList(),
            onChanged: widget.enabled ? widget.onChanged : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorsManager.inputBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
            dropdownColor: ColorsManager.cardBackground,
            icon: AnimatedRotation(
              turns: _isOpen ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.arrow_drop_down,
                color: ColorsManager.primaryText,
              ),
            ),
            style: TextStyles.bodyMedium.copyWith(
              color: ColorsManager.primaryText,
            ),
            onTap: () => setState(() => _isOpen = true),
          ),
        ),
      ],
    );
  }
}
