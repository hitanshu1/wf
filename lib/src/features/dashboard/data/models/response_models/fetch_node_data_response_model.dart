// To parse this JSON data, do
//
//     final fetchNodeFlowResponseModel = fetchNodeFlowResponseModelFromJson(jsonString);

import 'package:canvas_package/kuick_canvas.dart';

import '../workflow_model.dart';
class FetchNodeFlowResponseModel {
  String? status;
  String? msg;
  FetchNodeFlowData? data;

  FetchNodeFlowResponseModel({
    this.status,
    this.msg,
    this.data,
  });

  factory FetchNodeFlowResponseModel.fromJson(Map<String, dynamic> json) => FetchNodeFlowResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: json["data"] == null ? null : FetchNodeFlowData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class FetchNodeFlowData {
  The1755356852766772? the1755356852766772;
  NodeFlowData? flowData;

  FetchNodeFlowData({
    this.the1755356852766772,
    this.flowData,
  });

  factory FetchNodeFlowData.fromJson(Map<String, dynamic> json) => FetchNodeFlowData(
    the1755356852766772: json["1755356852766772"] == null ? null : The1755356852766772.fromJson(json["1755356852766772"]),
    flowData: json["flowData"] == null ? null : NodeFlowData.fromJson(json["flowData"]),
  );

  Map<String, dynamic> toJson() => {
    "1755356852766772": the1755356852766772?.toJson(),
    "flowData": flowData?.toJson(),
  };
}

class NodeFlowData {
  List<FetchNodeFlowAction>? actions;

  NodeFlowData({
    this.actions,
  });

  factory NodeFlowData.fromJson(Map<String, dynamic> json) => NodeFlowData(
    actions: json["actions"] == null ? [] : List<FetchNodeFlowAction>.from(json["actions"]!.map((x) => FetchNodeFlowAction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
  };
}

class FetchNodeFlowAction {
  int? serverId;
  int? serverParentId;
  int? id;
  String? buttonId;
  String? direction;
  String? parentId;
  int? order;
  String? type;
  String? label;
  String? subTitle;
  String? description;
  FetchNodeFlowPosition? position;
  String? icon;
  String? color;
  PlusPositions? plusPositions;
  dynamic settings;
  dynamic component;

  // ⬇️ UPDATED
  FetchNodeFlowChildren? children;

  int? width;
  int? height;
  KuickNodeShape? shape;

  FetchNodeFlowAction({
    this.serverId,
    this.serverParentId,
    this.id,
    this.buttonId,
    this.direction,
    this.parentId,
    this.order,
    this.type,
    this.label,
    this.subTitle,
    this.description,
    this.position,
    this.icon,
    this.color,
    this.plusPositions,
    this.settings,
    this.component,
    this.children,
    this.width,
    this.height,
    this.shape,
  });

  factory FetchNodeFlowAction.fromJson(Map<String, dynamic> json) =>
      FetchNodeFlowAction(
        serverId: json["serverId"],
        serverParentId: json["serverParentId"],
        id: json["id"],
        parentId: json["parentId"],
        buttonId: json["buttonId"],
        direction: json["direction"],
        order: json["order"],
        type: json["type"],
        label: json["label"],
        subTitle: json["subTitle"],
        description: json["description"],
        position: json["position"] == null
            ? null
            : FetchNodeFlowPosition.fromJson(json["position"]),
        icon: json["icon"],
        color: json["color"],
        plusPositions: json["plusPositions"] == null
            ? null
            : PlusPositions.fromJson(json["plusPositions"]),
        settings: json["settings"],
        component: json["component"],

        // ⬇️ NEW
        children: json["children"] == null
            ? null
            : FetchNodeFlowChildren.fromJson(json["children"] is List ? {} :json["children"]),

        width: json["width"],
        height: json["height"],
        shape: json["shape"] == null
            ? null
            : KuickNodeShape.values.byName(json["shape"]),
      );

  Map<String, dynamic> toJson() => {
    "serverId": serverId,
    "serverParentId": serverParentId,
    "id": id,
    "buttonId": buttonId,
    "direction": direction,
    "parentId": parentId,
    "order": order,
    "type": type,
    "label": label,
    "subTitle": subTitle,
    "description": description,
    "position": position?.toJson(),
    "icon": icon,
    "color": color,
    "plusPositions": plusPositions?.toJson(),
    "settings": settings,
    "component": component,

    "children": children?.toJson(),

    "width": width,
    "height": height,
    "shape": shape?.name,
  };
}

class FetchNodeFlowChildren {
  List<FetchNodeFlowAction>? top;
  List<FetchNodeFlowAction>? bottom;
  List<FetchNodeFlowAction>? left;
  List<FetchNodeFlowAction>? right;

  FetchNodeFlowChildren({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  factory FetchNodeFlowChildren.fromJson(Map<String, dynamic> json) =>
      FetchNodeFlowChildren(
        top: json["top"] == null
            ? []
            : List<FetchNodeFlowAction>.from(
          json["top"].map((x) => FetchNodeFlowAction.fromJson(x)),
        ),
        bottom: json["bottom"] == null
            ? []
            : List<FetchNodeFlowAction>.from(
          json["bottom"].map((x) => FetchNodeFlowAction.fromJson(x)),
        ),
        left: json["left"] == null
            ? []
            : List<FetchNodeFlowAction>.from(
          json["left"].map((x) => FetchNodeFlowAction.fromJson(x)),
        ),
        right: json["right"] == null
            ? []
            : List<FetchNodeFlowAction>.from(
          json["right"].map((x) => FetchNodeFlowAction.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "top": top == null
        ? []
        : List<dynamic>.from(top!.map((x) => x.toJson())),
    "bottom": bottom == null
        ? []
        : List<dynamic>.from(bottom!.map((x) => x.toJson())),
    "left": left == null
        ? []
        : List<dynamic>.from(left!.map((x) => x.toJson())),
    "right": right == null
        ? []
        : List<dynamic>.from(right!.map((x) => x.toJson())),
  };
}


class FetchNodeFlowPosition {
  int? dx;
  int? dy;

  FetchNodeFlowPosition({
    this.dx,
    this.dy,
  });

  factory FetchNodeFlowPosition.fromJson(Map<String, dynamic> json) => FetchNodeFlowPosition(
    dx: json["dx"],
    dy: json["dy"],
  );

  Map<String, dynamic> toJson() => {
    "dx": dx,
    "dy": dy,
  };
}

class The1755356852766772 {
  FetchNodeFlowMetadata? metadata;

  The1755356852766772({
    this.metadata,
  });

  factory The1755356852766772.fromJson(Map<String, dynamic> json) => The1755356852766772(
    metadata: json["metadata"] == null ? null : FetchNodeFlowMetadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "metadata": metadata?.toJson(),
  };
}

class FetchNodeFlowMetadata {
  int? serverId;
  String? flowId;
  int? projectId;
  int? pageId;
  String? widgetId;
  String? title;
  String? trigger;

  FetchNodeFlowMetadata({
    this.serverId,
    this.flowId,
    this.projectId,
    this.pageId,
    this.widgetId,
    this.title,
    this.trigger,
  });

  factory FetchNodeFlowMetadata.fromJson(Map<String, dynamic> json) => FetchNodeFlowMetadata(
    serverId: json["serverId"],
    flowId: json["flowId"],
    projectId: json["projectId"],
    pageId: json["pageId"],
    widgetId: json["widgetId"],
    title: json["title"],
    trigger: json["trigger"],
  );

  Map<String, dynamic> toJson() => {
    "serverId": serverId,
    "flowId": flowId,
    "projectId": projectId,
    "pageId": pageId,
    "widgetId": widgetId,
    "title": title,
    "trigger": trigger,
  };
}
