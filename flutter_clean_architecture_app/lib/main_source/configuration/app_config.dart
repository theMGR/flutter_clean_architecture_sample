import 'package:flutter/widgets.dart';

class AppConfiguration extends InheritedWidget {
  final String? appDisplayName;
  final String? baseUrl;
  final String? webSocketUrl;
  final String? s3ImgUploadsUrl;

  AppConfiguration({
    super.key,
    this.baseUrl,
    this.appDisplayName,
    this.webSocketUrl,
    this.s3ImgUploadsUrl,
  }) : super(child: Container());

  static AppConfiguration? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfiguration>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
