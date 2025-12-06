// To parse this JSON data, do
//
//     final fetchMetaDataResponseModel = fetchMetaDataResponseModelFromJson(jsonString);

import 'dart:convert';

FetchMetaDataResponseModel fetchMetaDataResponseModelFromJson(String str) => FetchMetaDataResponseModel.fromJson(json.decode(str));

String fetchMetaDataResponseModelToJson(FetchMetaDataResponseModel data) => json.encode(data.toJson());

class FetchMetaDataResponseModel {
  String? status;
  String? msg;
  List<FetchMetaData>? data;

  FetchMetaDataResponseModel({
    this.status,
    this.msg,
    this.data,
  });

  factory FetchMetaDataResponseModel.fromJson(Map<String, dynamic> json) => FetchMetaDataResponseModel(
    status: json["status"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<FetchMetaData>.from(json["data"]!.map((x) => FetchMetaData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FetchMetaData {
  int? flowNodes;
  int? serverId;
  String? flowId;
  int? projectId;
  int? pageId;
  String? widgetId;
  String? title;
  String? trigger;

  FetchMetaData({
    this.flowNodes,
    this.serverId,
    this.flowId,
    this.projectId,
    this.pageId,
    this.widgetId,
    this.title,
    this.trigger,
  });

  factory FetchMetaData.fromJson(Map<String, dynamic> json) => FetchMetaData(
    flowNodes: json["flowNodes"],
    serverId: json["serverId"],
    flowId: json["flowId"],
    projectId: json["projectId"],
    pageId: json["pageId"],
    widgetId: json["widgetId"],
    title: json["title"],
    trigger: json["trigger"],
  );

  Map<String, dynamic> toJson() => {
    "flowNodes": flowNodes,
    "serverId": serverId,
    "flowId": flowId,
    "projectId": projectId,
    "pageId": pageId,
    "widgetId": widgetId,
    "title": title,
    "trigger": trigger,
  };
}
