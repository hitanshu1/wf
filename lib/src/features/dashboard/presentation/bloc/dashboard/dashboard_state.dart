import 'package:canvas_package/kuick_canvas.dart';
import 'package:kuick_workflow/src/features/dashboard/data/models/local_models/node_config_model.dart';

import '../../../data/models/response_models/create_node_response_model.dart';
import '../../../domain/entities/dashboard_data.dart';

const _copyWithSentinel = Object();

class DashboardState {
  final bool isLoading;
  final DashboardData? data;
  final String? error;
  final double leftSidebarWidth;
  final bool isDraggingSidebar;
  final bool isDragging;
  final bool isNodeDrag;
  final double rightSidebarWidth;
  final bool isDraggingRightSidebar;
  final String? selectedRoutePath;
  final CreateNodeResponseModel? createNodeRes;
  final List<KuickNode<NodeConfigDataModel>>? flowList;
  final int parentServerId;
  final int serverId;
  final int metaDataServerId;
  final Node<NodeConfigDataModel>? selectedNode;

  static const double defaultSidebarWidth = 250.0;
  static const double minSidebarWidth = 150.0;
  static const double maxSidebarWidth = 500.0;
  static const double defaultRightSidebarWidth = 320.0;
  static const double minRightSidebarWidth = 200.0;
  static const double maxRightSidebarWidth = 520.0;

  const DashboardState(  {
    required this.isLoading,
    this.isDragging = false,
    this.isNodeDrag = false,
    required this.leftSidebarWidth,
    required this.isDraggingSidebar,
    required this.rightSidebarWidth,
    required this.isDraggingRightSidebar,
    this.flowList,
    this.parentServerId = 0, this.serverId = 0, this.metaDataServerId = 0,
    this.data,
    this.createNodeRes,
    this.error,
    this.selectedRoutePath,
    this.selectedNode,
  });

  factory DashboardState.initial() => const DashboardState(
        isLoading: false,
        leftSidebarWidth: defaultSidebarWidth,
        isDraggingSidebar: false,
        rightSidebarWidth: defaultRightSidebarWidth,
        isDraggingRightSidebar: false,
    createNodeRes: null,
    parentServerId: 0,
    serverId: 0,
    metaDataServerId: 0,
    flowList : null,
    selectedNode: null,
      );

  DashboardState copyWith({
    bool? isLoading,
    bool? isDragging ,
    bool? isNodeDrag ,
    DashboardData? data,
    String? error,
    double? leftSidebarWidth,
    bool? isDraggingSidebar,
    double? rightSidebarWidth,
    bool? isDraggingRightSidebar,
    String? selectedRoutePath,
    CreateNodeResponseModel? createNodeRes,
    int? parentServerId,
    int? serverId,
    List<KuickNode<NodeConfigDataModel>>? flowList,
    int? metaDataServerId,
    Object? selectedNode = _copyWithSentinel,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isDragging: isDragging ?? this.isDragging,
      isNodeDrag: isNodeDrag ?? this.isNodeDrag,
      data: data ?? this.data,
      error: error ?? this.error,
      leftSidebarWidth: leftSidebarWidth ?? this.leftSidebarWidth,
      isDraggingSidebar: isDraggingSidebar ?? this.isDraggingSidebar,
      rightSidebarWidth: rightSidebarWidth ?? this.rightSidebarWidth,
      isDraggingRightSidebar:
          isDraggingRightSidebar ?? this.isDraggingRightSidebar,
      selectedRoutePath: selectedRoutePath ?? this.selectedRoutePath,
      createNodeRes: createNodeRes ?? this.createNodeRes,
      parentServerId: parentServerId ?? this.parentServerId,
      serverId: serverId ?? this.serverId,
      metaDataServerId: metaDataServerId ?? this.metaDataServerId,
      flowList: flowList ?? this.flowList,
      selectedNode: identical(selectedNode, _copyWithSentinel)
          ? this.selectedNode
          : selectedNode as Node<NodeConfigDataModel>?,
    );
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasData => data != null;
}

class DashState {}

class DashboardInitialState extends DashState{}

class DashboardNodeFlowLoadingState extends DashState{}

class DashboardNodeFlowErrorState extends DashState{}

class DashboardNodeFlowLoadedState extends DashState{
  final CreateNodeResponseModel createNodeRes;
  final List<KuickNode> flowList;
  final int parentServerId;
  final int serverId;
  final int metaDataServerId;

  DashboardNodeFlowLoadedState({required this.createNodeRes, required this.flowList, required this.parentServerId, required this.serverId, required this.metaDataServerId});
}