class GroupModel {
  final String icon;
  final String id;
  final String title;
  final String des;
  final List<WorkFlowModel> workFlowData;
  GroupModel({
    required this.icon,
    required this.id,
    required this.title,
    required this.des,
    required this.workFlowData,
  });
}

class WorkFlowModel{
  final String id;
  final String title;
  final String des;
  final String pageId;
  final String widgetId;

  WorkFlowModel({required this.id, required this.title, required this.des, required this.pageId, required this.widgetId});
}