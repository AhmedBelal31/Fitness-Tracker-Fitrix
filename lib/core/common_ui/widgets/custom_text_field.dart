import 'package:flutter/material.dart';

// class CustomTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String label;
//   final String? hint;
//   final IconData? prefixIcon;
//   final bool isPassword;
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
//     this.isPassword = false,
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // ✅ Fixed height container for label to ensure alignment
//         SizedBox(
//           height: 44, // Fixed height for up to 2 lines (22px per line)
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               widget.label,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF2D3748),
//                 height: 1.3, // Line height
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: widget.controller,
//           obscureText: widget.isPassword && _isObscured,
//           keyboardType: widget.keyboardType,
//           validator: widget.validator,
//           enabled: widget.enabled,
//           style: const TextStyle(fontSize: 16, color: Color(0xFF2D3748)),
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           decoration: InputDecoration(
//             hintText: widget.hint ?? "",
//             hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
//             prefixIcon: widget.prefixIcon != null
//                 ? Icon(
//                     widget.prefixIcon,
//                     color: const Color(0xFF48BB78),
//                     size: 20,
//                   )
//                 : null,
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _isObscured = !_isObscured;
//                       });
//                     },
//                     icon: Icon(
//                       _isObscured
//                           ? Icons.visibility_outlined
//                           : Icons.visibility_off_outlined,
//                       color: Colors.grey.shade600,
//                       size: 20,
//                     ),
//                   )
//                 : null,
//             filled: true,
//             fillColor: Colors.grey.shade50,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: const BorderSide(color: Color(0xFF48BB78), width: 2),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: const BorderSide(color: Color(0xFFE53E3E)),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 2),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 16,
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
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fixed height container for label
        SizedBox(
          height: 44,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _isObscured,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.enabled,
          style: const TextStyle(fontSize: 16, color: Color(0xFF2D3748)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hint ?? "",
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: const Color(0xFF48BB78),
                    size: 20,
                  )
                : null,
            suffixIcon: widget.isPassword
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
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  )
                : null,
            filled: true,
            fillColor: Colors.grey.shade50,
            // ✅ Smaller error text style
            errorStyle: const TextStyle(
              fontSize: 11,
              height: 1.2,
              color: Color(0xFFE53E3E),
            ),
            // ✅ Reduce error max lines if needed
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF48BB78), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE53E3E)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
