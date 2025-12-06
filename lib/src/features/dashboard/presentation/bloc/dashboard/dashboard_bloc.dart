import 'dart:async';
import 'dart:math';
import 'package:canvas_package/kuick_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/enums.dart';
import '../../../data/datasources/connection_orientation_storage.dart';
import '../../../data/models/arg_models/create_node_arg_model.dart';
import '../../../data/models/arg_models/fetch_node_flow_arg_model.dart';
import '../../../data/models/local_models/node_config_model.dart';
import '../../../data/models/response_models/fetch_node_data_response_model.dart'
    hide The1755356852766772;
import '../../../data/models/response_models/fatch_metadata_res_model.dart';
import '../../../data/models/workflow_model.dart' as workflow;
import '../../../domain/repositories/dashboard_repository.dart';
import '../../../domain/usecases/get_dashboard_data_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  GetDashboardDataUseCase useCase = GetDashboardDataUseCase(
    repository: sl.get<DashboardRepository>(),
  );
  CreateNodeDataUseCase createNodeUseCase = CreateNodeDataUseCase(
    repository: sl.get<DashboardRepository>(),
  );
  FetchNodeFlowDataUseCase fetchNodeFlowUseCase = FetchNodeFlowDataUseCase(
    repository: sl.get<DashboardRepository>(),
  );
  FetchMetaDataUseCase fetchMetaDataUseCase = FetchMetaDataUseCase(
    repository: sl.get<DashboardRepository>(),
  );
  var controller = NodeFlowController<NodeConfigDataModel>();
  List<KuickNode> data = [];
  final GlobalKey canvasKey = GlobalKey();

  DashboardBloc() : super(DashboardState.initial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<UpdateSidebarWidth>(_onUpdateSidebarWidth);
    on<SetSidebarDragging>(_onSetSidebarDragging);
    on<UpdateRightSidebarWidth>(_onUpdateRightSidebarWidth);
    on<SetRightSidebarDragging>(_onSetRightSidebarDragging);
    on<SelectDashboardRoute>(_onSelectDashboardRoute);
    on<CreateNode>(_onCreateNode);
    on<FetchNodeFlowDataEvent>(_onFetchNodeFlowData);
    on<OnDragUpdate>(_onDragUpdate);
    on<OnCanvasDragging>(_onCanvasDragging);
    on<OnNodeDragging>(_onNodeDragging);
    on<SelectCanvasNode>(_onSelectCanvasNode);
  }

  FutureOr<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final data = await useCase();
      emit(state.copyWith(isLoading: false, data: data, error: ''));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  FutureOr<void> _onUpdateSidebarWidth(
    UpdateSidebarWidth event,
    Emitter<DashboardState> emit,
  ) {
    final clamped = event.width.clamp(
      DashboardState.minSidebarWidth,
      DashboardState.maxSidebarWidth,
    );
    emit(state.copyWith(leftSidebarWidth: clamped.toDouble()));
  }

  FutureOr<void> _onSetSidebarDragging(
    SetSidebarDragging event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(isDraggingSidebar: event.isDragging));
  }

  FutureOr<void> _onUpdateRightSidebarWidth(
    UpdateRightSidebarWidth event,
    Emitter<DashboardState> emit,
  ) {
    final clamped = event.width.clamp(
      DashboardState.minRightSidebarWidth,
      DashboardState.maxRightSidebarWidth,
    );
    emit(state.copyWith(rightSidebarWidth: clamped.toDouble()));
  }

  FutureOr<void> _onSetRightSidebarDragging(
    SetRightSidebarDragging event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(isDraggingRightSidebar: event.isDragging));
  }

  FutureOr<void> _onSelectCanvasNode(
    SelectCanvasNode event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedNode: event.node));
  }

  FutureOr<void> _onSelectDashboardRoute(
    SelectDashboardRoute event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedRoutePath: event.routePath));
  }

  Future<void> _onCreateNode(
    CreateNode event,
    Emitter<DashboardState> emit,
  ) async {
    await createNodeUseCase
        .call(
          body: event.body.toJson(event.widgetId),
          projectId: event.projectId,
        )
        .then((value) {
          var newId = Random().nextInt(999999999).toString();
          var nodeSize = Size(
            (event.nodeConfig.width ?? 120).toDouble(),
            (event.nodeConfig.height ?? 120).toDouble(),
          );
          controller.addNode(
            Node<NodeConfigDataModel>(
              data: event.nodeConfig,
              type: event.nodeConfig.title ?? "",
              id: value.data?.serverId ?? "0",
              position: event.offset,
              nodeShape: event.nodeConfig.shape,
              size: nodeSize,
              inputPorts: [
                _createCenteredPort(
                  id: 'in_top',
                  position: PortPosition.top,
                  nodeSize: nodeSize,
                ),
                _createCenteredPort(
                  id: 'in_bottom',
                  position: PortPosition.bottom,
                  nodeSize: nodeSize,
                ),
                _createCenteredPort(
                  id: 'in_left',
                  position: PortPosition.left,
                  nodeSize: nodeSize,
                ),
                _createCenteredPort(
                  id: 'in_right',
                  position: PortPosition.right,
                  nodeSize: nodeSize,
                ),
              ],
              outputPorts: [
                _createCenteredPort(
                  id: 'out_top',
                  position: PortPosition.top,
                  nodeSize: nodeSize,
                  multiConnections: true,
                ),
                _createCenteredPort(
                  id: 'out_bottom',
                  position: PortPosition.bottom,
                  nodeSize: nodeSize,
                  multiConnections: true,
                ),
                _createCenteredPort(
                  id: 'out_left',
                  position: PortPosition.left,
                  nodeSize: nodeSize,
                  multiConnections: true,
                ),
                _createCenteredPort(
                  id: 'out_right',
                  position: PortPosition.right,
                  nodeSize: nodeSize,
                  multiConnections: true,
                ),
              ],
            ),
          );

          // Only create connection if there's a valid parent node ID
          final parentId = value.data?.serverParentId ?? "";
          if (parentId.isNotEmpty &&
              parentId != "0" &&
              event.plusButtonPosition != null) {
            try {
              // Determine port IDs and positions based on plus button position
              String parentOutputPort;
              String childInputPort;
              PortPosition parentOutputPosition;
              PortPosition childInputPosition;

              switch (event.plusButtonPosition!) {
                case PlusButtonPosition.top:
                  parentOutputPort = 'out_top';
                  childInputPort = 'in_bottom';
                  parentOutputPosition = PortPosition.top;
                  childInputPosition = PortPosition.bottom;
                  break;
                case PlusButtonPosition.bottom:
                  parentOutputPort = 'out_bottom';
                  childInputPort = 'in_top';
                  parentOutputPosition = PortPosition.bottom;
                  childInputPosition = PortPosition.top;
                  break;
                case PlusButtonPosition.left:
                  parentOutputPort = 'out_left';
                  childInputPort = 'in_right';
                  parentOutputPosition = PortPosition.left;
                  childInputPosition = PortPosition.right;
                  break;
                case PlusButtonPosition.right:
                  parentOutputPort = 'out_right';
                  childInputPort = 'in_left';
                  parentOutputPosition = PortPosition.right;
                  childInputPosition = PortPosition.left;
                  break;
              }

              // Ensure parent node has the required output port
              final parentNode = controller.getNode(parentId);
              if (parentNode != null) {
                final hasParentPort = parentNode.outputPorts.any(
                  (p) => p.id == parentOutputPort,
                );
                if (!hasParentPort) {
                  parentNode.addOutputPort(
                    _createCenteredPort(
                      id: parentOutputPort,
                      position: parentOutputPosition,
                      nodeSize: parentNode.size.value,
                      multiConnections: true,
                    ),
                  );
                }
              }

              controller.createConnection(
                parentId,
                parentOutputPort,
                value.data?.serverId ?? "0",
                childInputPort,
              );

              ConnectionOrientationStorage.save(
                parentId,
                value.data?.serverId ?? "0",
                event.plusButtonPosition!.name,
              );
            } catch (e) {
              // Connection might fail if parent node doesn't exist yet, ignore
              debugPrint('Failed to create connection: $e');
            }
          }

          emit(
            state.copyWith(
              createNodeRes: value,
              serverId: int.tryParse(value.data?.serverId ?? "0"),
              metaDataServerId: int.tryParse(
                value.data?.metadataServerId ?? "0",
              ),
              parentServerId: int.tryParse(value.data?.serverParentId ?? "0"),
            ),
          );

          final newNodeId = value.data?.serverId ?? "0";
          final newNode = controller.getNode(newNodeId);
          final pageId = event.body.inputData?.pageId ?? '';

          if (newNode != null && pageId.isNotEmpty) {
            Future.microtask(() {
              add(
                OnDragUpdate(
                  node: newNode,
                  widgetId: event.widgetId,
                  projectId: event.projectId,
                  pageId: pageId,
                ),
              );
            });
          }
        })
        .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
        });
  }

  Future<void> _onFetchNodeFlowData(
    FetchNodeFlowDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    controller = NodeFlowController<NodeConfigDataModel>();
    
    // Use sample data instead of API calls
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    // Create sample metadata
    final pageIdStr = event.body.inputData?.pageId ?? "1";
    final pageIdInt = int.tryParse(pageIdStr) ?? 1;
    
    final sampleMetaData = FetchMetaDataResponseModel(
      status: "success",
      msg: "Sample data",
      data: [
        FetchMetaData(
          serverId: 1,
          flowNodes: 3,
          flowId: "flow_1",
          projectId: 1,
          pageId: pageIdInt,
          widgetId: event.body.inputData?.widgetId ?? "1",
          title: "Sample Flow",
          trigger: "manual",
        ),
      ],
    );
    
    emit(
      state.copyWith(
        metaDataServerId: sampleMetaData.data?.first.serverId ?? 1,
      ),
    );
    
    // Create sample node flow data
    final sampleNodeFlowData = _createSampleNodeFlowData();
    var list = parseFlowToNodes(sampleNodeFlowData);
    
    emit(
      state.copyWith(
        flowList: list,
        serverId: int.tryParse(
          list.isNotEmpty
              ? list.last.id.toString()
              : state.serverId.toString(),
        ) ?? 1,
        isLoading: false,
      ),
    );
  }
  
  FetchNodeFlowResponseModel _createSampleNodeFlowData() {
    // Create sample PlusPositions using the workflow model structure
    final plusPos1 = workflow.PlusPositions(
      top: null,
      bottom: [workflow.Bottom(id: "btn_1", templateType: "action")],
      left: null,
      right: null,
    );
    
    final plusPos2 = workflow.PlusPositions(
      top: null,
      bottom: [workflow.Bottom(id: "btn_2", templateType: "action")],
      left: null,
      right: null,
    );
    
    return FetchNodeFlowResponseModel(
      status: "success",
      msg: "Sample data",
      data: FetchNodeFlowData(
        flowData: NodeFlowData(
          actions: [
            // Root node
            FetchNodeFlowAction(
              serverId: 1,
              id: 1,
              type: "trigger",
              label: "Start",
              subTitle: "Workflow starts here",
              position: FetchNodeFlowPosition(dx: 200, dy: 200),
              icon: "play_arrow",
              color: "#4CAF50",
              width: 200,
              height: 150,
              shape: KuickNodeShape.circle,
              plusPositions: plusPos1,
              children: FetchNodeFlowChildren(
                top: null,
                bottom: [
                  FetchNodeFlowAction(
                    serverId: 2,
                    serverParentId: 1,
                    id: 2,
                    buttonId: "btn_1",
                    direction: "bottom",
                    parentId: "1",
                    type: "action",
                    label: "Send Email",
                    subTitle: "Send notification email",
                    position: FetchNodeFlowPosition(dx: 200, dy: 400),
                    icon: "email",
                    color: "#2196F3",
                    width: 200,
                    height: 150,
                    shape: KuickNodeShape.rectangle,
                    plusPositions: plusPos2,
                    children: FetchNodeFlowChildren(
                      top: null,
                      bottom: [
                        FetchNodeFlowAction(
                          serverId: 3,
                          serverParentId: 2,
                          id: 3,
                          buttonId: "btn_2",
                          direction: "bottom",
                          parentId: "2",
                          type: "action",
                          label: "Save Data",
                          subTitle: "Store in database",
                          position: FetchNodeFlowPosition(dx: 200, dy: 600),
                          icon: "save",
                          color: "#FF9800",
                          width: 200,
                          height: 150,
                          shape: KuickNodeShape.rectangle,
                          plusPositions: null,
                          children: null,
                        ),
                      ],
                      left: null,
                      right: null,
                    ),
                  ),
                ],
                left: null,
                right: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Port _createCenteredPort({
    required String id,
    required PortPosition position,
    required Size nodeSize,
    bool multiConnections = false,
  }) {
    late Offset offset;
    switch (position) {
      case PortPosition.top:
      case PortPosition.bottom:
        offset = Offset(nodeSize.width / 2, 0);
        break;
      case PortPosition.left:
      case PortPosition.right:
        offset = Offset(0, nodeSize.height / 2);
        break;
    }

    return Port(
      id: id,
      name: id,
      position: position,
      offset: offset,
      multiConnections: multiConnections,
      isConnectable: true,
      showLabel: false,
    );
  }

  List<KuickNode<NodeConfigDataModel>> parseFlowToNodes(
      FetchNodeFlowResponseModel nodeRes,
      ) {
    final Map<String, KuickNode<NodeConfigDataModel>> nodesById = {};
    int _anonCounter = 0;

    String _makeNodeId(FetchNodeFlowAction action) {
      if (action.serverId != null) return action.serverId.toString();
      if (action.id != null) return "id_${action.id}";
      _anonCounter++;
      return "anon_$_anonCounter";
    }

    NodeOutputPosition _ensureOutputPosition(NodeOutputPosition? existing) {
      return NodeOutputPosition(
        top: existing?.top ?? <Bottom>[],
        bottom: existing?.bottom ?? <Bottom>[],
        left: existing?.left ?? <Bottom>[],
        right: existing?.right ?? <Bottom>[],
      );
    }

    List<Bottom> _listForDirection(
        NodeOutputPosition pos,
        String direction,
        ) {
      switch (direction) {
        case 'top':
          pos.top ??= <Bottom>[];
          return pos.top!;
        case 'left':
          pos.left ??= <Bottom>[];
          return pos.left!;
        case 'right':
          pos.right ??= <Bottom>[];
          return pos.right!;
        case 'bottom':
        default:
          pos.bottom ??= <Bottom>[];
          return pos.bottom!;
      }
    }

    // ---- main recursive builder ----
    void processAction(FetchNodeFlowAction action) {
      final nodeId = _makeNodeId(action);

      final dataParts = NodeConfigDataModel(
        title: action.label ?? "",
        subtitle: action.subTitle ?? "",
        shape: action.shape,
        height: action.height,
        width: action.width,
        plusPositions: action.plusPositions != null
            ? NodeConfigPlusPositions.fromJson(
                action.plusPositions!.toJson(),
              )
            : NodeConfigPlusPositions(
                top: null,
                bottom: null,
                left: null,
                right: null,
              ),
        icon: action.icon ?? "",
        color: action.color ?? "#2196F3",
      );

      void _clearPlusWhenConnected(
        List<FetchNodeFlowAction>? links,
        void Function(List<workflow.Bottom>?) setter,
      ) {
        if ((links?.isNotEmpty ?? false) && dataParts.plusPositions != null) {
          setter(<workflow.Bottom>[]);
        }
      }

      final childDirections = action.children;
      if (childDirections != null) {
        _clearPlusWhenConnected(
          childDirections.top,
          (v) => dataParts.plusPositions?.top = v,
        );
        _clearPlusWhenConnected(
          childDirections.bottom,
          (v) => dataParts.plusPositions?.bottom = v,
        );
        _clearPlusWhenConnected(
          childDirections.left,
          (v) => dataParts.plusPositions?.left = v,
        );
        _clearPlusWhenConnected(
          childDirections.right,
          (v) => dataParts.plusPositions?.right = v,
        );
      }

      final dx = action.position?.dx ?? 100;
      final dy = action.position?.dy ?? 100;

      KuickNode<NodeConfigDataModel> node;

      if (nodesById.containsKey(nodeId)) {
        node = nodesById[nodeId]!;
        node.data ??= dataParts;
        node.x ??= dx;
        node.y ??= dy;
        node.type ??= action.type;
        node.height ??= action.height;
        node.width ??= action.width;
        node.nodeShape ??= action.shape ?? KuickNodeShape.circle;
        node.children = _ensureOutputPosition(node.children);
      } else {
        node = KuickNode<NodeConfigDataModel>(
          id: nodeId,
          type: action.type,
          data: dataParts,
          x: dx,
          y: dy,
          nodeShape: action.shape ?? KuickNodeShape.circle,
          height: action.height,
          width: action.width,
          children: NodeOutputPosition(
            top: <Bottom>[],
            bottom: <Bottom>[],
            left: <Bottom>[],
            right: <Bottom>[],
          ),
        );
        nodesById[nodeId] = node;
      }

      final nodeOutputs = node.children!;
      final children = action.children;

      if (children == null) return;

      // local helper inside processAction → recursion is allowed
      void handleList(List<FetchNodeFlowAction>? list, String direction) {
        if (list == null) return;

        final outList = _listForDirection(nodeOutputs, direction);

        for (final child in list) {
          final childId = _makeNodeId(child);

          outList.add(
            Bottom(
              buttonId: child.buttonId ?? childId,
              serverId: child.serverId?.toString(),
            ),
          );

          // recursive call is fine here
          processAction(child);
        }
      }

      handleList(children.top, 'top');
      handleList(children.bottom, 'bottom');
      handleList(children.left, 'left');
      handleList(children.right, 'right');
    }

    final flowData = nodeRes.data?.flowData;

    if (flowData != null && flowData.actions != null) {
      final actions = flowData.actions!;

      // start only from roots (serverParentId == 0)
      for (final act in actions.where((a) => (a.serverParentId ?? 0) == 0)) {
        processAction(act);
      }
    }

    return nodesById.values.toList();
  }





  Future<void> _onDragUpdate(
      OnDragUpdate event,
      Emitter<DashboardState> emit,
      ) async {
    await fetchNodeFlowUseCase
        .call(
      body: FetchNodeFlowArgModel(
        inputData: FetchNodeInputData(
          pageId: event.pageId,
          serverId: state.metaDataServerId.toString(),
          widgetId: event.widgetId,
        ),
      ).toJson(),
      projectId: event.projectId,
    )
        .then((value) async {
      // Convert API response to nodes (using your new parser)
      var list = parseFlowToNodes(value); // List<KuickNode<NodeConfigDataModel>>
      bool _nodeHasChild(KuickNode<NodeConfigDataModel> node, String childId) {
        final children = node.children;
        if (children == null) return false;

        bool containsIn(List<Bottom>? list) {
          if (list == null) return false;
          return list.any(
                (b) => b.buttonId == childId || b.serverId == childId,
          );
        }

        return containsIn(children.top) ||
            containsIn(children.bottom) ||
            containsIn(children.left) ||
            containsIn(children.right);
      }

      // 🔹 Find parent node of the dragged node
      final parentNode = list.firstWhere(
            (e) => _nodeHasChild(e, event.node.id),
        orElse: () => KuickNode<NodeConfigDataModel>(),
      );

      final parentServerId = int.tryParse(parentNode.id ?? '0') ?? 0;

      var body = CreateNodeArgModel(
        inputData: CreateNodeArgInputData(
          pageId: event.pageId,
          workFlow: CreateNodeArgWorkFlow(
            the1755356852766772: The1755356852766772(
              metadata: CreateNodeArgMetadata(
                flowId: "untitled-flow",
                serverId: state.metaDataServerId,
                serverParentId: 0,
                trigger: "on chat",
                projectId: event.projectId,
                order: 0,
                pageId: event.pageId,
                widgetId: event.widgetId,
                title: "Main",
                parentId: null,
                selectedTrigger: null,
              ),
              flowData: CreateNodeArgFlowData(
                actions: [
                  CreateNodeArgAction(
                    id: int.tryParse(event.node.id) ?? 0,
                    serverId: int.tryParse(event.node.id) ?? 0,

                    // 🔹 NEW: use parentServerId resolved from canvas model
                    serverParentId: parentServerId,

                    order: int.tryParse(event.node.id) ?? 0,
                    parentId: 0,
                    type: "action",
                    position: CreateNodeArgPosition(
                      dx: (event.node.position.value.dx).toInt(),
                      dy: (event.node.position.value.dy).toInt(),
                    ),
                    label: event.node.data.title,
                    subTitle: event.node.data.subtitle,
                    width: event.node.data.width,
                    height: event.node.data.height,
                    shape: event.node.data.shape,
                    description: "",
                    color: event.node.data.color,
                    icon: event.node.data.icon,
                    plusPositions: workflow.PlusPositions.fromJson(
                      event.node.data.plusPositions?.toJson() ?? {},
                    ),
                    children: [],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await createNodeUseCase
          .call(
        body: body.toJson(event.widgetId),
        projectId: event.projectId,
      )
          .then((value) {})
          .onError((error, stackTrace) {
        print(error);
        print(stackTrace);
      });
    })
        .onError((error, stackTrace) {
      emit(state.copyWith(isLoading: false));
      print(error);
    });
  }

  FutureOr<void> _onCanvasDragging(OnCanvasDragging event, Emitter<DashboardState> emit) {
    emit(state.copyWith(isDragging: event.isDragging));
  }
  FutureOr<void> _onNodeDragging(OnNodeDragging event, Emitter<DashboardState> emit) {
    emit(state.copyWith(isNodeDrag: event.isNodeDrag));
    print('dkofjsdfjsdlfkjsdl ${event.isNodeDrag}');
  }
}
