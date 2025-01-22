import 'package:flearn/f_praticals/source/constants/color_constants.dart';
import 'package:flearn/f_praticals/source/core/utils/d_mapper.dart';
import 'package:flearn/f_praticals/source/core/utils/validation_utils.dart';
import 'package:flutter/material.dart';


enum DropViewSelectionType { SELECTION_BASED_ON_INDEX, SELECTION_BASED_ON_ID }

enum DropViewSelectionIdType { SELECTION_BASED_ON_ID_INT, SELECTION_BASED_ON_ID_STRING }

class DropDownView<Item> extends StatefulWidget {
  final List<DMapper<Item?>?> items;
  final String hint;
  final int selectedIndex;
  final Function(DMapper<Item?>?) onItemSelected;
  final String title;
  final DropViewSelectionType dropViewSelectionType;
  final DropViewSelectionIdType dropViewSelectionIdType;
  final int selectedId;
  final String selectedIdString;
  final bool isCaseSensitive;
  final Color? borderColor;
  final TextStyle? hintTextStyle;
  final TextStyle? itemTextStyle;
  final double borderRadius;
  final bool enable;
  final String? fontFamily;
  final double textSize;
  final double titleSize;
  final Color? titleColor;
  final Color? textColor;
  final Color? hintTextColor;

  const DropDownView(
      {Key? key,
      required this.items,
      this.hint = "Choose an item ?",
      this.selectedIndex = -1,
      required this.onItemSelected,
      this.title = "",
      this.dropViewSelectionType = DropViewSelectionType.SELECTION_BASED_ON_INDEX,
      this.dropViewSelectionIdType = DropViewSelectionIdType.SELECTION_BASED_ON_ID_INT,
      this.selectedId = -1,
      this.selectedIdString = "",
      this.isCaseSensitive = false,
      this.borderColor = Colors.grey,
      this.hintTextStyle,
      this.itemTextStyle,
      this.borderRadius = 0,
      this.enable = true,
      this.fontFamily,
      this.textSize = 14,
      this.titleSize = 14,
      this.titleColor = ColorConstant.COLOR_LIGHT_GREY,
      this.textColor = Colors.black,
      this.hintTextColor = ColorConstant.COLOR_LIGHT_GREY})
      : super(key: key);

  @override
  DropDownViewState createState() => DropDownViewState<Item>(
      selectedIndex: selectedIndex,
      items: items,
      hint: hint,
      onItemSelected: onItemSelected,
      title: title,
      dropViewSelectionType: dropViewSelectionType,
      dropViewSelectionIdType: dropViewSelectionIdType,
      selectedId: selectedId,
      selectedIdString: selectedIdString,
      isCaseSensitive: isCaseSensitive,
      borderColor: borderColor,
      hintTextStyle: hintTextStyle,
      itemTextStyle: itemTextStyle,
      borderRadius: borderRadius,
      enable: enable,
      fontFamily: fontFamily,
      textSize: textSize,
      titleSize: titleSize,
      titleColor: titleColor,
      textColor: textColor,
      hintTextColor: hintTextColor);
}

class DropDownViewState<Item> extends State<DropDownView> {
  final List<DMapper<Item?>?> items;
  final String hint;
  int selectedIndex;
  final Function(DMapper<Item?>?) onItemSelected;
  final String title;
  final DropViewSelectionType dropViewSelectionType;
  final DropViewSelectionIdType dropViewSelectionIdType;
  int selectedId;
  String selectedIdString;
  final bool isCaseSensitive;
  final Color? borderColor;
  final TextStyle? hintTextStyle;
  final TextStyle? itemTextStyle;
  final double borderRadius;
  final bool enable;
  final String? fontFamily;
  final double textSize;
  final double titleSize;
  final Color? titleColor;
  final Color? textColor;
  final Color? hintTextColor;

  List<DropdownMenuItem<DMapper<Item?>?>> _dropdownMenuItems = [];

  DMapper<Item?>? _selectedDMapper;

  DropDownViewState(
      {required this.selectedIndex,
      required this.items,
      required this.hint,
      required this.onItemSelected,
      required this.title,
      required this.dropViewSelectionType,
      required this.dropViewSelectionIdType,
      required this.selectedId,
      required this.selectedIdString,
      required this.isCaseSensitive,
      required this.borderColor,
      required this.hintTextStyle,
      required this.itemTextStyle,
      required this.borderRadius,
      required this.enable,
      required this.fontFamily,
      required this.textSize,
      required this.titleSize,
      required this.titleColor,
      required this.textColor,
      required this.hintTextColor}) {
    _dropdownMenuItems = buildDropdownMenuItems(items);

    if (dropViewSelectionType == DropViewSelectionType.SELECTION_BASED_ON_INDEX) {
      selectedId = -1;
      selectedIdString = "";
      if (selectedIndex >= 0 && selectedIndex < items.length) {
        _selectedDMapper = items[selectedIndex];
      }
    } else if (dropViewSelectionType == DropViewSelectionType.SELECTION_BASED_ON_ID) {
      selectedIndex = -1;
      if (dropViewSelectionIdType == DropViewSelectionIdType.SELECTION_BASED_ON_ID_INT) {
        selectedIdString = "";
        for (var dMapper in items) {
          if (dMapper != null) {
            if (dMapper.id >= 0 && selectedId >= 0 && selectedId == dMapper.id) {
              _selectedDMapper = dMapper;
            }
          }
        }
      } else if (dropViewSelectionIdType == DropViewSelectionIdType.SELECTION_BASED_ON_ID_STRING) {
        selectedId = -1;
        for (var dMapper in items) {
          if (dMapper != null) {
            if (isCaseSensitive) {
              if (dMapper.idString.trim().length > 0 && selectedIdString.compareTo(dMapper.idString) == 0) {
                _selectedDMapper = dMapper;
              }
            } else {
              if (dMapper.idString.trim().length > 0 && selectedIdString.toLowerCase().compareTo(dMapper.idString.toLowerCase()) == 0) {
                _selectedDMapper = dMapper;
              }
            }
          }
        }
      }
    }
  }

  void setSelectedIdString(String selectedIdString) {
    selectedIndex = -1;
    if (dropViewSelectionIdType == DropViewSelectionIdType.SELECTION_BASED_ON_ID_STRING) {
      setState(() {
        selectedId = -1;
        for (var dMapper in items) {
          if (dMapper != null) {
            if (isCaseSensitive) {
              if (dMapper.idString.trim().length > 0 && selectedIdString.compareTo(dMapper.idString) == 0) {
                _selectedDMapper = dMapper;
              }
            } else {
              if (dMapper.idString.trim().length > 0 && selectedIdString.toLowerCase().compareTo(dMapper.idString.toLowerCase()) == 0) {
                _selectedDMapper = dMapper;
              }
            }
          }
        }
      });

    }
  }

  void setSelectedId(int selectedId) {
    selectedIndex = -1;
    if (dropViewSelectionIdType == DropViewSelectionIdType.SELECTION_BASED_ON_ID_INT) {
      setState(() {
        selectedIdString = "";
        for (var dMapper in items) {
          if (dMapper != null) {
            if (dMapper.id >= 0 && selectedId >= 0 && selectedId == dMapper.id) {
              _selectedDMapper = dMapper;
            }
          }
        }
      });
    }
  }

  void setSelectedIndex(int selectedIndex) {
    if (dropViewSelectionType == DropViewSelectionType.SELECTION_BASED_ON_INDEX) {
      setState(() {
        selectedId = -1;
        selectedIdString = "";
        if (selectedIndex >= 0 && selectedIndex < items.length) {
          _selectedDMapper = items[selectedIndex];
        }
      });
    }
  }

  List<DropdownMenuItem<DMapper<Item?>?>> buildDropdownMenuItems(List<DMapper<Item?>?> list) {
    List<DropdownMenuItem<DMapper<Item?>?>> items = [];
    for (int i = 0; i < list.length; i++) {
      DMapper<Item?>? dMapper = list[i];
      if (dMapper != null) {
        items.add(
          DropdownMenuItem(
            value: dMapper,
            child: Text(dMapper.text, style: TextStyle(color: textColor, fontSize: textSize, fontFamily: fontFamily),),
          ),
        );
      }
    }
    return items;
  }

  void _onChangeDropdownItem(DMapper<Item?>? selectedDMapper) {
    setState(() {
      _selectedDMapper = selectedDMapper;
      onItemSelected(selectedDMapper);
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());//to remove focus
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidationUtils.isEmpty(title)
            ? Container()
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: TextStyle(color: titleColor, fontSize: titleSize, fontFamily: fontFamily, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
              ]),
        Container(
          width: double.infinity,
          //margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), border: Border.all(width: 1, color: borderColor ?? Colors.grey)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DMapper<Item?>?>(
                value: _selectedDMapper,
                //elevation: 5,
                style: itemTextStyle ?? TextStyle(color: Colors.black),
                hint: Text(hint, maxLines: 1, overflow: TextOverflow.ellipsis, style: hintTextStyle ?? TextStyle(color: hintTextColor, fontFamily: fontFamily)),
                items: _dropdownMenuItems,
                disabledHint: Text(_selectedDMapper?.text ?? "", style: TextStyle(color: hintTextColor, fontFamily: fontFamily)) ,
selectedItemBuilder: (context) {
                  return _dropdownMenuItems.map<Widget>((e){
                    return SafeArea(child: Column(children: [
                      Text("selected ${e.value?.id}"), Text("selected ${e.value?.text}")
                    ],));
                  }).toList();
                },

                onChanged: enable ? (DMapper<Item?>? selectedDMapper) {
                  _onChangeDropdownItem(selectedDMapper);
                } : null),
          ),
        )
      ],
    );
  }
}
