import 'package:pomodoropompurin/scripts/layout/item_display/item_display_entity.dart';

class ItemDisplayManager {
  ItemDisplayManager._();
  static final singleton = ItemDisplayManager._();

  List<ItemDisplayEntity> itemDisplayedEntities = [
    ItemDisplayEntity(maxWidth: 800, maxHeight: 400),
    ItemDisplayEntity(maxWidth: 800, maxHeight: 400),
  ];
}
