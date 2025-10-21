import 'package:flutter/material.dart';
import '../../theming/app_colors.dart';

// class CustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String label;
//   final String? hint;
//   final IconData? prefixIcon;
//   final Widget? suffixIcon;
//   final bool isPassword;
//   final bool? obscureText;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;
//   final bool enabled;
//
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.hint,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.isPassword = false,
//     this.obscureText,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//     this.enabled = true,
//   });
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _isObscured = true;
//   bool _isFocused = false;
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {
//       setState(() {
//         _isFocused = _focusNode.hasFocus;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Label with adaptive color
//         SizedBox(
//           height: 44,
//           child: Align(
//             alignment: AlignmentDirectional.centerStart,
//             child: Text(
//               widget.label,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: ColorsManager.getPrimaryText(context),
//                 height: 1.3,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//
//         // 🌟 Container with glow effect on focus (dark mode only)
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: _isFocused && isDark
//                 ? [
//                     BoxShadow(
//                       color: ColorsManager.darkPrimaryGreen.withValues(
//                         alpha: 0.2,
//                       ),
//                       blurRadius: 12,
//                       spreadRadius: 0,
//                     ),
//                   ]
//                 : null,
//           ),
//           child: TextFormField(
//             controller: widget.controller,
//             focusNode: _focusNode,
//             obscureText:
//                 widget.obscureText ?? (widget.isPassword && _isObscured),
//             keyboardType: widget.keyboardType,
//             validator: widget.validator,
//             enabled: widget.enabled,
//             style: TextStyle(
//               fontSize: 16,
//               color: ColorsManager.getPrimaryText(context),
//             ),
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             decoration: InputDecoration(
//               hintText: widget.hint ?? "",
//               hintStyle: TextStyle(
//                 color: ColorsManager.getHintTextColor(context),
//                 fontSize: 14,
//               ),
//               // 🎨 UPDATED: Prefix Icon with better dark mode colors
//               prefixIcon: widget.prefixIcon != null
//                   ? AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       child: Icon(
//                         widget.prefixIcon,
//                         color: _isFocused
//                             ? ColorsManager.getPrimaryGreen(context)
//                             : ColorsManager.getIconColor(context),
//                         size: 20,
//                       ),
//                     )
//                   : null,
//
//               suffixIcon:
//                   widget.suffixIcon ??
//                   (widget.isPassword
//                       ? IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _isObscured = !_isObscured;
//                             });
//                           },
//                           icon: Icon(
//                             _isObscured
//                                 ? Icons.visibility_outlined
//                                 : Icons.visibility_off_outlined,
//                             color: ColorsManager.getIconColor(context),
//                             size: 20,
//                           ),
//                         )
//                       : null),
//
//               // Fill color
//               filled: true,
//               fillColor: ColorsManager.getInputBackground(context),
//
//               // Error styling
//               errorStyle: TextStyle(
//                 fontSize: 11,
//                 height: 1.2,
//                 color: isDark
//                     ? const Color(0xFFFF6B6B)
//                     : const Color(0xFFE53E3E),
//               ),
//               errorMaxLines: 2,
//
//               // Border styles
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(
//                   color: ColorsManager.getBorderColor(context),
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(
//                   color: ColorsManager.getBorderColor(context),
//                   width: 1,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(
//                   color: ColorsManager.getPrimaryGreen(context),
//                   width: 2,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(
//                   color: isDark
//                       ? const Color(0xFFFF6B6B)
//                       : const Color(0xFFE53E3E),
//                   width: 1,
//                 ),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(
//                   color: isDark
//                       ? const Color(0xFFFF6B6B)
//                       : const Color(0xFFE53E3E),
//                   width: 2,
//                 ),
//               ),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(
//                   color: isDark
//                       ? ColorsManager.darkBorder.withValues(alpha: 0.3)
//                       : Colors.grey.shade200,
//                 ),
//               ),
//
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool isRequired; // ✅ Added
  final int maxLines; // ✅ Added

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.obscureText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
    this.isRequired = false, // ✅ Added default
    this.maxLines = 1, // ✅ Added default
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Label with required indicator
        SizedBox(
          height: 44,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.getPrimaryText(context),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.isRequired) ...[
                  const SizedBox(width: 4),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? const Color(0xFFFF6B6B)
                          : const Color(0xFFE53E3E),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Container with glow effect on focus
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isFocused && isDark
                ? [
                    BoxShadow(
                      color: ColorsManager.darkPrimaryGreen.withValues(
                        alpha: 0.2,
                      ),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText:
                widget.obscureText ?? (widget.isPassword && _isObscured),
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            enabled: widget.enabled,
            maxLines: widget.maxLines, // ✅ Added
            style: TextStyle(
              fontSize: 16,
              color: ColorsManager.getPrimaryText(context),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: widget.hint ?? "",
              hintStyle: TextStyle(
                color: ColorsManager.getHintTextColor(context),
                fontSize: 14,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        widget.prefixIcon,
                        color: _isFocused
                            ? ColorsManager.getPrimaryGreen(context)
                            : ColorsManager.getIconColor(context),
                        size: 20,
                      ),
                    )
                  : null,
              suffixIcon:
                  widget.suffixIcon ??
                  (widget.isPassword
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: ColorsManager.getIconColor(context),
                            size: 20,
                          ),
                        )
                      : null),
              filled: true,
              fillColor: ColorsManager.getInputBackground(context),
              errorStyle: TextStyle(
                fontSize: 11,
                height: 1.2,
                color: isDark
                    ? const Color(0xFFFF6B6B)
                    : const Color(0xFFE53E3E),
              ),
              errorMaxLines: 2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: ColorsManager.getBorderColor(context),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: ColorsManager.getBorderColor(context),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: ColorsManager.getPrimaryGreen(context),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? const Color(0xFFFF6B6B)
                      : const Color(0xFFE53E3E),
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? const Color(0xFFFF6B6B)
                      : const Color(0xFFE53E3E),
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? ColorsManager.darkBorder.withValues(alpha: 0.3)
                      : Colors.grey.shade200,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
