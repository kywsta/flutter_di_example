import 'package:flutter/material.dart';
import 'package:flutter_di_example/provider/counter.dart';
import 'package:flutter_di_example/provider/counter_text_translation.dart';
import 'package:flutter_di_example/provider/item_list.dart';
import 'package:flutter_di_example/provider/item_service.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ItemService()),
        ChangeNotifierProvider(
          create: (context) => ItemList(context.read<ItemService>()),
        ),
        ChangeNotifierProvider(create: (_) => Counter()),
        ProxyProvider<Counter, CounterTextTranslation>(
          update: (_, value, __) => CounterTextTranslation(value),
        ),
      ],
      child: MaterialApp(home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterText = context.watch<CounterTextTranslation>().text;
    final isLoading = context.select<ItemList, bool>(
      (itemList) => itemList.isLoading,
    );
    final items = context.select<ItemList, List<String>>(
      (itemList) => itemList.items,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(counterText),
          Expanded(
            child: (isLoading)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Text(items[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Counter>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
