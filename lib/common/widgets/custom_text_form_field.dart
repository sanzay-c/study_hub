import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String? initialValue; 
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged; 
  final String? hintText;
  final Widget? svgIcon;
  final bool isPassword;

  const CustomTextFormField({
    super.key,
    this.initialValue, 
    this.controller,
    this.onChanged, 
    this.hintText,
    this.svgIcon,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // controller is not needed now
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _isObscured : false,
      style: TextStyle(fontSize: 18.sp),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: const Color(0XFF4A5566),
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: widget.svgIcon,
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),

        // Add suffix icon for password toggle
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Color(0XFF4A5566),
                  size: 20.sp,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0XFF4A5566), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0XFF526DFF), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}