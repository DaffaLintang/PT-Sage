class SelectedMenu {
  final int menuId;
  final String menuName;
  final List<ActionItem> actions;

  SelectedMenu({
    required this.menuId,
    required this.menuName,
    required this.actions,
  });

  factory SelectedMenu.fromJson(Map<String, dynamic> json) {
    return SelectedMenu(
      menuId: json['menu_id'],
      menuName: json['menu_name'],
      actions: (json['actions'] as List)
          .map((action) => ActionItem.fromJson(action))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menuId,
      'menu_name': menuName,
      'actions': actions.map((action) => action.toJson()).toList(),
    };
  }
}

class ActionItem {
  final int actionId;
  final String actionName;
  final String routeName;

  ActionItem({
    required this.actionId,
    required this.actionName,
    required this.routeName,
  });

  factory ActionItem.fromJson(Map<String, dynamic> json) {
    return ActionItem(
      actionId: json['action_id'],
      actionName: json['action_name'],
      routeName: json['route_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action_id': actionId,
      'action_name': actionName,
      'route_name': routeName,
    };
  }
}
