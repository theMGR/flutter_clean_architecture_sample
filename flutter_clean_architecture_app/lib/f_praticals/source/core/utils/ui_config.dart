import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flearn/f_praticals/source/constants/color_constants.dart';
import 'package:flearn/f_praticals/source/constants/release_constant.dart';
import 'package:flearn/f_praticals/source/core/ui_lib/widgets/dropdown_button2/dropdown_button2.dart';
import 'package:flearn/f_praticals/source/core/utils/d_mapper.dart';
import 'package:flearn/f_praticals/source/core/utils/file_picker_utils.dart';
import 'package:flearn/f_praticals/source/core/utils/ui_utils.dart';
import 'package:flearn/f_praticals/source/core/utils/validation_utils.dart';
import 'package:flearn/f_praticals/source/data/remote/model/documents_module_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
/*
import 'package:photo_view/photo_view.dart';
import 'package:project/core/utils/input_type_utils.dart';
import 'package:project/core/utils/validation_utils.dart';
import 'package:project/presentation/res/colors/app_colors/app_colors.dart';
*/

/// get customised widgets
class UIConfig {
  /*static Color? iconColor = AppColors.get()?.ICON_COLOR != null ? AppColors.get()?.ICON_COLOR! : Colors.grey;
  static Color? buttonColor = AppColors.get()?.BUTTON_COLOR != null ? AppColors.get()?.BUTTON_COLOR : Colors.black54;
  static Color? buttonTextColor = AppColors.get()?.BUTTON_TEXT_COLOR != null ? AppColors.get()?.BUTTON_TEXT_COLOR : Colors.white;
  static Color? primaryColor = AppColors.get()?.PRIMARY_COLOR != null ? AppColors.get()?.PRIMARY_COLOR : Colors.blue;
  static Color? accentColor = AppColors.get()?.ACCENT_COLOR != null ? AppColors.get()?.ACCENT_COLOR : Colors.blueGrey;

  /// get customised Theme data
  static ThemeData themeData() {
    return ThemeData(
      //brightness: Brightness.dark,
      primaryColor: primaryColor,
      accentColor: accentColor,
      fontFamily: 'Ubuntu',
      */ /*textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ).apply(),
        iconTheme: IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: Colors.white*/ /*
    );
  }

  static Scaffold scaffold({AppBar? appBar, required Widget body}) {
    return Scaffold(appBar: appBar, body: body);
  }

  static AppBar appBar() {
    return AppBar();
  }

  /// scroll list view
  static scrollListView(
      {required List<Widget> children,
      Axis scrollDirection = Axis.vertical,
      AlignmentGeometry alignment = Alignment.center,
      double? width,
      double? height,
      bool shrinkWrap = true,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin}) {
    return Container(
        padding: padding,
        margin: margin,
        alignment: alignment,
        width: width,
        height: height,
        child: ListView(
          children: children,
          scrollDirection: scrollDirection,
          shrinkWrap: shrinkWrap,
        ));
  }

  /// text field: title - show above text field, labelText - show label in text filed left side in top border line,
  static Widget textFieldLabel(
      {TextEditingController? textEditingController,
        String value = "",
      String title = "",
      String hintText = "",
      String? labelText,
      bool isEditable = true,
      INPUT_TYPE inputType = INPUT_TYPE.ALPHA_NUMERIC_SPECIAL_CHAR,
      int? length,
      int? maxLines = 1,
      bool isCounterTextEnabled = false,
      Color fillColor = Colors.white,
      bool isColorFilled = false,
      Function(String)? onTextChanged,
      double titleSize = 16,
      double textSize = 16,
      TextStyle? titleTextStyle,
      TextStyle? textStyle,
      TextStyle? hintTextStyle,
      TextStyle? labelTextStyle,
      Color? titleColor = Colors.black45,
      Color? textColor = Colors.black,
      Color? hintTextColor = Colors.grey,
      Color? labelTextColor = Colors.grey,
      double borderRadius = 0,
      Color? borderColor = Colors.grey,
      Color? focusedBorderColor = Colors.grey,
      Color? enabledBorderColor = Colors.grey,
      Color? disabledBorderColor = Colors.grey,
      Color? errorBorderColor = Colors.grey,
      Color? focusedErrorBorderColor = Colors.grey,
      Widget? prefixIcon,
      Widget? suffixIcon,
      bool obscureText = false,
      String obscuringCharacter = ".",
      EdgeInsetsGeometry textFieldContentPadding = const EdgeInsets.all(5),
      BuildContext? context,
      FocusNode? focusNode,
      FocusNode? requestFocusNode,
      TextInputAction? textInputAction = TextInputAction.done}) {
    TextEditingController tec = textEditingController ?? TextEditingController();
    tec.text = value;
    FocusNode fn = focusNode ?? FocusNode();
    FocusNode rfn = requestFocusNode ?? FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !ValidationUtils.isEmpty(title)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleTextStyle == null ? TextStyle(color: titleColor, fontSize: titleSize, fontWeight: FontWeight.bold) : titleTextStyle),
                  SizedBox(height: 5),
                ],
              )
            : Container(),
        TextField(
          textInputAction: textInputAction,
          focusNode: fn,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
            return isCounterTextEnabled
                ? Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    alignment: Alignment.centerRight,
                    child: Text(currentLength.toString() + "/" + maxLength.toString()))
                : Container();
          },
          maxLength: length,
          maxLines: maxLines,
          onChanged: (text) {
            if (onTextChanged != null) {
              onTextChanged(text);
            }
          },
          onEditingComplete: () {
            tec.text = tec.text;
            Get.printInfo(info: "onEditingComplete ${tec.text}");
            if (context != null) {
              FocusScope.of(context).requestFocus(rfn);
            }
          },
          onSubmitted: (String value) {
            tec.text = value;
            Get.printInfo(info: "onSubmitted ${tec.text}");
            if (context != null) {
              FocusScope.of(context).requestFocus(rfn);
            }
          },
          controller: tec,
          keyboardType: InputTypeUtils.getTextInputType(inputType),
          inputFormatters: InputTypeUtils.getTextInputFormatter(inputType),
          enabled: isEditable,
          style: textStyle == null ? TextStyle(color: textColor, fontSize: textSize) : textStyle,
          decoration: InputDecoration(
            contentPadding: textFieldContentPadding,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: enabledBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: disabledBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedErrorBorderColor ?? Colors.grey,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            hintText: hintText,
            labelText: labelText,
            hintStyle: hintTextStyle == null ? TextStyle(color: hintTextColor) : hintTextStyle,
            labelStyle: labelTextStyle == null ? TextStyle(color: labelTextColor) : labelTextStyle,
            fillColor: fillColor,
            filled: isColorFilled,
            prefixIcon: prefixIcon == null ? SizedBox() : prefixIcon,
            suffixIcon: suffixIcon == null ? SizedBox() : suffixIcon,
            prefixIconConstraints: BoxConstraints(
              minHeight: prefixIcon == null ? 5 : 32,
              minWidth: prefixIcon == null ? 5 : 32,
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: suffixIcon == null ? 5 : 32,
              minWidth: suffixIcon == null ? 5 : 32,
            ),
          ),
        )
      ],
    );
  }

  /// common button
  static Widget button(
      {required BuildContext context,
      required String title,
      double? height = 50,
      double? width,
      bool isMatchParent = false,
      Color? fillColor = Colors.white,
      Color? borderColor,
      Color? textColor = Colors.grey,
      double? fontSize,
      double borderRadius = 0,
      EdgeInsetsGeometry padding = const EdgeInsets.all(5),
      EdgeInsetsGeometry margin = const EdgeInsets.all(0),
      required Function() onTap,
      TextAlign textAlign = TextAlign.start}) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: padding,
          child: Text(
            title,
            textAlign: textAlign,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fillColor,
            border: borderColor != null ? Border.all(color: borderColor) : null,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }

  /// add icon with text or add widget with icon
  static RichText richText({List<InlineSpan>? children}) {
    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }

  static void showNetworkImageInBottomSheet(String? imageUrl) {
    Get.bottomSheet(
        Container(
            height: double.infinity,
            color: Colors.blueGrey,
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl ?? ""),
            )),
        isScrollControlled: true);
  }

  static void showFileImageInBottomSheet(File file) {
    Get.bottomSheet(
        Container(
            height: double.infinity,
            color: Colors.blueGrey,
            child: PhotoView(
              imageProvider: FileImage(file),
            )),
        isScrollControlled: true);
  }*/

  static void hideKeyboard({required BuildContext context, Function? setState}) {
    if (setState != null) {
      setState(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  static void showBlankDialogX({required String title, required Widget child, double height = 100}) {
    UIUtils.blankDialogX(
        title: title,
        height: height,
        titleColor: ColorConstant.blue_1,
        titleFontFamily: ReleaseConstant.Montserrat,
        titleFontSize: 15,
        child: child);
  }

  static void showBlankDialogOkCancel(
      {String message = "",
      Widget? child,
      Function()? okFunction,
      bool isCancelButtonNeed = false,
      String okText = "OK",
      String cancelText = "CANCEL",
      bool isCenterMessage = true,
      Function()? cancelFunction}) {
    UIUtils.blankDialogOKCancel(
        text: message,
        child: child,
        //height: height,
        okFunction: okFunction,
        isCancelButtonNeed: isCancelButtonNeed,
        buttonFontFamily: ReleaseConstant.Prosto,
        textFontFamily: ReleaseConstant.Montserrat,
        okButtonFillColor: ColorConstant.Btn_color,
        oKButtonTextColor: ColorConstant.COLOR_WHITE,
        okText: okText,
        cancelText: cancelText,
        isCenterMessage: isCenterMessage,
        cancelFunction: cancelFunction);

  }

/*  static showSomethingWentWrongDialog({Function()? okFunction}) {
    UIConfig.showBlankDialogOkCancel(message: "Something went wrong, Please try again later.", okFunction: okFunction);
  }*/

  static Widget listViewDocument(
      {required String uiKey,
      List<DocumentsDTO?> listDocumentsDTO = const [],
      Function(int index)? onClickedItem,
      Function(int index)? onClickedDelete,
      bool isDeleteServerImage = false,
      bool isDeleteLocalImage = false,
      bool isMandatory = false,
      String mandatoryChar = "*",
      Color mandatoryCharColor = Colors.red}) {
    return ListView.builder(
        key: ValueKey(uiKey),
        itemBuilder: (context, index) {
          //listDocumentsDTO[index]!.filePath -> server image address
          if (listDocumentsDTO[index]!.filePath != null && listDocumentsDTO[index]!.documentId != null) {
            CachedNetworkImage.evictFromCache(listDocumentsDTO[index]!.filePath ?? "", cacheKey: listDocumentsDTO[index]!.filePath ?? "");
            DefaultCacheManager defaultCacheManager = DefaultCacheManager();
            defaultCacheManager.removeFile(listDocumentsDTO[index]!.filePath ?? "");
            defaultCacheManager.emptyCache();
            defaultCacheManager.store.emptyCache();
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              child: InkWell(
                  key: ValueKey("button_"+uiKey),
                  onTap: () {
                    if (onClickedItem != null) {
                      onClickedItem(index);
                    }
                  },
                  child: Container(
                    color: ColorConstant.grey_light,
                    padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                    child: Row(
                      children: [
                       /* Expanded(
                            child: Text("${index + 1}. ${listDocumentsDTO[index]!.documentType!}",
                                maxLines: 2,
                                key: ValueKey("list_document_text"),
                                style: TextStyle(
                                    fontFamily: ReleaseConstant.Montserrat,
                                    color: ColorConstant.blue_2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12))), */
                        Expanded(
                            child: RichText(
                                maxLines: 2,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "${index + 1}. ${listDocumentsDTO[index]!.documentType!}",
                                      style: TextStyle(
                                          fontFamily: ReleaseConstant.Montserrat,
                                          color: ColorConstant.blue_2,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12)),
                                  listDocumentsDTO[index]!.mandatory ?? false
                                      ? TextSpan(
                                      text: " $mandatoryChar",
                                      style: TextStyle(
                                          fontFamily: ReleaseConstant.Montserrat,
                                          color: mandatoryCharColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))
                                      : TextSpan(),
                                ]))),
                        SizedBox(width: 5),
                        Center(
                          child: Icon(Icons.visibility_sharp, color: Colors.black, size: 22),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.center,
                          child: isDeleteServerImage
                              ? IconButton(
                              key: ValueKey("button_delete_server_image_"+uiKey),
                              splashRadius: 20,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              //icon: Icon(FontAwesomeIcons.solidMinusSquare, color: ColorConstant.CARD_RED, size: 20),
                              icon: Icon(Icons.delete_sharp, color: ColorConstant.CARD_RED, size: 20),
                              onPressed: () {
                                if (onClickedDelete != null) {
                                  onClickedDelete(index);
                                }
                              })
                              : Container(),
                        )
                      ],
                    ),
                  )),
            );

          } else {
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              child: InkWell(
                  key: ValueKey("button_clicked_item_"+uiKey),
                  onTap: () {
                    if (onClickedItem != null) {
                      onClickedItem(index);
                    }
                  },
                  child: Container(
                    color: ColorConstant.grey_light,
                    padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        /*Expanded(
                            child: Text("${index + 1}. ${listDocumentsDTO[index]!.documentType!}",
                                maxLines: 2,
                                key: ValueKey("list_document_text"),
                                style: TextStyle(
                                    fontFamily: ReleaseConstant.Montserrat,
                                    color: ColorConstant.blue_2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12))),*/
                        Expanded(
                            child: RichText(
                                maxLines: 2,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "${index + 1}. ${listDocumentsDTO[index]!.documentType!}",
                                      style: TextStyle(
                                          fontFamily: ReleaseConstant.Montserrat,
                                          color: ColorConstant.blue_2,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12)),
                                  listDocumentsDTO[index]!.mandatory ?? false
                                      ? TextSpan(
                                      text: " $mandatoryChar",
                                      style: TextStyle(
                                          fontFamily: ReleaseConstant.Montserrat,
                                          color: mandatoryCharColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))
                                      : TextSpan(),
                                ]))),
                        SizedBox(width: 5),
                        Center(
                          child: Icon(Icons.visibility_sharp, color: Colors.black, size: 22),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          alignment: Alignment.center,
                          child: isDeleteLocalImage && !listDocumentsDTO[index]!.isServerImage
                              ? IconButton(
                                  key: ValueKey("button_delete_local_image_"+uiKey),
                                  padding: EdgeInsets.zero,
                                  splashRadius: 20,
                                  constraints: BoxConstraints(),
                                  //icon: Icon(FontAwesomeIcons.solidMinusSquare, color: ColorConstant.CARD_RED, size: 20),
                                  icon: Icon(Icons.delete_sharp, color: ColorConstant.CARD_RED, size: 20),
                                  onPressed: () {
                                    if (onClickedDelete != null) {
                                      onClickedDelete(index);
                                    }
                                  })
                              : Container(),
                        )
                      ],
                    ),
                  )),
            );

          }
        },
        itemCount: listDocumentsDTO.length,
        shrinkWrap: true,
        //padding: EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics());
  }

  static Widget dropDownView<Item>(
      {required String uiKey,
      List<DMapper<Item?>?> listItems = const [],
      //String title = "",
      String? hintText,
      String labelText = "",
      Color? hintTextColor = ColorConstant.COLOR_LIGHT_GREY,
      //Color? titleColor = ColorConstant.LITE_BLACK,
      Color? textColor = Colors.black,
      Color? labelTextColor = ColorConstant.LITE_BLACK,
      double borderRadius = 0,
      double hintFontSize = 14.0,
      Function(DMapper<Item?>?)? onChanged,
      Function(DMapper<Item?>?)? onSaved,
      int selectionBasedOnIntOrString = 1, // 1 for int, 2 for string
      String? selectedIdString,
      int? selectedIdInt,
      bool isEditable = true,
      FocusNode? focusNode,
      FocusNode? requestFocusNode,
      bool isMandatory = false,
      String mandatoryChar = "*",
      Color mandatoryCharColor = Colors.red,
      TextEditingController? searchTextEditingController,
      EdgeInsetsGeometry textFieldContentPadding = const EdgeInsets.all(5),
      Color borderColor = Colors.grey,
      Color focusedBorderColor = Colors.grey,
      Color enabledBorderColor = Colors.grey,
      Color disabledBorderColor = Colors.grey,
      Color errorBorderColor = Colors.grey,
      Color focusedErrorBorderColor = Colors.grey,
      TextStyle? textStyle,
      TextStyle? hintTextStyle,
      TextStyle? labelTextStyle,
      bool isColorFilled = true,
      Color fillColor = Colors.transparent,
      String? fontFamily,
      double textSize = 14,
      FloatingLabelBehavior? floatingLabelBehavior}) {
    if (focusNode == null) {
      focusNode = FocusNode();
    }

    fontFamily = fontFamily ?? ReleaseConstant.Montserrat;
    labelTextStyle = labelTextStyle ?? TextStyle(color: labelTextColor, fontSize: textSize, fontFamily: fontFamily, fontWeight: FontWeight.w500);
    textStyle = textStyle ?? TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily);
    hintTextStyle = hintTextStyle ?? TextStyle(color: hintTextColor, fontSize: textSize, fontFamily: fontFamily);

    InputDecoration inputDecoration = InputDecoration(
      contentPadding: textFieldContentPadding,
      floatingLabelBehavior: floatingLabelBehavior,
      label: !ValidationUtils.isEmpty(labelText)
          ? RichText(
          text: TextSpan(children: [
            TextSpan(text: labelText, style: labelTextStyle),
            isMandatory ? TextSpan(text: " $mandatoryChar", style: TextStyle(color: mandatoryCharColor, fontSize: textSize, fontWeight: FontWeight.bold, fontFamily: fontFamily)) : TextSpan(),
          ]))
          : null,
      //prefixStyle: prefixTextStyle ?? TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily),
      //prefixText: prefixText,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: enabledBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: disabledBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedErrorBorderColor,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      hintText: hintText,
      //labelText: labelText,
      hintStyle: hintTextStyle,
      //labelStyle: labelTextStyle,
      fillColor: fillColor,
      filled: isColorFilled,
    );

    List<DropdownMenuItem<DMapper<Item?>?>> items = [];
    for (int i = 0; i < listItems.length; i++) {
      DMapper<Item?>? dMapper = listItems[i];
      if (dMapper != null) {
        items.add(
          DropdownMenuItem(
            value: dMapper,
            //child: Text(dMapper.text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontSize: 14, fontFamily: ReleaseConstant.Montserrat), key: ValueKey(uiKey)),
            child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(text: dMapper.text, style: TextStyle(color: textColor, fontSize: 14, fontFamily: ReleaseConstant.Montserrat)),
                  dMapper.isMandatory ? TextSpan(text: " $mandatoryChar", style: TextStyle(color: mandatoryCharColor, fontSize: 14, fontFamily: ReleaseConstant.Montserrat)) : TextSpan(),
                ])),
          ),
        );
      }
    }

    DMapper<Item?>? selectedValue;

    if (selectionBasedOnIntOrString == 1) {
      for (var dMapper in listItems) {
        if (dMapper != null && selectedIdInt != null && selectedIdInt == dMapper.id) {
          selectedValue = dMapper;
        }
      }
    } else if (selectionBasedOnIntOrString == 2) {
      for (var dMapper in listItems) {
        if (dMapper != null && selectedIdString != null && selectedIdString == dMapper.idString) {
          selectedValue = dMapper;
        }
      }
    }

    RxBool _deleteTextIconVisible = false.obs;

    if(searchTextEditingController != null && !ValidationUtils.isEmpty(searchTextEditingController.text)) {
      _deleteTextIconVisible.value = true;
    }

    return AbsorbPointer(
      absorbing: !isEditable,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField2<DMapper<Item?>?>(
            focusNode: focusNode,
            decoration: inputDecoration,
            isExpanded: true,
            hint: !ValidationUtils.isEmpty(hintText) ? Text(hintText!, style: hintTextStyle) : null,
            iconStyleData: IconStyleData(icon: const Icon(Icons.arrow_drop_down, color: Colors.black45), iconSize: 30),
            //buttonHeight: 60,
            buttonStyleData: ButtonStyleData(padding: EdgeInsets.only(left: 0, right: 5)),
            value: selectedValue,
            dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: borderColor,
                      width: 1,
                    ))),
            items: items,
            dropdownSearchData: searchTextEditingController != null
                ? DropdownSearchData<DMapper<Item?>?>(
                    searchController: searchTextEditingController,
                    searchInnerWidgetHeight: 40,
                    searchMatchFn: (item, searchValue) {
                      return item.value?.text.toLowerCase().contains(searchValue.toLowerCase()) ?? false;
                    },
                    searchInnerWidget: Obx(() => Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLines: 1,
                                  controller: searchTextEditingController,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: "Search",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  style: TextStyle(color: textColor, fontFamily: ReleaseConstant.Montserrat, fontSize: 14),
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      _deleteTextIconVisible.value = false;
                                      _deleteTextIconVisible.refresh();
                                    } else {
                                      _deleteTextIconVisible.value = true;
                                      _deleteTextIconVisible.refresh();
                                    }
                                  },
                                ),
                              ),
                              _deleteTextIconVisible.value
                                  ? IconButton(
                                      icon: Icon(FontAwesomeIcons.backspace, size: 18),
                                      onPressed: () {
                                        searchTextEditingController.text = "";
                                        _deleteTextIconVisible.value = false;
                                        _deleteTextIconVisible.refresh();
                                        //_onSearch();
                                      })
                                  : Container(),
                            ],
                          ),
                        )))
                : null,
            /*validator: (value) {
                if (value == null) {
                  return 'Please select gender.';
                }
              },*/
            onChanged: (value) {
              if (onChanged != null) {
                onChanged(value);
              }
              if (focusNode != null) {
                focusNode.unfocus();
              }
              if (requestFocusNode != null) {
                requestFocusNode.requestFocus();
              }
            },
            onSaved: (value) {
              if (onSaved != null) {
                onSaved(value);
              }
            },
          ),
        ],
      ),
    );
  }

  TextStyle getDefaultTextStyle({FontWeight? fontWeight}) {
    return TextStyle(color: ColorConstant.COLOR_LIGHT_GREY, fontSize: 14, fontFamily: ReleaseConstant.Montserrat, fontWeight: fontWeight);
  }

  static Widget documentView(
      {required String uiKey,
      required BuildContext context,
      DocumentsDTO? documentsDTO,
      bool isServerImage = false,
      String text = "",
      bool isEditable = true,
      required Function(File) onSelectedFile,
      required Function(bool) onFileDeleted,
      Color fillColor = Colors.transparent,
      Color borderColor = Colors.grey,
      Color textColor = ColorConstant.LITE_BLACK,
      double borderRadius = 0,
      double textSize = 14,
      Function()? onViewServerImage,
      bool isMandatory = false,
      String mandatoryChar = "*",
      Color mandatoryCharColor = Colors.red,
      double? maxWidth = 800,
      double? maxHeight = 800,
      int imageQuality = 80,
      FocusNode? focusNode,
      FocusNode? requestFocusNode}) {

    if(focusNode == null) {
      focusNode = FocusNode();
    }

    File? _file;
    String? imageUrl;
    bool showBottomView = false;

    if(documentsDTO != null) {
      _file = documentsDTO.fileCompressed;
      imageUrl = documentsDTO.s3FilePath;
      showBottomView = !ValidationUtils.isEmpty(imageUrl) || !ValidationUtils.isEmpty(documentsDTO.s3FilePath) || _file != null;
    }

    return StatefulBuilder(
        key: ValueKey(uiKey),
        builder: (context, setState) {
          return AbsorbPointer(
              absorbing: !isEditable,
              child: Focus(
                focusNode: focusNode,
                canRequestFocus: true,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    height: 46,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: fillColor,
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Row(
                      children: [
                        //Expanded(child: Text(text, style: TextStyle(fontSize: textSize, fontFamily: ReleaseConstant.Montserrat, color: textColor), key: ValueKey("textDocument_"+uiKey),)),
                        Expanded(
                          child: RichText(
                              key: ValueKey("textDocument_" + uiKey),
                              text: TextSpan(children: [
                                TextSpan(text: text, style: TextStyle(fontSize: textSize, fontFamily: ReleaseConstant.Montserrat, color: textColor)),
                                isMandatory
                                    ? TextSpan(text: " $mandatoryChar", style: TextStyle(fontSize: textSize, fontFamily: ReleaseConstant.Montserrat, color: Colors.red))
                                    : TextSpan(),
                              ])),
                        ),
                        showBottomView
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.file_upload_sharp, color: Colors.black, size: 22),
                                key: ValueKey("buttonDocumentItemClick_" + uiKey),
                                onPressed: () {
                                  UIUtils.hideKeyboard();
                                  FilePickerUtils.pickFiles(
                                      context: context,
                                      type: TYPE.CAMERA_IMAGE,
                                      maxWidth: maxWidth,
                                      maxHeight: maxHeight,
                                      imageQualityForImageVideoPicker: imageQuality,
                                      imageCrop: true,
                                      onSelectedFiles: (List<File> files) {
                                        if (files.isNotEmpty) {
                                          final File selectedFile = files[0];
                                          _file = selectedFile;
                                          onSelectedFile(selectedFile);

                                          if (focusNode != null) {
                                            focusNode.unfocus();
                                          }
                                          if (requestFocusNode != null) {
                                            requestFocusNode.requestFocus();
                                          }

                                          setState(() {
                                            showBottomView = true;
                                          });
                                        }
                                      });
                                })
                      ],
                    ),
                  ),
                  showBottomView
                      ? Container(
                          margin: EdgeInsets.only(top: 6),
                          width: double.infinity,
                          child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                            InkWell(
                              key: ValueKey("buttonDocumentView_" + uiKey),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.visibility_sharp, color: Colors.black, size: 22),
                                  SizedBox(width: 3),
                                  Text('View', style: TextStyle(fontSize: 14, fontFamily: ReleaseConstant.Montserrat, color: Colors.black)),
                                ],
                              ),
                              onTap: () {
                                UIUtils.hideKeyboard();
                                if (_file != null) {
                                  UIUtils.showFileImageInBottomSheet(_file!);
                                } else if (_file == null && isServerImage && onViewServerImage != null) {
                                  onViewServerImage();
                                }
                              },
                            ),
                            InkWell(
                              key: ValueKey("buttonDocumentDelete_" + uiKey),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.delete_sharp, color: !isServerImage ? Colors.black : Colors.grey, size: 22),
                                  SizedBox(width: 3),
                                  Text('Delete', style: TextStyle(fontSize: 14, fontFamily: ReleaseConstant.Montserrat, color: !isServerImage ? Colors.black : Colors.grey)),
                                ],
                              ),
                              onTap: () {
                                UIUtils.hideKeyboard();
                                if (!isServerImage) {
                                  _file = null;
                                  onFileDeleted(true);
                                  setState(() {
                                    showBottomView = false;
                                  });
                                }
                              },
                            ),
                            InkWell(
                              key: ValueKey("buttonDocumentChange_" + uiKey),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.file_upload_sharp, color: Colors.black, size: 22),
                                  SizedBox(width: 3),
                                  Text('Change', style: TextStyle(fontSize: 14, fontFamily: ReleaseConstant.Montserrat, color: Colors.black)),
                                ],
                              ),
                              onTap: () {
                                UIUtils.hideKeyboard();
                                FilePickerUtils.pickFiles(
                                    context: context,
                                    type: TYPE.CAMERA_IMAGE,
                                    imageCrop: true,
                                    onSelectedFiles: (List<File> files) {
                                      if (files.isNotEmpty) {
                                        final File selectedFile = files[0];
                                        _file = selectedFile;
                                        onSelectedFile(selectedFile);

                                        if (focusNode != null) {
                                          focusNode.unfocus();
                                        }
                                        if (requestFocusNode != null) {
                                          requestFocusNode.requestFocus();
                                        }

                                        setState(() {
                                          showBottomView = true;
                                        });
                                      }
                                    });
                              },
                            )
                          ]),
                        )
                      : Container()
                ]),
              ));
        });
  }
}
