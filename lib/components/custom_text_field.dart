import 'package:flutter/material.dart';
import 'package:tt_25/core/app_fonts.dart';
import 'package:tt_25/core/colors.dart';

class CustomTextField extends StatefulWidget {
  final Function onChange;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? initialValue;
  const CustomTextField(
      {super.key,
      required this.onChange,
      this.hintText,
      this.keyboardType,
      this.initialValue});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    if (widget.initialValue != null) {
      _textEditingController.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: _textEditingController,
      keyboardType: widget.keyboardType,
      style: AppFonts.bodyMedium.copyWith(color: AppColors.white),
      cursorColor: AppColors.white,
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      onChanged: (value) {
        widget.onChange(value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        fillColor: AppColors.primary,
        filled: true,
        hintText: widget.hintText,
        hintStyle: AppFonts.bodyMedium.copyWith(color: AppColors.darkGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Круглый border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              30), // Круглый border для активного состояния
          borderSide:
              const BorderSide(color: AppColors.background), // Цвет рамки
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(30), // Круглый border для состояния фокуса
          borderSide: const BorderSide(
              color: AppColors.primary), // Цвет рамки при фокусе
        ),
      ),
    );
  }
}
