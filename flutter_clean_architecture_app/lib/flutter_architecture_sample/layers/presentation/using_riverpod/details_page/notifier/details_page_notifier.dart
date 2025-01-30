import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flearn/flutter_architecture_sample/layers/presentation/using_riverpod/details_page/notifier/details_page_state.dart';

final detailsPageProvider =
    NotifierProvider<DetailsPageNotifier, DetailsPageState>(
  () => DetailsPageNotifier(),
);

class DetailsPageNotifier extends Notifier<DetailsPageState> {
  DetailsPageNotifier();

  @override
  DetailsPageState build() => DetailsPageState();
}
