import 'dart:async';

import 'package:flearn/f_praticals/source/constants/color_constants.dart';
import 'package:flearn/f_praticals/source/constants/release_constant.dart';
import 'package:flearn/f_praticals/source/core/utils/ui_utils.dart';
import 'package:flearn/f_praticals/source/core/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* Notes:
* 1. set item text value in toString() method in model class
* 2. create hashCode for model -> hashCode is used for selecting multiple items, it used to identify which item has been selected
* example:
class Animals {
  String name = "";
  String color = "";

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Animals &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          color == other.color;

  @override
  int get hashCode => name.hashCode ^ color.hashCode;
}
*/


class MultiSelectDropDownController<Item> extends GetxController {
  RxList<Item> items = <Item>[].obs;
  RxList<Item> selectedItems = <Item>[].obs;

  RxList<Item> filteredItems = <Item>[].obs;
  RxBool deleteTextIconVisible = false.obs;
  Timer? debounce;
  RxList<Item> selectedItemsTemp = <Item>[].obs;
  RxBool isSelectAll = false.obs;
  RxBool isSelectAllCheckBoxNeeded = false.obs;

  final TextEditingController tecSearch = TextEditingController();

  void setItems(List<Item> items_) {
    items.value = [];
    items.addAll(items_);
    filteredItems.value = [];
    filteredItems.addAll(items);

    items.refresh();
    filteredItems.refresh();
  }

  void updateSelectedItems(List<Item> items_) {
    selectedItems.value = [];
    selectedItems.addAll(items_);
    selectedItemsTemp.value = [];
    selectedItemsTemp.addAll(selectedItems);

    if (selectedItemsTemp.isEmpty) {
      isSelectAll.value = false;
    }

    selectedItems.refresh();
    selectedItemsTemp.refresh();
    isSelectAll.refresh();
  }
}

class MultiSelectDropDown<Item> extends StatefulWidget {
  final String title;
  final String hintText;
  final List<Item> items;
  final List<Item> selectedItems;
  final Function(List<Item> selectedItems)? onSelectedItems;
  final bool isEditable;
  final Color titleTextColor;
  final Color hintTextColor;
  final double borderRadius;
  final Color borderColor;
  final bool isSearchEnabled;
  final double bottomSheetMargin;
  final double bottomSheetPadding;
  final Function(bool)? isAnyItemDeletedOrUnchecked; //if any one item removed or deleted -> it used -> ex: if all india selected in main page, it notify changes in main UI
  final bool isSelectAllCheckBoxNeeded;
  final MultiSelectDropDownController<Item> controller;
  final Color? backgroundColor;
  final String uiKey;

  MultiSelectDropDown(
      {Key? key,
      this.title = "",
      this.hintText = "Select",
      this.items = const [],
      this.selectedItems = const [],
      this.onSelectedItems,
      this.isEditable = true,
      this.titleTextColor = ColorConstant.COLOR_LIGHT_GREY,
      this.hintTextColor = ColorConstant.COLOR_LIGHT_GREY,
      this.borderRadius = 5,
      this.borderColor = Colors.grey,
      this.isSearchEnabled = true,
      this.bottomSheetMargin = 0,
      this.bottomSheetPadding = 10,
      this.isAnyItemDeletedOrUnchecked,
      this.isSelectAllCheckBoxNeeded = true,
      this.backgroundColor = Colors.transparent,
      required this.controller,
      required this.uiKey})
      : super(key: key);

  @override
  State<MultiSelectDropDown> createState() => MultiSelectDropDownState<Item>(
      title: title,
      hintText: hintText,
      items: items,
      selectedItems: selectedItems,
      onSelectedItems: onSelectedItems,
      isEditable: isEditable,
      titleTextColor: titleTextColor,
      hintTextColor: hintTextColor,
      borderRadius: borderRadius,
      borderColor: borderColor,
      isSearchEnabled: isSearchEnabled,
      bottomSheetMargin: bottomSheetMargin,
      bottomSheetPadding: bottomSheetPadding,
      isAnyItemDeletedOrUnchecked: isAnyItemDeletedOrUnchecked,
      isSelectAllCheckBoxNeeded: isSelectAllCheckBoxNeeded,
      controller: controller,
      backgroundColor: backgroundColor,
      uiKey: uiKey);
}

class MultiSelectDropDownState<Item> extends State<MultiSelectDropDown> {
  final String title;
  final String hintText;
  final List<Item> items;
  final List<Item> selectedItems;
  final Function(List<Item> selectedItems)? onSelectedItems;
  final bool isEditable;
  final Color titleTextColor;
  final Color hintTextColor;
  final double borderRadius;
  final Color borderColor;
  final bool isSearchEnabled;
  final double bottomSheetMargin;
  final double bottomSheetPadding;
  final Function(bool)? isAnyItemDeletedOrUnchecked;
  final bool isSelectAllCheckBoxNeeded;
  final MultiSelectDropDownController<Item> controller;
  final Color? backgroundColor;
  final String uiKey;

  //final MultiSelectDropDownController<Item> controller = Get.put<MultiSelectDropDownController<Item>>(MultiSelectDropDownController<Item>(), tag: DateTime.now().toString());

  MultiSelectDropDownState(
      {required this.title,
      required this.hintText,
      required this.items,
      required this.selectedItems,
      required this.onSelectedItems,
      required this.isEditable,
      required this.titleTextColor,
      required this.hintTextColor,
      required this.borderRadius,
      required this.borderColor,
      required this.isSearchEnabled,
      required this.bottomSheetMargin,
      required this.bottomSheetPadding,
      required this.isAnyItemDeletedOrUnchecked,
      required this.isSelectAllCheckBoxNeeded,
      required this.controller,
      required this.backgroundColor,
      required this.uiKey}) {
    controller.items.value = [];
    controller.items.addAll(items);

    controller.filteredItems.value = [];
    controller.filteredItems.addAll(items);

    controller.selectedItems.value = [];
    controller.selectedItems.addAll(selectedItems);

    controller.isSelectAllCheckBoxNeeded.value = isSelectAllCheckBoxNeeded;
  }

  void setItems(List<Item> items_) {
    controller.selectedItems(items_);
  }

  void updateSelectedItems(List<Item> items_) {
    controller.updateSelectedItems(items_);
  }

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Widget content() {
    return AbsorbPointer(
      absorbing: !isEditable,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValidationUtils.isEmpty(title)
              ? Container()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title,style: TextStyle(color: titleTextColor, fontSize: 14, fontFamily: ReleaseConstant.Montserrat, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                ]),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: backgroundColor, shape: BoxShape.rectangle, border: Border.all(color: borderColor, width: 1)),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    //getBottomSheet();
                    Get.to(() => _MultiDropDownList(child: getListView()), transition: Transition.downToUp);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 3),
                    child: TextField(
                      enabled: false,
                      style: TextStyle(
                          color: titleTextColor,
                          fontSize: 14,
                          fontFamily: ReleaseConstant.Montserrat),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(color: hintTextColor, fontSize: 14, fontFamily: ReleaseConstant.Montserrat),
                        labelStyle: TextStyle(color: hintTextColor, fontSize: 14, fontFamily: ReleaseConstant.Montserrat),
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return controller.selectedItems.isNotEmpty
                      ? _buildChipList()
                      : Container();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //selected items shown in chips
  Widget _buildChipList() {
    return controller.selectedItems.isNotEmpty
        ? Column(
            children: [
              Container(height: 1, color: borderColor),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                      spacing: 5,
                      children: controller.selectedItems.map<Widget>((item) {
                        return Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                              shape: BoxShape.rectangle,
                              border: Border.all(color: borderColor, width: 1)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(item.toString(), style: TextStyle(color: Colors.black, fontSize: 11,  fontFamily: ReleaseConstant.Montserrat, fontWeight: FontWeight.w600)),
                              isEditable
                                  ? IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      icon: Icon(Icons.close_sharp, color: Colors.grey, size: 18),
                                      onPressed: () {
                                        if (controller.selectedItems.contains(item)) {
                                          controller.selectedItems.remove(item);
                                          if (isAnyItemDeletedOrUnchecked != null) {
                                            isAnyItemDeletedOrUnchecked!(true);
                                          }
                                          if (onSelectedItems != null) {
                                            onSelectedItems!(controller.selectedItems);
                                          }

                                          if (controller.items.length == controller.selectedItems.length) {
                                            controller.isSelectAll.value = true;
                                          } else {
                                            controller.isSelectAll.value = false;
                                          }
                                        }
                                        controller.selectedItems.refresh(); //for updating selected item ships UI
                                        controller.isSelectAll.refresh(); //for updating selected item ships UI
                                      })
                                  : Container()
                            ],
                          ),
                        );
                      }).toList())),
            ],
          )
        : Container();
  }

  getBottomSheet() {
    controller.selectedItemsTemp.value = [];
    controller.selectedItemsTemp.addAll(controller.selectedItems);
    if(controller.items.length == controller.selectedItemsTemp.length) {
      controller.isSelectAll.value = true;
    } else {
      controller.isSelectAll.value = false;
    }
    controller.selectedItemsTemp.refresh();
    controller.isSelectAll.refresh();
    controller.tecSearch.text = "";
    controller.filteredItems.value = [];
    controller.filteredItems.addAll(controller.items);
    controller.deleteTextIconVisible.value = false;

    controller.filteredItems.refresh();
    controller.deleteTextIconVisible.refresh();

    controller.isSelectAllCheckBoxNeeded.value = isSelectAllCheckBoxNeeded;
    controller.isSelectAllCheckBoxNeeded.refresh();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // half screen on load
          maxChildSize: 0.8, // full screen on scroll
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                    border: Border.all(color: borderColor, width: 1)),
                margin: EdgeInsets.only(left: bottomSheetMargin, right: bottomSheetMargin, top: bottomSheetMargin),
                padding: EdgeInsets.all(bottomSheetPadding),
                child: listView(scrollController: scrollController));
          },
        );
      },
      //elevation: 20,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      isScrollControlled: true,
      //set to full height
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))), //not used, because container used
      //barrierColor: Colors.black,
    );
  }

  Widget getListView() {
    controller.selectedItemsTemp.value = [];
    controller.selectedItemsTemp.addAll(controller.selectedItems);
    if(controller.items.length == controller.selectedItemsTemp.length) {
      controller.isSelectAll.value = true;
    } else {
      controller.isSelectAll.value = false;
    }
    controller.selectedItemsTemp.refresh();
    controller.isSelectAll.refresh();
    controller.tecSearch.text = "";
    controller.filteredItems.value = [];
    controller.filteredItems.addAll(controller.items);
    controller.deleteTextIconVisible.value = false;

    controller.filteredItems.refresh();
    controller.deleteTextIconVisible.refresh();

    controller.isSelectAllCheckBoxNeeded.value = isSelectAllCheckBoxNeeded;
    controller.isSelectAllCheckBoxNeeded.refresh();

    return Container(margin: EdgeInsets.all(20), child: listView());
  }

  Widget listView({ScrollController? scrollController}) {
    return Obx(() {
      return Column(
        children: [
          SizedBox(height: 10),
          Text(!ValidationUtils.isEmpty(title) ? title : !ValidationUtils.isEmpty(hintText) ? hintText : "Select", textAlign: TextAlign.start, style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: ReleaseConstant.Prosto, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          isSearchEnabled
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: Colors.grey)),
                  child: Row(
                    children: [
                      Icon(Icons.search_sharp, color: Colors.grey),
                      Expanded(
                          child: Container(
                        child: TextField(
                          maxLines: 1,
                          controller: controller.tecSearch,
                          decoration: InputDecoration(contentPadding: EdgeInsets.all(5), hintText: "Search", border: InputBorder.none),
                          onChanged: (value) {

                            if (value.isEmpty) {
                              controller.deleteTextIconVisible.value = false;
                            } else {
                              controller.deleteTextIconVisible.value = true;
                            }

                            if (!ValidationUtils.isEmpty(controller.tecSearch.text)) {
                              controller.filteredItems.value = [];
                              for (Item item in controller.items) {
                                if (item.toString().toLowerCase().contains(controller.tecSearch.text.toLowerCase())) {
                                  //print('filter -> text ${item.toString()}');
                                  controller.filteredItems.add(item);
                                }
                              }
                            }

                            controller.filteredItems.refresh();
                            controller.deleteTextIconVisible.refresh();
                            controller.isSelectAllCheckBoxNeeded.value = false;
                            controller.isSelectAllCheckBoxNeeded.refresh();
                          },
                        ),
                      )),
                      controller.deleteTextIconVisible.value
                          ? IconButton(icon: Icon(Icons.backspace, color: Colors.grey, size: 18),
                              onPressed: () {
                                controller.tecSearch.text = "";
                                controller.filteredItems.value = [];
                                controller.filteredItems.addAll(controller.items);
                                controller.deleteTextIconVisible.value = false;

                                controller.filteredItems.refresh();
                                controller.deleteTextIconVisible.refresh();

                                controller.isSelectAllCheckBoxNeeded.value = isSelectAllCheckBoxNeeded;
                                controller.isSelectAllCheckBoxNeeded.refresh();
                              })
                          : Container(),
                    ],
                  ),
                )
              : Container(),
          controller.isSelectAllCheckBoxNeeded.value
              ? CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text("Select All", style: TextStyle(fontSize: 14, fontFamily: ReleaseConstant.Montserrat, color: Colors.black))),
                  //controlAffinity: ListTileControlAffinity.leading,
                  checkColor: Colors.white,
                  activeColor: ColorConstant.Btn_color,
                  value: controller.isSelectAll.value,
                  onChanged: (value) {
                    if (value != null) {
                      if (isAnyItemDeletedOrUnchecked != null) {
                        isAnyItemDeletedOrUnchecked!(true);
                      }
                      if (value) {
                        controller.selectedItemsTemp.value = [];
                        controller.selectedItemsTemp.addAll(controller.items);
                        controller.isSelectAll.value = value;
                      } else {
                        controller.selectedItemsTemp.value = [];
                        controller.isSelectAll.value = false;
                      }
                      //controller.update(); //for updating bottomsheet UI -> checkbox in list
                      controller.selectedItemsTemp.refresh();
                      controller.isSelectAll.refresh();
                    }
                  },
                )
              : Container(),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return Container(
                    color: index % 2 == 0 ? Colors.white : ColorConstant.grey_light,
                    child: CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Text(controller.filteredItems[index].toString(), style: TextStyle( fontSize: 14, fontFamily: ReleaseConstant.Montserrat, color: Colors.black))),
                      //controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.white,
                      activeColor: ColorConstant.Btn_color,
                      value: controller.selectedItemsTemp.contains(controller.filteredItems[index]),
                      onChanged: (value) {
                        if (value != null) {
                          if (isAnyItemDeletedOrUnchecked != null) {
                            isAnyItemDeletedOrUnchecked!(true);
                          }
                          if (value) {
                            if (controller.selectedItemsTemp.contains(controller.filteredItems[index])) {
                              controller.selectedItemsTemp.remove(controller.filteredItems[index]);
                            } else {
                              controller.selectedItemsTemp.add(controller.filteredItems[index]);
                            }
                          } else {
                            if (controller.selectedItemsTemp.contains(controller.filteredItems[index])) {
                              controller.selectedItemsTemp.remove(controller.filteredItems[index]);
                              //controller.isSelectAll.value = false;
                            }
                          }
                        }

                        if(controller.items.length == controller.selectedItemsTemp.length) {
                          controller.isSelectAll.value = true;
                        } else {
                          controller.isSelectAll.value = false;
                        }

                        controller.filteredItems.refresh();
                        controller.selectedItemsTemp.refresh();
                        controller.isSelectAll.refresh();

                        //print("selectedItemsTemp ${controller.selectedItemsTemp.length}");
                        //print("selectedItems ${controller.selectedItems.length}");
                        //controller.update(); //for updating bottomsheet UI -> checkbox in list
                      },
                    ),
                  );
                },
                itemCount: controller.filteredItems.length,
                shrinkWrap: true,
                //padding: EdgeInsets.only(left: 5, right: 5),
                scrollDirection: Axis.vertical),
          ),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            UIUtils.buttonWidthSize(
                uiKey: "buttonCancel_"+uiKey,
                title: "CANCEL",
                margin: EdgeInsets.only(left: 5, right: 5),
                fillColor: ColorConstant.Btn_color,
                borderColor: ColorConstant.Btn_color,
                textColor: Colors.white,
                borderRadius: 5,
                fontSize: 10,
                width: 140,
                height: 30,
                fontFamily: ReleaseConstant.Prosto,
                onTap: () {
                  Get.back();
                }),
            UIUtils.buttonWidthSize(
                uiKey: "buttonOk_"+uiKey,
                title: "OK",
                margin: EdgeInsets.only(left: 5, right: 5),
                fillColor: ColorConstant.Btn_color,
                borderColor: ColorConstant.Btn_color,
                textColor: Colors.white,
                borderRadius: 5,
                fontSize: 10,
                width: 140,
                height: 30,
                fontFamily: ReleaseConstant.Prosto,
                onTap: () {
                  controller.selectedItems.value = [];
                  controller.selectedItems.addAll(controller.selectedItemsTemp);
                  controller.selectedItemsTemp.value = [];
                  if (onSelectedItems != null) {
                    onSelectedItems!(controller.selectedItems);
                  }
                  //print("ok selectedItemsTemp ${controller.selectedItemsTemp.length}");
                  //print("ok selectedItems ${controller.selectedItems.length}");
                  //controller.update(); //for updating bottomsheet UI -> search & checkbox in list //for updating selected item ships UI
                  controller.selectedItems.refresh();
                  controller.selectedItemsTemp.refresh();
                  Get.back();
                })
          ]),
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    //_tecSearch.dispose();
    controller.debounce?.cancel();
  }
}


class _MultiDropDownList extends StatefulWidget {
  final Widget child;
  const _MultiDropDownList({Key? key, required this.child}) : super(key: key);

  @override
  State<_MultiDropDownList> createState() => _MultiDropDownListState(child: child);
}

class _MultiDropDownListState extends State<_MultiDropDownList> {
  final Widget child;

  _MultiDropDownListState({required this.child});


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: child));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}


