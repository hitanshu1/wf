import 'package:canvas_package/kuick_canvas.dart';

KuickNodeShape shapeFromString(String value) {
  return KuickNodeShape.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
    orElse: () => KuickNodeShape.rectangle, // fallback
  );
}

String shapeToString(KuickNodeShape shape) => shape.name;

class WorkflowMenu {
  final String parent;
  final List<WorkflowChild> children;

  WorkflowMenu({
    required this.parent,
    required this.children,
  });

  factory WorkflowMenu.fromJson(Map<String, dynamic> json) {
    return WorkflowMenu(
      parent: json["parent"],
      children: (json["children"] as List)
          .map((c) => WorkflowChild.fromJson(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "parent": parent,
    "children": children.map((c) => c.toJson()).toList(),
  };
}

class WorkflowChild {
  final String id;
  final String pageId;
  final String title;
  final String subtitle;
  final String icon;
  final String color;
  final String trigger;
  final KuickNodeShape shape;
  final int height;
  final int width;
  final NodeUI nodeUI;
  final PlusPositions plusPositions;

  WorkflowChild({
    required this.id,
    required this.pageId,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.trigger,
    required this.shape,
    required this.height,
    required this.width,
    required this.nodeUI,
    required this.plusPositions,
  });

  factory WorkflowChild.fromJson(Map<String, dynamic> json) {
    return WorkflowChild(
      id: json["id"],
      pageId: json["pageId"],
      trigger: json["trigger"],
      title: json["title"],
      subtitle: json["subtitle"],
      icon: json["icon"],
      color: json["color"],
      shape: json["shape"] != null
          ? shapeFromString(json["shape"])
          : KuickNodeShape.rectangle,
      height: json["height"] ?? 150,
      width: json["width"] ?? 150,
      nodeUI: NodeUI.fromJson(json["nodeUI"]),
      plusPositions: PlusPositions.fromJson(json["plusPositions"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "pageId": pageId,
    "trigger": trigger,
    "title": title,
    "subtitle": subtitle,
    "icon": icon,
    "color": color,
    "shape": shapeToString(shape),
    "height": height,
    "width": width,
    "nodeUI": nodeUI.toJson(),
    "plusPositions": plusPositions.toJson(),
  };
}

class NodeUI {
  final String label;
  final String description;
  final String bgColor;
  final String textColor;
  final int borderRadius;

  NodeUI({
    required this.label,
    required this.description,
    required this.bgColor,
    required this.textColor,
    required this.borderRadius,
  });

  factory NodeUI.fromJson(Map<String, dynamic> json) => NodeUI(
    label: json["label"],
    description: json["description"],
    bgColor: json["bgColor"],
    textColor: json["textColor"],
    borderRadius: json["borderRadius"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "description": description,
    "bgColor": bgColor,
    "textColor": textColor,
    "borderRadius": borderRadius,
  };
}

class PlusPositions {
  List<Bottom>? top;
  List<Bottom>? bottom;
  List<Bottom>? left;
  List<Bottom>? right;

  PlusPositions({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  factory PlusPositions.fromJson(Map<String, dynamic> json) => PlusPositions(
    top: json["top"] == null ? [] : List<Bottom>.from(json["top"]!.map((x) => Bottom.fromJson(x))),
    bottom: json["bottom"] == null ? [] : List<Bottom>.from(json["bottom"]!.map((x) => Bottom.fromJson(x))),
    left: json["left"] == null ? [] : List<Bottom>.from(json["left"]!.map((x) => Bottom.fromJson(x))),
    right: json["right"] == null ? [] : List<Bottom>.from(json["right"]!.map((x) => Bottom.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "top": top == null ? [] : List<dynamic>.from(top!.map((x) => x.toJson())),
    "bottom": bottom == null ? [] : List<dynamic>.from(bottom!.map((x) => x.toJson())),
    "left": left == null ? [] : List<dynamic>.from(left!.map((x) => x.toJson())),
    "right": right == null ? [] : List<dynamic>.from(right!.map((x) => x.toJson())),
  };
}

class Bottom {
  String? id;
  String? templateType;

  Bottom({
    this.id,
    this.templateType,
  });

  factory Bottom.fromJson(Map<String, dynamic> json) => Bottom(
    id: json["id"],
    templateType: json["templateType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "templateType": templateType,
  };
}