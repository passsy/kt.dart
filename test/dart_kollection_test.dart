import 'collection/iterable_extensions_test.dart' as iterable_extensions_test;
import 'collection/list_mutable_test.dart' as list_mutable_test;
import 'collection/list_test.dart' as list_test;
import 'collection/map_empty_test.dart' as map_empty_test;
import 'collection/map_extensions_test.dart' as map_extensions_test;
import 'collection/map_test.dart' as map_test;
import 'collection/set_test.dart' as set_test;
import 'collections_test.dart' as collections_test;

main() {
  collections_test.main();
  iterable_extensions_test.main();
  list_test.main();
  list_mutable_test.main();
  list_test.main();
  map_empty_test.main();
  map_extensions_test.main();
  map_test.main();
  set_test.main();
}
