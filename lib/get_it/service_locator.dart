import 'package:flutter_di_example/get_it/item_data_source.dart';
import 'package:flutter_di_example/get_it/item_repository.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<ItemDataSource>(
    () => MockItemDataSourceImpl(),
  );
  
  serviceLocator.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(itemDataSource: serviceLocator<ItemDataSource>()),
  );
}
