import 'package:flutter/material.dart';
import 'package:tt_25/core/colors.dart';

enum _Variant { standart, alert }

class CustomButton extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? highlightColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? width;
  final Function onTap;
  final bool? isValid;
  final _Variant _variant;

  const CustomButton(
      {super.key,
      required this.title,
      this.titleStyle,
      this.backgroundColor,
      this.highlightColor,
      this.isValid,
      this.padding,
      this.width,
      this.borderRadius,
      required this.onTap})
      : _variant = _Variant.standart;

  const CustomButton.alert({
    super.key,
    required this.title,
    this.highlightColor,
    required this.onTap,
    this.titleStyle,
    this.width,
    this.borderRadius,
    this.padding,
    this.isValid = true,
  })  : backgroundColor = Colors.transparent,
        _variant = _Variant.alert;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          widget.isValid ?? true ? widget.backgroundColor : AppColors.secondary,
      borderRadius: widget.borderRadius,
      child: InkWell(
        highlightColor: widget.highlightColor ?? Colors.white.withOpacity(0.7),
        borderRadius: widget.borderRadius,
        onTap: widget.isValid ?? true
            ? () {
                widget.onTap();
              }
            : null,
        child: Container(
            padding: widget.padding ??
                EdgeInsets.symmetric(
                    vertical: widget._variant == _Variant.alert ? 5 : 10,
                    horizontal: widget._variant == _Variant.alert ? 10 : 0),
            width: widget.width ??
                (widget._variant == _Variant.standart ? double.infinity : null),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.transparent,
            ),
            child: widget._variant == _Variant.standart
                ? Center(
                    child: Text(
                      widget.title,
                      style: widget.titleStyle?.copyWith(
                          color: widget.isValid ?? true
                              ? widget.titleStyle?.color
                              : AppColors.white.withOpacity(0.5)),
                    ),
                  )
                : Text(
                    widget.title,
                    style: widget.titleStyle,
                  )),
      ),
    );
  }
}
