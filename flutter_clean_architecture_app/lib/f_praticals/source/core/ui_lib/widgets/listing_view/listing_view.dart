import 'dart:async';

import 'package:flearn/f_praticals/source/constants/color_constants.dart';
import 'package:flearn/f_praticals/source/core/utils/validation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum ListingWithSearchItemType { TYPE_CARD, TYPE_CONTAINER }

typedef void OnListProcessing({String? searchText, String? filterColumn, bool? paging, int? pageSize, String? minDate, String? maxDate, int? pageNumber});
typedef Widget OnCreateListItem<Item>(BuildContext context, Item item, int index, List<Item> items);
typedef String? GetSavedDate<Item>(Item item);

enum SearchType { SEARCH_DIALOG, SEARCH_LIST_BOTTOM }

class ListingView<Item> extends StatefulWidget {
  final double borderRadiusSearchBar;
  final double borderRadiusSearchFilterItem;
  final double borderRadiusItem;
  final EdgeInsetsGeometry itemMargin;
  final Color itemBorderColor;
  final EdgeInsetsGeometry itemPadding;
  final int filterIndex;
  final List filterTexts;
  final List filterColumns;
  final bool isSearchEnabled;
  final String searchText;
  final bool? paging;
  final int pageSize;
  final ListingWithSearchItemType listingWithSearchItemType;
  final Color listItemBackgroundColor;
  final SearchType searchType;
  final bool isPaginationBasedOnPageNumber;
  final OnListProcessing onListProcessing;
  final OnCreateListItem<Item> onCreateListItem;
  final GetSavedDate<Item>? getSavedDate;
  final bool enablePullUp;
  final bool enablePullDown;
  final bool searchByClickingSearchIcon;
  final Widget? loadingContent;
  final String searchHint;
  final String searchHintByFilter;
  final String okText;
  final String cancelText;
  final String searchDialogTitle;
  final String noRecordText;
  final String retryText;
  final String tapToRetryText;
  final int initialPageNumber;
  final Color searchBorderColor;
  final double searchBorderWidth;
  final EdgeInsetsGeometry searchMargin;
  final Color searchTextColor;
  final Color searchIconColor;
  final IconData searchIcon;
  final String? searchFontFamily;
  final double searchFontSize;

  ListingView(
      {Key? key,
      this.filterTexts = const [],
      this.filterColumns = const [],
      this.isSearchEnabled = false,
      this.searchText = "",
      this.paging = true,
      this.pageSize = 50,
      this.listingWithSearchItemType = ListingWithSearchItemType.TYPE_CARD,
      this.listItemBackgroundColor = Colors.white,
      this.searchType = SearchType.SEARCH_LIST_BOTTOM,
      this.isPaginationBasedOnPageNumber = false,
      this.borderRadiusSearchBar = 0,
      this.borderRadiusItem = 0,
      this.borderRadiusSearchFilterItem = 0,
      this.itemMargin = const EdgeInsets.only(left: 5, right: 5, top: 5),
      this.itemBorderColor = Colors.white,
      this.itemPadding = const EdgeInsets.all(10),
      this.filterIndex = -1,
      required this.onListProcessing,
      required this.onCreateListItem,
      this.getSavedDate,
      this.enablePullUp = true,
      this.enablePullDown = true,
      this.searchByClickingSearchIcon = false,
      this.loadingContent,
      this.searchHint = "Enter Search keyword..",
      this.searchHintByFilter = "Search by",
      this.okText = "Ok",
      this.cancelText = "Cancel",
      this.searchDialogTitle = "Filter By",
      this.noRecordText = "Sorry, No records found!",
      this.retryText = "Retry",
      this.tapToRetryText = "Tap to Retry",
      this.initialPageNumber = 0,
      this.searchBorderColor = ColorConstant.COLOR_LIGHT_GREY,
      this.searchBorderWidth = 1,
      this.searchMargin = const EdgeInsets.all(5),
      this.searchTextColor = ColorConstant.Light_GREY,
      this.searchIconColor = ColorConstant.Light_GREY,
      this.searchIcon = Icons.search,
      this.searchFontFamily,
      this.searchFontSize = 14})
      : super(key: key);

  @override
  ListingViewState createState() => ListingViewState<Item>(
      searchText: searchText,
      filterTexts: filterTexts,
      filterColumns: filterColumns,
      isSearchEnabled: isSearchEnabled,
      paging: paging,
      pageSize: pageSize,
      listingWithSearchItemType: listingWithSearchItemType,
      searchType: searchType,
      isPaginationBasedOnPageNumber: isPaginationBasedOnPageNumber,
      listItemBackgroundColor: listItemBackgroundColor,
      itemMargin: itemMargin,
      borderRadiusItem: borderRadiusItem,
      borderRadiusSearchBar: borderRadiusSearchBar,
      borderRadiusSearchFilterItem: borderRadiusSearchFilterItem,
      itemBorderColor: itemBorderColor,
      itemPadding: itemPadding,
      filterIndex: filterIndex,
      onListProcessing: onListProcessing,
      onCreateListItem: onCreateListItem,
      getSavedDate: getSavedDate,
      enablePullUp: enablePullUp,
      enablePullDown : enablePullDown,
      searchByClickingSearchIcon: searchByClickingSearchIcon,
      loadingContent: loadingContent,
      searchHint: searchHint,
      searchHintByFilter: searchHintByFilter,
      okText: okText,
      cancelText: cancelText,
      searchDialogTitle: searchDialogTitle,
      noRecordText: noRecordText,
      retryText: retryText,
      tapToRetryText: tapToRetryText,
      initialPageNumber: initialPageNumber,
      searchBorderColor: searchBorderColor,
      searchBorderWidth: searchBorderWidth,
      searchMargin: searchMargin,
      searchTextColor: searchTextColor,
      searchIconColor: searchIconColor,
      searchIcon: searchIcon,
      searchFontFamily: searchFontFamily,
      searchFontSize: searchFontSize);
}

class ListingViewState<Item> extends State<ListingView> {
  final double borderRadiusSearchBar;
  final double borderRadiusSearchFilterItem;
  final double borderRadiusItem;
  final EdgeInsetsGeometry itemMargin;
  final Color itemBorderColor;
  final EdgeInsetsGeometry itemPadding;
  int filterIndex;
  final SearchType searchType;
  final bool isPaginationBasedOnPageNumber;
  final OnListProcessing onListProcessing;
  final OnCreateListItem<Item> onCreateListItem;
  final GetSavedDate<Item>? getSavedDate;
  final bool enablePullUp;
  final bool enablePullDown;
  final bool searchByClickingSearchIcon;
  final Widget? loadingContent;
  final String searchHint;
  final String searchHintByFilter;
  final String okText;
  final String cancelText;
  final String searchDialogTitle;
  final String noRecordText;
  final String retryText;
  final String tapToRetryText;
  final int initialPageNumber;
  final List filterTexts;
  final List filterColumns;
  final bool isSearchEnabled;
  String searchText;
  final bool? paging;
  final int pageSize;
  final ListingWithSearchItemType listingWithSearchItemType;
  final Color listItemBackgroundColor;
  final Color searchBorderColor;
  final double searchBorderWidth;
  final EdgeInsetsGeometry searchMargin;
  final Color searchTextColor;
  final Color searchIconColor;
  final IconData searchIcon;
  final String? searchFontFamily;
  final double searchFontSize;
  Timer? _debounce;

  // for search enable
  bool _isSearchEnabled = false;

  /*minDate, maxDate*/
  String? minDate = "";
  String? maxDate = "";

  /*page number*/
  int _pageNumber = 0;
  int _pageNumberLastSaved = 0;

  String _filterColumn = "";
  TextEditingController _searchTextEditingController = TextEditingController();

  /*refresh configuration*/
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();

  /*list data*/
  List<Item> data = [];

  /*initial containers*/
  //Widget _initialContent = Container();
  Widget _retryContent = Container();

  //Widget _mainContent = Container();
  Widget _listContent = Container();

  bool _onException = false;

  /*search process*/
  String _searchHint = "";
  bool _deleteTextIconVisible = false;

  bool _enablePullUp = false;
  bool _enablePullDown = false;

  ListingViewState(
      {required this.searchText,
      required this.filterTexts,
      required this.filterColumns,
      required this.isSearchEnabled,
      required this.paging,
      required this.pageSize,
      required this.listingWithSearchItemType,
      required this.listItemBackgroundColor,
      required this.searchType,
      required this.isPaginationBasedOnPageNumber,
      required this.borderRadiusSearchBar,
      required this.borderRadiusItem,
      required this.borderRadiusSearchFilterItem,
      required this.itemMargin,
      required this.itemBorderColor,
      required this.itemPadding,
      required this.filterIndex,
      required this.onListProcessing,
      required this.onCreateListItem,
      required this.getSavedDate,
      required this.enablePullUp,
      required this.enablePullDown,
      required this.searchByClickingSearchIcon,
      required this.loadingContent,
      required this.searchHint,
      required this.searchHintByFilter,
      required this.okText,
      required this.cancelText,
      required this.searchDialogTitle,
      required this.noRecordText,
      required this.retryText,
      required this.tapToRetryText,
      required this.initialPageNumber,
      required this.searchBorderColor,
      required this.searchBorderWidth,
      required this.searchMargin,
      required this.searchTextColor,
      required this.searchIconColor,
      required this.searchIcon,
      required this.searchFontFamily,
      required this.searchFontSize});

  @override
  void initState() {
    _listContent = _initialContent();

    //initial search enabled
    _isSearchEnabled = isSearchEnabled;
    _pageNumber = initialPageNumber;
    _pageNumberLastSaved = _pageNumber;
    onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        pageSize: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    super.initState();
  }

  Widget _initialContent() {
    if (searchText.isNotEmpty) {
      _searchTextEditingController.text = searchText;
      _deleteTextIconVisible = true;
    } else {
      _searchTextEditingController.text = "";
      _deleteTextIconVisible = false;
    }

    if (filterColumns.isNotEmpty &&
        filterTexts.isNotEmpty &&
        filterColumns.length == filterTexts.length &&
        filterIndex >= 0 &&
        filterIndex < filterColumns.length) {
      _searchHint = "$searchHintByFilter ${filterTexts[filterIndex]}";
      _filterColumn = filterColumns[filterIndex];
    } else {
      _searchHint = searchHint;
      filterIndex = -1;
      _filterColumn = "";
    }

    return loadingContent ?? Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.hourglassEnd,
            size: 60, color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text('Please wait')
        ],
      ),
    );
  }

  void setItems({List<Item> items = const []}) {
    _onException = false;
    _retryContent = Container();

    if (items.length > 0) {
      //Print.Reference("DATA LENGTH ${items.length}");
      data.addAll(items);
    } else {
      if (isPaginationBasedOnPageNumber) {
        _pageNumber--;

        if (_pageNumber <= 0) {
          _pageNumber = initialPageNumber;
        }
        _pageNumberLastSaved = _pageNumber;
      }
    }

    if (data.length == 0) { //search container will be hidden if total records = 0 & if search enabled then search text is empty
      _isSearchEnabled = !ValidationUtils.isEmpty(_searchTextEditingController.text) ? isSearchEnabled : false;
    } else if (data.length > 0) {
      _isSearchEnabled = isSearchEnabled;
    }

    setState(() {
      _enablePullUp = true;
      _enablePullDown = true;

      if(items.length < pageSize) { //disable load more, if record less than page size
        _enablePullUp = false;
      }

      if (items.isEmpty && data.isEmpty) {
        _listContent = _buildRetryContent(text: noRecordText, isRetryButtonEnabled: false, isRetryToBottomView: false);
      } else {
        _listContent = _buildListView();
      }
    });
  }

  void onRefreshListView() {
    setState(() {
      _listContent = _buildListView();
    });
  }

  void onRefresh({bool isResetSearchText = false, bool isResetFilterColumn = false}) {
    if (isResetSearchText) {
      searchText = "";
      filterIndex = filterIndex;
      _filterColumn = "";
    }
    if (isResetFilterColumn) {
      filterIndex = filterIndex;
      _filterColumn = "";
    }

    _onRefresh();
  }

  void onErrorShow(String errorMessage) {
    if (data.length == 0) { //search container will be hidden if total records = 0 & if search enabled then search text is empty
      _isSearchEnabled = !ValidationUtils.isEmpty(_searchTextEditingController.text) ? isSearchEnabled : false;
    } else if (data.length > 0) {
      _isSearchEnabled = isSearchEnabled;
    }

    if (isPaginationBasedOnPageNumber) {
      _pageNumber--;

      if (_pageNumber <= 0) {
        _pageNumber = initialPageNumber;
      }
      _pageNumberLastSaved = _pageNumber;
    }

    setState(() {
      _retryContent = _buildRetryContent(
          text: errorMessage,
          isRetryButtonEnabled: true,
          isRetryToBottomView: data.length > 0 ? true : false);

      _onException = true;
      _enablePullUp = false;
      _enablePullDown = true;
      if (data.length > 0) {
        _listContent = _buildListView();
      } else {
        _listContent = _retryContent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _refreshConfiguration());
  }

  Widget _refreshConfiguration() {
    Widget refreshConfig = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _isSearchEnabled ? _searchContainer() : Container(),
        Expanded(
          child: RefreshConfiguration(
            headerBuilder: () => WaterDropMaterialHeader(
              backgroundColor: Colors.grey[300],
            ),
            footerBuilder: () => ClassicFooter(),
            headerTriggerDistance: 30.0,
            maxOverScrollExtent: 100,
            maxUnderScrollExtent: 0,
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: false,
            enableBallisticLoad: true,
            footerTriggerDistance: 30,
            child: SmartRefresher(
                key: _refreshKey,
                controller: _refreshController,
                enablePullUp: enablePullUp ? _enablePullUp: false,
                enablePullDown: enablePullDown ? _enablePullDown: false,
                physics: BouncingScrollPhysics(),
                footer: ClassicFooter(idleText: "", loadingText: "", canLoadingText: "", failedText: "", noDataText: "",
                  loadStyle: LoadStyle.ShowWhenLoading,
                ),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: _listContent),
          ),
        ),
      ],
    );

    return refreshConfig;
  }

  Widget _buildListView() {
    Widget listView = ListView.builder(
        key: _contentKey,
        itemBuilder: (context, index) {
          return Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardOrContainer(child: onCreateListItem(context, data[index], index, data)),
                  _onException == true && index == data.length - 1 ? _retryContent : Container()
                ],
              ));
        },
        itemCount: data.length);

    if (data.length > 0) {
      return listView;
    } else {
      return _buildRetryContent(text: noRecordText, isRetryButtonEnabled: false, isRetryToBottomView: false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
    _debounce?.cancel();
    _refreshController.dispose();
  }

  void _onRefresh() async {
    //Print.Reference("Refresh");
    //Print.Reference("before refresh filterIndex $filterIndex");
    //filterIndex = filterIndex;
    //Print.Reference("after refresh filterIndex $filterIndex");

    /*clear old data*/
    data.clear();
    minDate = "";

    _refreshKey.currentState?.setState(() {
      _listContent = _initialContent();
    });

    _pageNumber = initialPageNumber;
    _pageNumberLastSaved = _pageNumber;
    onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        pageSize: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    await Future.delayed(Duration(seconds: 1));

    _refreshKey.currentState?.setState(() {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    //Print.Reference("_onLoading");
    //Print.Reference("data length: ${data.length}");
    //Print.Reference(data.length - 2);

    if(getSavedDate != null) {
      minDate = ValidationUtils.isEmpty(getSavedDate!(data.last)) ? "" : getSavedDate!(data.last);
    } else {
      minDate = "";
    }

    if (isPaginationBasedOnPageNumber) {
      _pageNumber++;
      _pageNumberLastSaved = _pageNumber;
      minDate = "";
    } else {
      _pageNumber = initialPageNumber;
      _pageNumberLastSaved = _pageNumber;
    }
    onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        pageSize: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _refreshController.loadComplete();
    });
  }

  void _onRetryClicked() async {
    if (data.length == 0) {
      setState(() {
        _listContent = _initialContent();
      });
    }

    if (isPaginationBasedOnPageNumber) {
      _pageNumber = _pageNumberLastSaved;
      minDate = "";
    }

    onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        pageSize: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _refreshController.loadComplete();
    });
  }

  Widget _buildRetryContent({required String text, bool isRetryButtonEnabled = true, bool isRetryToBottomView = true}) {
    Widget retryContainer = isRetryButtonEnabled
        ? TextButton(
            onPressed: () => {_onRetryClicked()},
            child: Text(isRetryToBottomView == true ? tapToRetryText : retryText, style: TextStyle(fontFamily: searchFontFamily, color: searchTextColor)),
            style: TextButton.styleFrom(
              foregroundColor: Colors.teal, textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: searchFontFamily
              ),
            ))
        : Container();

    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: isRetryToBottomView == true
          ? Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(text, style: TextStyle(fontFamily: searchFontFamily, color: searchTextColor)),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Icon(FontAwesomeIcons.sadCry, size: 24),
                  retryContainer,
                ],
              )
            ])
          : Container(
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Icon(FontAwesomeIcons.sadCry, size: 60),
                  SizedBox(
                    height: 20,
                  ),
                  Text(text, style: TextStyle(fontSize: 24, fontFamily: searchFontFamily, color: searchTextColor)),
                  SizedBox(
                    height: 20,
                  ),
                  retryContainer
                ],
              ),
          ),
    );
  }

  Widget _cardOrContainer({required Widget child}) {
    if (listingWithSearchItemType == ListingWithSearchItemType.TYPE_CARD) {
      return Card(
        margin: itemMargin,
        child: Container(padding: itemPadding, child: child),
        color: listItemBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: itemBorderColor, width: 1),
          borderRadius: BorderRadius.circular(borderRadiusItem),
        ),
      );
    } else {
      return Container(
          padding: itemPadding,
          margin: itemMargin,
          child: child,
          decoration: BoxDecoration(
              color: listItemBackgroundColor, border: Border.all(width: 1, color: itemBorderColor), borderRadius: BorderRadius.circular(borderRadiusItem)));
    }
  }

  Widget _searchContainer() {
    return StatefulBuilder(builder: (context, setState2) {
      Widget searchFilterDialog = filterColumns.isNotEmpty && filterTexts.isNotEmpty && filterColumns.length == filterTexts.length && filterColumns.length > 1
          ? IconButton(
              icon: Icon(FontAwesomeIcons.filter),
              onPressed: () {
                _showSearchFilterDialog();
              })
          : Container();

      Widget searchFilterHorizontal =
          filterColumns.isNotEmpty && filterTexts.isNotEmpty && filterColumns.length == filterTexts.length && filterColumns.length > 1
              ? _showSearchFilter(setState2)
              : Container();

      return Column(
        children: [
          Container(
            width: double.infinity,
            margin: searchMargin,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadiusSearchBar), border: Border.all(width: searchBorderWidth, color: searchBorderColor)),
            child: Row(
              children: [
                searchType == SearchType.SEARCH_DIALOG
                    ? IconButton(
                        icon: Icon(searchIcon, color: searchIconColor),
                        onPressed: () {
                          if (!ValidationUtils.isEmpty(_searchTextEditingController.text)) {
                            if(searchByClickingSearchIcon) {
                              _onSearch();
                            }
                          }
                        },
                      )
                    : Container(),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    controller: _searchTextEditingController,
                    autofocus: false,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(5), hintText: _searchHint, border: InputBorder.none),
                    style: TextStyle(color: searchTextColor, fontFamily: searchFontFamily, fontSize: searchFontSize),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState2(() {
                          _deleteTextIconVisible = false;
                        });
                      } else {
                        setState2(() {
                          _deleteTextIconVisible = true;
                        });
                      }

                      if(!searchByClickingSearchIcon) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce = Timer(const Duration(milliseconds: 1400), () {
                          _onSearch();
                        });
                      }
                    },
                  ),
                ),
                _deleteTextIconVisible
                    ? IconButton(
                        icon: Icon(FontAwesomeIcons.backspace, size: 18),
                        onPressed: () {
                          _searchTextEditingController.text = "";
                          setState2(() {
                            _deleteTextIconVisible = false;
                            if (filterColumns.isNotEmpty &&
                                filterTexts.isNotEmpty &&
                                filterColumns.length == filterTexts.length &&
                                filterIndex >= 0 &&
                                filterIndex < filterColumns.length) {
                              _searchHint = "$searchHintByFilter ${filterTexts[filterIndex]}";
                              _filterColumn = filterColumns[filterIndex];
                              //Print.Reference("on click delete icon $_filterColumn");
                              filterIndex = filterIndex;
                            }
                          });
                          _onSearch();
                        })
                    : Container(),
                searchType == SearchType.SEARCH_LIST_BOTTOM
                    ? IconButton(
                        icon: Icon(searchIcon, color: searchIconColor),
                        onPressed: () {
                          if (!ValidationUtils.isEmpty(_searchTextEditingController.text)) {
                            _onSearch();
                          }
                        },
                      )
                    : Container(),
                searchType == SearchType.SEARCH_DIALOG ? searchFilterDialog : Container()
              ],
            ),
          ),
          searchType == SearchType.SEARCH_LIST_BOTTOM ? searchFilterHorizontal : Container()
        ],
      );
    });
  }

  void _onSearch() {
    if (filterColumns.isNotEmpty &&
        filterTexts.isNotEmpty &&
        filterColumns.length == filterTexts.length &&
        filterIndex >= 0 &&
        filterIndex < filterColumns.length) {
      _filterColumn = filterColumns[filterIndex];
    }
    searchText = _searchTextEditingController.text;

    //Print.Reference("search text: " + _searchTextEditingController.text);

    data.clear();
    setState(() {
      FocusScope.of(context).requestFocus(FocusNode()); //hide keyboard
      _listContent = _initialContent();
    });

    minDate = "";
    if (isPaginationBasedOnPageNumber) {
      _pageNumber = initialPageNumber;
      _pageNumberLastSaved = _pageNumber;
    }
    onListProcessing(
        searchText: searchText,
        filterColumn: ValidationUtils.isEmpty(_filterColumn) || ValidationUtils.isEmpty(searchText) ? "" : _filterColumn,
        pageSize: pageSize,
        paging: paging,
        minDate: minDate,
        maxDate: maxDate,
        pageNumber: _pageNumber);
  }

  /*show search filter*/
  Widget _showSearchFilter(Function setState2) {
    return Container(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        itemCount: filterTexts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                filterIndex = index;
                //Print.Reference('current index: $filterIndex , ${filterTexts[filterIndex]}');

                setState2(() {
                  _deleteTextIconVisible = false;
                  _filterColumn = filterColumns[filterIndex];
                  _searchTextEditingController.text = "";
                  _searchHint = "$searchHintByFilter ${filterTexts[filterIndex]}";
                  _onSearch();
                });
              },
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: index == filterIndex ? ColorConstant.Btn_color : ColorConstant.COLOR_LIGHT_GREY,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadiusSearchFilterItem))),
                  child: Text(
                    filterTexts[index],
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          );
        },
      ),
    );
  }

  void _showSearchFilterDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState2) {
              return AlertDialog(
                title: Text(searchDialogTitle),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text(cancelText),
                  ),
                  TextButton(
                    onPressed: () {
                      _filterColumn = filterColumns[filterIndex];
                      setState2(() {
                        _deleteTextIconVisible = false;
                        _searchTextEditingController.text = "";
                        _searchHint = "$searchHintByFilter ${filterTexts[filterIndex]}";
                      });
                      Navigator.pop(context, filterColumns[filterIndex]);
                    },
                    child: Text(okText),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterTexts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: index,
                        groupValue: filterIndex,
                        title: Text(filterTexts[index]),
                        onChanged: (int? val) {
                          if (val != null) {
                            setState2(() {
                              filterIndex = val;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }
}