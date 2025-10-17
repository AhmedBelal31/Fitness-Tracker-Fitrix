import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../generated/l10n.dart';
import '../../../theming/app_colors.dart';
import '../../../theming/styles.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => _pickImage(context) : null,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsManager.primaryGreen, width: 2),
          boxShadow: ColorsManager.softShadow,
        ),
        child: selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.file(selectedImage!, fit: BoxFit.cover),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 60.sp,
                    color: ColorsManager.primaryGreen,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    S.of(context).tap_to_add_image,
                    style: TextStyles.bodyMedium.copyWith(
                      color: ColorsManager.primaryGreen,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
