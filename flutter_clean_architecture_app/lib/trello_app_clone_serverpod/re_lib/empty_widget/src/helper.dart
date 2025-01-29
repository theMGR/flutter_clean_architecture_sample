import 'package:flutter/material.dart';

import 'utility.dart';

class CustomText extends StatefulWidget {
  const CustomText({super.key, this.msg, this.style, this.textAlign, this.overflow, this.context, this.softwrap});

  final BuildContext? context;
  final String? msg;
  final TextOverflow? overflow;
  final bool? softwrap;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  TextStyle? style;

  @override
  @override
  void initState() {
    style = widget.style;
    super.initState();
  }

  Widget customText() {
    if (widget.msg == null) {
      return Container();
    }
    if (widget.context != null && widget.style != null) {
      var font = widget.style!.fontSize == null ? Theme.of(context).textTheme.bodyMedium!.fontSize! : widget.style!.fontSize!;
      style = widget.style!.copyWith(fontSize: font - (EmptyWidgetUtility.fullWidth(context) <= 375 ? 2 : 0));
    }
    return Text(
      widget.msg!,
      style: widget.style,
      textAlign: widget.textAlign,
      overflow: widget.overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return customText();
  }
}
