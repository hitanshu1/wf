// To parse this JSON data, do
//
//     final createNodeResponseModel = createNodeResponseModelFromJson(jsonString);

import 'dart:convert';

CreateNodeResponseModel createNodeResponseModelFromJson(String str) => CreateNodeResponseModel.fromJson(json.decode(str));

String createNodeResponseModelToJson(CreateNodeResponseModel data) => json.encode(data.toJson());

class CreateNodeResponseModel {
  String? status;
  String? msg;
  List<dynamic>? flowType;
  Data? data;

  CreateNodeResponseModel({
    this.status,
    this.msg,
    this.flowType,
    this.data,
  });

  factory CreateNodeResponseModel.fromJson(Map<String, dynamic> json) => CreateNodeResponseModel(
    status: json["status"],
    msg: json["msg"],
    flowType: json["flow_type"] == null ? [] : List<dynamic>.from(json["flow_type"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "flow_type": flowType == null ? [] : List<dynamic>.from(flowType!.map((x) => x)),
    "data": data?.toJson(),
  };
}

class Data {
  String? pageId;
  WorkFlow? workFlow;
  String? serverId;
  String? serverParentId;
  String? metadataServerId;

  Data({
    this.pageId,
    this.workFlow,
    this.serverId,
    this.serverParentId,
    this.metadataServerId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pageId: json["pageId"],
    workFlow: json["work_flow"] == null ? null : WorkFlow.fromJson(json["work_flow"]),
    serverId: json["serverId"] == null ? "" : json["serverId"].toString(),
    serverParentId: json["serverParentId"] == null ? "" :json["serverParentId"].toString(),
    metadataServerId: json["metadataServerId"] == null ? "" : json["metadataServerId"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "pageId": pageId,
    "work_flow": workFlow?.toJson(),
    "serverId": serverId,
    "serverParentId": serverParentId,
    "metadataServerId": metadataServerId,
  };
}

class WorkFlow {
  The1755356852766772? the1755356852766772;

  WorkFlow({
    this.the1755356852766772,
  });

  factory WorkFlow.fromJson(Map<String, dynamic> json) => WorkFlow(
    the1755356852766772: json["1755356852766772"] == null ? null : The1755356852766772.fromJson(json["1755356852766772"]),
  );

  Map<String, dynamic> toJson() => {
    "1755356852766772": the1755356852766772?.toJson(),
  };
}

class The1755356852766772 {
  Metadata? metadata;
  FlowData? flowData;

  The1755356852766772({
    this.metadata,
    this.flowData,
  });

  factory The1755356852766772.fromJson(Map<String, dynamic> json) => The1755356852766772(
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    flowData: json["flowData"] == null ? null : FlowData.fromJson(json["flowData"]),
  );

  Map<String, dynamic> toJson() => {
    "metadata": metadata?.toJson(),
    "flowData": flowData?.toJson(),
  };
}

class FlowData {
  List<Action>? actions;

  FlowData({
    this.actions,
  });

  factory FlowData.fromJson(Map<String, dynamic> json) => FlowData(
    actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
  };
}

class Action {
  int? id;
  int? serverId;
  int? serverParentId;
  int? order;
  int? parentId;
  String? type;
  Position? position;
  String? label;
  String? subTitle;
  String? description;
  Settings? settings;
  Component? component;
  List<dynamic>? children;

  Action({
    this.id,
    this.serverId,
    this.serverParentId,
    this.order,
    this.parentId,
    this.type,
    this.position,
    this.label,
    this.subTitle,
    this.description,
    this.settings,
    this.component,
    this.children,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    id: json["id"],
    serverId: json["serverId"],
    serverParentId: json["serverParentId"],
    order: json["order"],
    parentId: json["parentId"],
    type: json["type"],
    position: json["position"] == null ? null : Position.fromJson(json["position"]),
    label: json["label"],
    subTitle: json["subTitle"],
    description: json["description"],
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
    component: json["component"] == null ? null : Component.fromJson(json["component"]),
    children: json["children"] == null ? [] : List<dynamic>.from(json["children"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serverId": serverId,
    "serverParentId": serverParentId,
    "order": order,
    "parentId": parentId,
    "type": type,
    "position": position?.toJson(),
    "label": label,
    "subTitle": subTitle,
    "description": description,
    "settings": settings?.toJson(),
    "component": component?.toJson(),
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
  };
}

class Component {
  String? componentType;
  ComponentBody? componentBody;

  Component({
    this.componentType,
    this.componentBody,
  });

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    componentType: json["componentType"],
    componentBody: json["componentBody"] == null ? null : ComponentBody.fromJson(json["componentBody"]),
  );

  Map<String, dynamic> toJson() => {
    "componentType": componentType,
    "componentBody": componentBody?.toJson(),
  };
}

class ComponentBody {
  Destination? destination;
  bool? allowBackNavigation;
  bool? replaceRoute;

  ComponentBody({
    this.destination,
    this.allowBackNavigation,
    this.replaceRoute,
  });

  factory ComponentBody.fromJson(Map<String, dynamic> json) => ComponentBody(
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    allowBackNavigation: json["allowBackNavigation"],
    replaceRoute: json["replaceRoute"],
  );

  Map<String, dynamic> toJson() => {
    "destination": destination?.toJson(),
    "allowBackNavigation": allowBackNavigation,
    "replaceRoute": replaceRoute,
  };
}

class Destination {
  String? destinationType;
  int? destinationId;

  Destination({
    this.destinationType,
    this.destinationId,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    destinationType: json["destinationType"],
    destinationId: json["destinationId"],
  );

  Map<String, dynamic> toJson() => {
    "destinationType": destinationType,
    "destinationId": destinationId,
  };
}

class Position {
  int? dx;
  int? dy;

  Position({
    this.dx,
    this.dy,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    dx: json["dx"],
    dy: json["dy"],
  );

  Map<String, dynamic> toJson() => {
    "dx": dx,
    "dy": dy,
  };
}

class Settings {
  bool? isConditionalExpanded;
  bool? isParallelExpanded;
  dynamic conditionalSide;
  LHeights? conditionalHeights;
  LHeights? parallelHeights;

  Settings({
    this.isConditionalExpanded,
    this.isParallelExpanded,
    this.conditionalSide,
    this.conditionalHeights,
    this.parallelHeights,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    isConditionalExpanded: json["isConditionalExpanded"],
    isParallelExpanded: json["isParallelExpanded"],
    conditionalSide: json["conditionalSide"],
    conditionalHeights: json["conditionalHeights"] == null ? null : LHeights.fromJson(json["conditionalHeights"]),
    parallelHeights: json["parallelHeights"] == null ? null : LHeights.fromJson(json["parallelHeights"]),
  );

  Map<String, dynamic> toJson() => {
    "isConditionalExpanded": isConditionalExpanded,
    "isParallelExpanded": isParallelExpanded,
    "conditionalSide": conditionalSide,
    "conditionalHeights": conditionalHeights?.toJson(),
    "parallelHeights": parallelHeights?.toJson(),
  };
}

class LHeights {
  LHeights();

  factory LHeights.fromJson(Map<String, dynamic> json) => LHeights(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Metadata {
  String? flowId;
  int? serverId;
  int? serverParentId;
  String? trigger;
  String? projectId;
  int? order;
  String? pageId;
  String? widgetId;
  String? title;
  dynamic parentId;
  dynamic selectedTrigger;

  Metadata({
    this.flowId,
    this.serverId,
    this.serverParentId,
    this.trigger,
    this.projectId,
    this.order,
    this.pageId,
    this.widgetId,
    this.title,
    this.parentId,
    this.selectedTrigger,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    flowId: json["flowId"],
    serverId: json["serverId"],
    serverParentId: json["serverParentId"],
    trigger: json["trigger"],
    projectId: json["projectId"],
    order: json["order"],
    pageId: json["pageId"],
    widgetId: json["widgetId"],
    title: json["title"],
    parentId: json["parentId"],
    selectedTrigger: json["selectedTrigger"],
  );

  Map<String, dynamic> toJson() => {
    "flowId": flowId,
    "serverId": serverId,
    "serverParentId": serverParentId,
    "trigger": trigger,
    "projectId": projectId,
    "order": order,
    "pageId": pageId,
    "widgetId": widgetId,
    "title": title,
    "parentId": parentId,
    "selectedTrigger": selectedTrigger,
  };
}
