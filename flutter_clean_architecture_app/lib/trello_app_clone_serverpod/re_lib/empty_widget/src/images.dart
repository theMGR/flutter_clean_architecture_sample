part of 'widget.dart';

// nodoc
enum PackageImage {
  image1,
  image2,
  image3,
  image4,
}

const _$PackageImageTypeMap = {
  PackageImage.image1: 'assets/images/emptyImage.png',
  PackageImage.image2: 'assets/images/im_emptyIcon_1.png',
  PackageImage.image3: 'assets/images/im_emptyIcon_2.png',
  PackageImage.image4: 'assets/images/im_emptyIcon_3.png',
};

extension Convert on PackageImage? {
  String? encode() => _$PackageImageTypeMap[this!];

  PackageImage? key(String value) => decodePackageImage(value);

  PackageImage? decodePackageImage(String value) {
    return _$PackageImageTypeMap.entries.singleWhere((element) => element.value == value).key;
  }
}
