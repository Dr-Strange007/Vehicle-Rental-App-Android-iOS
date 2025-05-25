import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../utils/basic_screen_imports.dart';
import '../../controller/date_picker/date_picker_controller.dart';
import '../../language/language_controller.dart';
import '../others/custom_image_widget.dart';

/// >>> Border Side Style
enum BSS {
  enabledBorder,
  b,
  disableBorder,
  focusedBorder,
  errorBorder,
  focusedErrorBorder
}

enum BorderStyle {
  outline,
  underline,
  none,
}

// ignore: must_be_immutable
class PrimaryInputWidget extends StatefulWidget {
  final String hintText, label, phoneCode;
  final String? prefixIconPath;
  final int maxLines;
  final bool isValidator;
  final bool isPasswordField;
  final bool autoFocus;
  final bool readOnly;
  final bool isFilled;
  final bool showBorderSide;
  final bool validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? padding;
  final double? radius;
  final double borderWidth;
  final Color? fillColor;
  final Color? shadowColor;
  final bool? isDate;
  final bool? isTime;
  final Function(String)? onChanged;
  final Decoration? customShapeDecoration;
  final EdgeInsetsGeometry? customPadding;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final AlignmentGeometry? alignment;
  final BorderStyle borderStyle;
  Rx<DateTime>? selectDate;

  PrimaryInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIconPath = "",
    this.phoneCode = "",
    this.isValidator = true,
    this.isPasswordField = false,
    this.isFilled = true,
    this.validator = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.borderWidth = 2,
    this.radius,
    this.customPadding,
    this.padding,
    required this.label,
    this.textInputType,
    this.inputFormatters,
    this.alignment,
    this.shadowColor,
    this.borderStyle = BorderStyle.outline,
    this.fillColor,
    this.showBorderSide = false,
    this.customShapeDecoration,
    this.onChanged,
    this.isDate = false,
    this.isTime = false,
    this.selectDate,
  });

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
  FocusNode? focusNode;
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  // @override
  // void dispose() {
  //   focusNode!.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: Get.find<LanguageController>().getTranslation(widget.hintText),
      hintStyle: TextStyle(
        fontSize: Dimensions.headingTextSize3,
        fontWeight: FontWeight.w500,
        color: CustomColor.deactivateColor,
      ),
      border: _setBorderStyle(BSS.b),
      enabledBorder: _setBorderStyle(BSS.enabledBorder),
      focusedBorder: _setBorderStyle(BSS.focusedBorder),
      disabledBorder: _setBorderStyle(BSS.disableBorder),
      errorBorder: _setBorderStyle(BSS.errorBorder),
      focusedErrorBorder: _setBorderStyle(BSS.focusedErrorBorder),
      prefixIcon: _setPrefixIcon(),
      suffixIcon: _setSuffixIcon(),
      fillColor: _setFillColor(context),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _buildTextFormFieldWidget(BuildContext context) {
    final datePickerController = Get.put(DatePickerController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        Container(
          decoration: _buildShapeDecoration(context),
          margin: EdgeInsets.zero,
          child: TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controller,
            focusNode: focusNode,
            autofocus: widget.autoFocus,
            style: _setFontStyle(),
            inputFormatters: widget.inputFormatters,
            obscureText: widget.isPasswordField ? isVisibility : false,
            textInputAction: TextInputAction.next,
            keyboardType: widget.textInputType,
            maxLines: widget.maxLines,
            decoration: _buildDecoration(),
            validator: _setValidator(),
            cursorColor: Get.isDarkMode
                ? CustomColor.primaryDarkTextColor
                : CustomColor.primaryLightTextColor,
            onChanged: widget.onChanged,
            onTap: () async {
              if (!widget.readOnly) {
                setState(() {
                  focusNode!.requestFocus();
                });
              } else {
                if (widget.isDate == true) {
                  if (widget.isTime == true) {
                    await datePickerController.selectTime(context);

                    widget.controller.text = DateFormat('HH:mm')
                        .format(datePickerController.selectedTime.value);
                  } else {
                    await datePickerController.selectDate(context);
                    widget.controller.text = DateFormat('yyyy-MM-dd')
                        .format(datePickerController.selectedDate.value);
                  }
                }
              }
            },
          ),
        ),
      ],
    );
  }

  _buildTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: crossStart,
          children: [
            Obx(
              () => Get.find<LanguageController>().isLoading
                  ? Text(
                      widget.label,
                      style: CustomStyle.darkHeading3TextStyle.copyWith(
                        color: CustomColor.primaryLightTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Text(
                      Get.find<LanguageController>()
                          .getTranslation(widget.label),
                      style: CustomStyle.darkHeading3TextStyle.copyWith(
                        color: CustomColor.primaryLightTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
            Visibility(
              visible: !widget.isValidator,
              child: Obx(
                () => Get.find<LanguageController>().isLoading
                    ? Text(
                        " (${Strings.optional})",
                        style: CustomStyle.darkHeading3TextStyle.copyWith(
                          color: CustomColor.primaryLightColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        " (${Get.find<LanguageController>().getTranslation(Strings.optional)})",
                        style: CustomStyle.darkHeading3TextStyle.copyWith(
                          color: CustomColor.primaryLightColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * 0.75),
      ],
    );
  }

  _setBorderSide(borderSideStyle) {
    switch (borderSideStyle) {
      case BSS.enabledBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
      case BSS.b:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
      case BSS.disableBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
      case BSS.focusedBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: Theme.of(context).primaryColor,
        );
      case BSS.errorBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: Colors.red,
        );
      case BSS.focusedErrorBorder:
        return BorderSide(
          width: widget.borderWidth,
          color: Colors.red,
        );
      default:
        return BorderSide(
          width: widget.borderWidth,
          color: CustomColor.primaryLightTextColor.withOpacity(0.2),
        );
    }
  }

  _setBorderStyle(borderSideStyle) {
    switch (widget.borderStyle) {
      case BorderStyle.outline:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );
      case BorderStyle.underline:
        return UnderlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );

      case BorderStyle.none:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: widget.showBorderSide
              ? _setBorderSide(borderSideStyle)
              : BorderSide.none,
        );
    }
  }

  _setFillColor(BuildContext context) {
    return widget.fillColor ?? Theme.of(context).primaryColor;
  }

  _setFilled() {
    return widget.isFilled;
  }

  _setFontStyle() {
    return CustomStyle.darkHeading3TextStyle.copyWith(
      color: focusNode!.hasFocus
          ? CustomColor.primaryLightTextColor
          : widget.controller.text.isNotEmpty
              ? CustomColor.primaryLightTextColor
              : CustomColor.primaryLightTextColor,
    );
  }

  _setOutlineBorderRadius() {
    return BorderRadius.circular(widget.radius ?? Dimensions.radius * 0.5);
  }

  _setPadding() {
    return widget.customPadding ??
        (widget.padding == null
            ? EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize * 1.75,
                vertical: Dimensions.heightSize * 1.2,
              )
            : EdgeInsets.all(widget.padding!));
  }

  _setPrefixIcon() {
    return widget.prefixIcon ??
        (widget.prefixIconPath != ''
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSize * 0.4),
                child: Row(
                  mainAxisSize: mainMin,
                  children: [
                    CustomImageWidget(
                      path: widget.prefixIconPath!,
                      color: focusNode!.hasFocus
                          ? Theme.of(context).primaryColor
                          : Get.isDarkMode
                              ? CustomColor.primaryDarkTextColor
                                  .withOpacity(0.50)
                              : CustomColor.primaryLightTextColor
                                  .withOpacity(0.50),
                    ),
                    Visibility(
                      visible: widget.phoneCode != '',
                      child: Row(
                        children: [
                          Text(
                            widget.phoneCode,
                            style: TextStyle(
                              fontSize: Dimensions.headingTextSize3,
                              fontWeight: FontWeight.w500,
                              color: focusNode!.hasFocus
                                  ? Theme.of(context).primaryColor
                                  : CustomColor.primaryLightTextColor
                                      .withOpacity(0.2),
                            ),
                          ).marginOnly(
                            left: Dimensions.marginSizeHorizontal * 0.3,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: Dimensions.marginSizeHorizontal * 0.3,
                            ),
                            height: Dimensions.heightSize * 1.5,
                            width: 1,
                            color: focusNode!.hasFocus
                                ? Theme.of(context).primaryColor
                                : CustomColor.primaryLightTextColor
                                    .withOpacity(0.2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : null);
  }

  _setSuffixIcon() {
    return widget.isPasswordField
        ? IconButton(
            icon: Icon(
              isVisibility
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: focusNode!.hasFocus
                  ? Theme.of(context).primaryColor
                  : Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
                      : CustomColor.primaryLightTextColor.withOpacity(0.50),
              size: Dimensions.iconSizeDefault,
            ),
            onPressed: () {
              setState(() {
                isVisibility = !isVisibility;
              });
            },
          )
        : widget.suffixIcon;
  }

  _setValidator() {
    return widget.isValidator == false
        ? null
        : (String? value) {
            if (value!.isEmpty) {
              return Get.find<LanguageController>()
                  .getTranslation(Strings.pleaseFillOutTheField);
            } else {
              return null;
            }
          };
  }

  _buildShapeDecoration(BuildContext context) {
    return focusNode!.hasFocus
        ? widget.customShapeDecoration ??
            ShapeDecoration(
              color: CustomColor.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000), // fixed color
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            )
        : ShapeDecoration(
            color: CustomColor.primaryBGLightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            ),
          );
  }
}
