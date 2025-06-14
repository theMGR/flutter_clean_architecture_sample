import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flearn/flutter_architecture_sample/layers/presentation/using_bloc/details_page/bloc/character_details_bloc.dart';
import 'package:flearn/flutter_architecture_sample/layers/presentation/using_bloc/details_page/view/character_details_page.dart';

import '../../../../../../fixtures/fixtures.dart';

void main() {
  testWidgets('CharacterDetailsPage should render correctly',
      (WidgetTester tester) async {
    final character = characterList1.first;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: CharacterDetailsBloc(character: character),
          child: const CharacterDetailsPage(),
        ),
      ),
    );

    // Find items on the page
    expect(find.text('Details'), findsOneWidget);
    expect(find.text(character.name!), findsOneWidget);
    expect(find.text('Origin: ${character.origin!.name}'), findsOneWidget);
    expect(find.text('Species: ${character.species}'), findsOneWidget);
    expect(find.text('Type: ${character.type}'), findsOneWidget);
    expect(find.text('Gender: ${character.gender}'), findsOneWidget);
    expect(
      find.text('Status: ${character.isAlive ? 'ALIVE!' : 'DEAD!'}'),
      findsOneWidget,
    );
    expect(
      find.text('Last location: ${character.location!.name}'),
      findsOneWidget,
    );
    expectLater(
      find.byType(EpisodeItem),
      findsNWidgets(character.episode!.length),
    );
  });
}
