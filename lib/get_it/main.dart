import 'package:flutter/material.dart';
import 'package:flutter_di_example/get_it/item_list.dart';
import 'package:flutter_di_example/get_it/item_repository.dart';
import 'package:flutter_di_example/get_it/service_locator.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  setupServiceLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              ItemList(serviceLocator<ItemRepository>())..fetchItems(),
          lazy: true,
        ),
      ],
      builder: (_, _) {
        return MaterialApp(home: ItemListPage());
      },
    );
  }
}

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<ItemList, bool>(
      (itemList) => itemList.isLoading,
    );
    final items = context.select<ItemList, List<String>>(
      (itemList) => itemList.items,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Item List')),
      body: (isLoading)
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Text(items[index]);
              },
            ),
    );
  }
}
