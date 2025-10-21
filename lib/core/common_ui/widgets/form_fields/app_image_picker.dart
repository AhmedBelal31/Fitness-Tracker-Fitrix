import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../generated/l10n.dart';
import '../../../theming/app_colors.dart';
import '../../../theming/styles.dart';

// class AppImagePicker extends StatelessWidget {
//   final File? selectedImage;
//   final bool enabled;
//   final Function(File?) onImagePicked;
//
//   const AppImagePicker({
//     super.key,
//     required this.selectedImage,
//     required this.onImagePicked,
//     this.enabled = true,
//   });
//
//   Future<void> _pickImage(BuildContext context) async {
//     try {
//       final ImagePicker imagePicker = ImagePicker();
//       final XFile? pickedFile = await imagePicker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );
//
//       if (pickedFile != null) {
//         onImagePicked(File(pickedFile.path));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to pick image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: enabled ? () => _pickImage(context) : null,
//       child: Container(
//         height: 200.h,
//         decoration: BoxDecoration(
//           color: ColorsManager.cardBackground,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: ColorsManager.primaryGreen, width: 2),
//           boxShadow: ColorsManager.softShadow,
//         ),
//         child: selectedImage != null
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(12.r),
//                 child: Image.file(selectedImage!, fit: BoxFit.cover),
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.add_photo_alternate,
//                     size: 60.sp,
//                     color: ColorsManager.primaryGreen,
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     S.of(context).tap_to_add_image,
//                     style: TextStyles.bodyMedium.copyWith(
//                       color: ColorsManager.primaryGreen,
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

class AppImagePicker extends StatelessWidget {
  final File? selectedImage;
  final bool enabled;
  final Function(File?) onImagePicked;

  const AppImagePicker({
    super.key,
    required this.selectedImage,
    required this.onImagePicked,
    this.enabled = true,
  });

  Future<void> _pickImage(BuildContext context) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        onImagePicked(File(pickedFile.path));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: enabled ? () => _pickImage(context) : null,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.getPrimaryGreen(context),
            width: 2,
          ),
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
        child: selectedImage != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
                  // Edit overlay
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 20.sp),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: isDark ? 0.2 : 0.1),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 48.sp,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    S.of(context).tap_to_add_image,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Optional',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
