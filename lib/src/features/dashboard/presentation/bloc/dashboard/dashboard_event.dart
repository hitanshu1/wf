import 'dart:ui';

import 'package:canvas_package/kuick_canvas.dart';

import '../../../../../core/utils/enums.dart';
import '../../../data/models/arg_models/create_node_arg_model.dart';
import '../../../data/models/arg_models/fetch_node_flow_arg_model.dart';
import '../../../data/models/local_models/node_config_model.dart';

abstract class DashboardEvent {}

class LoadDashboardData extends DashboardEvent {}

class UpdateSidebarWidth extends DashboardEvent {
  final double width;
  UpdateSidebarWidth(this.width);
}

class SetSidebarDragging extends DashboardEvent {
  final bool isDragging;
  SetSidebarDragging(this.isDragging);
}

class UpdateRightSidebarWidth extends DashboardEvent {
  final double width;
  UpdateRightSidebarWidth(this.width);
}

class SetRightSidebarDragging extends DashboardEvent {
  final bool isDragging;
  SetRightSidebarDragging(this.isDragging);
}

class SelectDashboardRoute extends DashboardEvent {
  final String routePath;
  SelectDashboardRoute(this.routePath);
}

class CreateNode extends DashboardEvent {
  final CreateNodeArgModel body;
  final Offset offset;
  final NodeConfigDataModel nodeConfig;
  final String widgetId;
  final String projectId;
  final PlusButtonPosition? plusButtonPosition;
  CreateNode( {required this.body,required this.offset,required this.nodeConfig,required this.widgetId,required this.projectId, this.plusButtonPosition});
}

class OnDragUpdate extends DashboardEvent {
  final Node<NodeConfigDataModel> node;
  final String widgetId;
  final String projectId;
  final String pageId;
  OnDragUpdate({required this.node,required this.widgetId,required this.projectId , required this.pageId});
}

class FetchNodeFlowDataEvent extends DashboardEvent {
  final FetchNodeFlowArgModel body;
  final String projectId;
  FetchNodeFlowDataEvent({required this.body,required this.projectId});
}

class OnCanvasDragging extends DashboardEvent {
  final bool isDragging;


  OnCanvasDragging({required this.isDragging});
}


class OnNodeDragging extends DashboardEvent {
  final bool isNodeDrag;


  OnNodeDragging({required this.isNodeDrag});
}

class SelectCanvasNode extends DashboardEvent {
  final Node<NodeConfigDataModel>? node;
  SelectCanvasNode({this.node});
}