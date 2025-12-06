import 'package:canvas_package/kuick_canvas.dart';

import '../workflow_model.dart';

class CreateNodeArgModel {
  CreateNodeArgInputData? inputData;

  CreateNodeArgModel({
    this.inputData,
  });

  factory CreateNodeArgModel.fromJson(Map<String, dynamic> json, String widgetId) => CreateNodeArgModel(
    inputData: json["inputData"] == null ? null : CreateNodeArgInputData.fromJson(json["inputData"],widgetId),
  );

  Map<String, dynamic> toJson(String widgetId) => {
    "inputData": inputData?.toJson(widgetId),
  };
}

class CreateNodeArgInputData {
  String? pageId;
  CreateNodeArgWorkFlow? workFlow;

  CreateNodeArgInputData({
    this.pageId,
    this.workFlow,
  });

  factory CreateNodeArgInputData.fromJson(Map<String, dynamic> json,String widgetId) => CreateNodeArgInputData(
    pageId: json["pageId"],
    workFlow: json["work_flow"] == null ? null : CreateNodeArgWorkFlow.fromJson(json["work_flow"],widgetId),
  );

  Map<String, dynamic> toJson(String widgetId) => {
    "pageId": pageId,
    "work_flow": workFlow?.toJson(widgetId),
  };
}

class CreateNodeArgWorkFlow {
  The1755356852766772? the1755356852766772;

  CreateNodeArgWorkFlow({
    this.the1755356852766772,
  });

  factory CreateNodeArgWorkFlow.fromJson(Map<String, dynamic> json,String widgetId) => CreateNodeArgWorkFlow(
    the1755356852766772: json[widgetId] == null ? null : The1755356852766772.fromJson(json[widgetId]),
  );

  Map<String, dynamic> toJson(String widgetId) => {
    widgetId: the1755356852766772?.toJson(),
  };
}

class The1755356852766772 {
  CreateNodeArgMetadata? metadata;
  CreateNodeArgFlowData? flowData;

  The1755356852766772({
    this.metadata,
    this.flowData,
  });

  factory The1755356852766772.fromJson(Map<String, dynamic> json) => The1755356852766772(
    metadata: json["metadata"] == null ? null : CreateNodeArgMetadata.fromJson(json["metadata"]),
    flowData: json["flowData"] == null ? null : CreateNodeArgFlowData.fromJson(json["flowData"]),
  );

  Map<String, dynamic> toJson() => {
    "metadata": metadata?.toJson(),
    "flowData": flowData?.toJson(),
  };
}

class CreateNodeArgFlowData {
  List<CreateNodeArgAction>? actions;

  CreateNodeArgFlowData({
    this.actions,
  });

  factory CreateNodeArgFlowData.fromJson(Map<String, dynamic> json) => CreateNodeArgFlowData(
    actions: json["actions"] == null ? [] : List<CreateNodeArgAction>.from(json["actions"]!.map((x) => CreateNodeArgAction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
  };
}

class CreateNodeArgAction {
  int? id;
  int? serverId;
  int? serverParentId;
  int? order;
  int? parentId;
  String? direction;
  String? buttonId;
  String? type;
  CreateNodeArgPosition? position;
  String? label;
  String? subTitle;
  String? description;
  String? icon;
  String? color;
  KuickNodeShape? shape;
  int? height;
  int? width;
  PlusPositions? plusPositions;
  List<dynamic>? children;

  CreateNodeArgAction({
    this.id,
    this.serverId,
    this.serverParentId,
    this.order,
    this.direction,
    this.buttonId,
    this.parentId,
    this.type,
    this.position,
    this.label,
    this.subTitle,
    this.description,
    this.icon,
    this.color,
    this.shape,
    this.height,
    this.width,
    this.plusPositions,
    this.children,
  });

  factory CreateNodeArgAction.fromJson(Map<String, dynamic> json) =>
      CreateNodeArgAction(
        id: json["id"],
        serverId: json["serverId"],
        serverParentId: json["serverParentId"],
        order: json["order"],
        direction: json["direction"],
        buttonId: json["buttonId"],
        parentId: json["parentId"],
        type: json["type"],
        position: json["position"] == null
            ? null
            : CreateNodeArgPosition.fromJson(json["position"]),
        label: json["label"],
        subTitle: json["subTitle"],
        description: json["description"],
        icon: json["icon"],
        color: json["color"],
        shape: json["shape"] != null
            ? shapeFromString(json["shape"])
            : null,
        height: json["height"],
        width: json["width"],
        plusPositions: json["plusPositions"] == null
            ? null
            : PlusPositions.fromJson(json["plusPositions"]),
        children: json["children"] == null
            ? []
            : List<dynamic>.from(json["children"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serverId": serverId,
    "serverParentId": serverParentId,
    "order": order,
    "direction": direction,
    "buttonId": buttonId,
    "parentId": parentId,
    "type": type,
    "position": position?.toJson(),
    "label": label,
    "subTitle": subTitle,
    "description": description,
    "icon": icon,
    "color": color,
    "shape": shape?.name,
    "height": height,
    "width": width,
    "plusPositions": plusPositions?.toJson(),
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x)),
  };
}

class CreateNodeArgPosition {
  int? dx;
  int? dy;

  CreateNodeArgPosition({
    this.dx,
    this.dy,
  });

  factory CreateNodeArgPosition.fromJson(Map<String, dynamic> json) => CreateNodeArgPosition(
    dx: json["dx"],
    dy: json["dy"],
  );

  Map<String, dynamic> toJson() => {
    "dx": dx,
    "dy": dy,
  };
}

class CreateNodeArgMetadata {
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

  CreateNodeArgMetadata({
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

  factory CreateNodeArgMetadata.fromJson(Map<String, dynamic> json) => CreateNodeArgMetadata(
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


var data = {
  "status": "success",
  "msg": "All parent hierarchies fetched successfully",
  "data": {
    "1541651615": {
      "metadata": {
        "serverId": 95,
        "flowId": "main",
        "projectId": 8855,
        "pageId": 1515,
        "widgetId": "1541651615",
        "title": "Main",
        "trigger": "on chat"
      }
    },
    "flowData": {
      "actions": [
        {
          "serverId": 462,
          "serverParentId": 0,
          "id": 95,
          "parentId": "1",
          "order": 2,
          "type": "action",
          "label": "Chat Message",
          "subTitle": "When Received",
          "description": "",
          "position": {
            "dx": 400,
            "dy": 200
          },
          "icon": "assets/svg/messages.svg",
          "color": "#F1A33C",
          "plusPositions": {
            "top": [],
            "left": [
              {
                "id": "01",
                "templateType": "plus_icon"
              }
            ],
            "right": [
              {
                "id": "01",
                "templateType": "plus_icon"
              }
            ],
            "bottom": [
              {
                "id": "01",
                "templateType": "plus_icon"
              }
            ]
          },
          "height": 120,
          "width": 120,
          "shape": "circle",
          "buttonId": "01",
          "direction": "bottom",
          "settings": null,
          "component": null,
          "children": [
            {
              "serverId": 463,
              "serverParentId": 462,
              "id": 95,
              "parentId": "1",
              "order": 2,
              "type": "action",
              "label": "Chat Message",
              "subTitle": "When Received",
              "description": "",
              "position": {
                "dx": 400,
                "dy": 200
              },
              "icon": "assets/svg/messages.svg",
              "color": "#F1A33C",
              "plusPositions": {
                "top": [],
                "left": [
                  {
                    "id": "01",
                    "templateType": "plus_icon"
                  }
                ],
                "right": [
                  {
                    "id": "01",
                    "templateType": "plus_icon"
                  }
                ],
                "bottom": [
                  {
                    "id": "01",
                    "templateType": "plus_icon"
                  }
                ]
              },
              "height": 120,
              "width": 120,
              "shape": "circle",
              "buttonId": "01",
              "direction": "bottom",
              "settings": null,
              "component": null,
              "children": [
                {
                  "serverId": 464,
                  "serverParentId": 463,
                  "id": 95,
                  "parentId": "1",
                  "order": 1,
                  "type": "action",
                  "label": "Chat Message",
                  "subTitle": "When Received",
                  "description": "",
                  "position": {
                    "dx": 400,
                    "dy": 200
                  },
                  "icon": "assets/svg/messages.svg",
                  "color": "#F1A33C",
                  "plusPositions": {
                    "top": [],
                    "left": [
                      {
                        "id": "01",
                        "templateType": "plus_icon"
                      }
                    ],
                    "right": [
                      {
                        "id": "01",
                        "templateType": "plus_icon"
                      }
                    ],
                    "bottom": [
                      {
                        "id": "01",
                        "templateType": "plus_icon"
                      }
                    ]
                  },
                  "height": 120,
                  "width": 120,
                  "shape": "circle",
                  "buttonId": "01",
                  "direction": "bottom",
                  "settings": null,
                  "component": null,
                  "children": []
                }
              ]
            }
          ]
        }
      ]
    }
  }
};