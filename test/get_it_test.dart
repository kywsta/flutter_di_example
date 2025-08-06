import 'package:flutter/material.dart';
import 'package:flutter_di_example/get_it/item_list.dart';
import 'package:flutter_di_example/get_it/item_repository.dart';
import 'package:flutter_di_example/get_it/main.dart';
import 'package:flutter_di_example/get_it/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  setUp(() {
    serviceLocator.reset();
    setupServiceLocator();
  });
  test('should get items from repository', () async {
    final itemRepository = serviceLocator<ItemRepository>();
    expect(itemRepository, isA<ItemRepository>());

    final items = await itemRepository.fetchItems();
    expect(items, isA<List<String>>());
    expect(items.length, greaterThan(0));
  });

  testWidgets('should shown progress indicator during loading and shown items in the list after loading', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(ItemListPage), findsOneWidget);

    BuildContext context = tester.element(find.byType(ItemListPage));

    final itemList = Provider.of<ItemList>(
      context,
      listen: false,
    );

    expect(itemList, isA<ItemList>());
    expect(itemList.isLoading, isTrue);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(Duration(seconds: 3));

    expect(itemList.isLoading, isFalse);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);
  });
}
