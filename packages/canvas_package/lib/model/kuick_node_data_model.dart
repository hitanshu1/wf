import 'dart:convert';

import 'package:canvas_package/kuick_canvas.dart';

KuickNodeData<T> nodeDataFromJson<T>(
    String str,
    T Function(dynamic json) fromJsonT,
    ) =>
    KuickNodeData<T>.fromJson(json.decode(str), fromJsonT);

String nodeDataToJson<T>(
    KuickNodeData<T> data,
    dynamic Function(T value) toJsonT,
    ) =>
    json.encode(data.toJson(toJsonT));

/// --------------------------------------------------------
/// KuickNodeData<T>
/// --------------------------------------------------------
class KuickNodeData<T> {
  List<KuickNode<T>>? nodes;

  KuickNodeData({this.nodes});

  factory KuickNodeData.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonT,
      ) =>
      KuickNodeData(
        nodes: json["nodes"] == null
            ? []
            : List<KuickNode<T>>.from(
          json["nodes"]!.map(
                (x) => KuickNode<T>.fromJson(x, fromJsonT),
          ),
        ),
      );

  Map<String, dynamic> toJson(dynamic Function(T value) toJsonT) => {
    "nodes": nodes == null
        ? []
        : List<dynamic>.from(
      nodes!.map((x) => x.toJson(toJsonT)),
    ),
  };
}

/// --------------------------------------------------------
/// KuickNode<T>
/// --------------------------------------------------------
class KuickNode<T> {
  String? id;
  String? type;
  KuickNodeShape? nodeShape;
  T? data;
  int? x;
  int? y;
  int? height;
  int? width;
  NodeOutputPosition? children;

  KuickNode({
    this.id,
    this.type,
    this.data,
    this.x,
    this.y,
    this.height,
    this.width,
    this.children,
    this.nodeShape = KuickNodeShape.rectangle,
  });

  factory KuickNode.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonT,
      ) =>
      KuickNode(
        id: json["id"],
        type: json["type"],
        data: json["data"] == null ? null : fromJsonT(json["data"]),
        nodeShape: json["nodeShape"] == null
            ? null
            : KuickNodeShape.values.firstWhere(
              (e) => e.name == json["nodeShape"],
        ),
        x: json["x"],
        y: json["y"],
        height: json["height"],
        width: json["width"],
        children: json["children"] == null || 
            (json["children"] is List && (json["children"] as List).isEmpty)
            ? null
            : NodeOutputPosition.fromJson(json["children"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson(dynamic Function(T value) toJsonT) => {
    "id": id,
    "type": type,
    "data": data == null ? null : toJsonT(data!),
    "nodeShape": nodeShape?.name,
    "x": x,
    "y": y,
    "height": height,
    "width": width,
    "children": children?.toJson(),
  };
}

class NodeOutputPosition {
  List<Bottom>? top;
  List<Bottom>? bottom;
  List<Bottom>? left;
  List<Bottom>? right;

  NodeOutputPosition({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  factory NodeOutputPosition.fromJson(Map<String, dynamic> json) => NodeOutputPosition(
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
  String? buttonId;
  String? serverId;

  Bottom({
    this.buttonId,
    this.serverId,
  });

  factory Bottom.fromJson(Map<String, dynamic> json) => Bottom(
    buttonId: json["buttonId"],
    serverId: json["serverId"],
  );

  Map<String, dynamic> toJson() => {
    "buttonId": buttonId,
    "serverId": serverId,
  };
}