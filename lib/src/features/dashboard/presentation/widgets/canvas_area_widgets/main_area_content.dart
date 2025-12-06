import 'dart:math';
import 'package:canvas_package/kuick_canvas.dart' hide Bottom;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kuick_workflow/src/features/dashboard/presentation/widgets/canvas_area_widgets/widgets/canvas_node.dart';
import '../../../../../core/utils/enums.dart';
import '../../../data/models/arg_models/create_node_arg_model.dart';
import '../../../data/models/arg_models/fetch_node_flow_arg_model.dart';
import '../../../data/models/local_models/node_config_model.dart';
import '../../../data/models/workflow_model.dart';
import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_event.dart';
import '../../bloc/dashboard/dashboard_state.dart';

class CanvasArea extends StatefulWidget {
  const CanvasArea({super.key});

  @override
  State<CanvasArea> createState() => _CanvasAreaState();
}

class _CanvasAreaState extends State<CanvasArea> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
    super.initState();
  }
  void _init() {
    final routerState = GoRouterState.of(context);
    final currentUri = routerState.uri;

    final existingParams = Map<String, String>.from(currentUri.queryParameters);
    if (existingParams['widgetId'] != null &&
        existingParams['pageId'] != null &&
        routerState.pathParameters['projectId'] != null) {
      context.read<DashboardBloc>().add(
        FetchNodeFlowDataEvent(
          body: FetchNodeFlowArgModel(
            inputData: FetchNodeInputData(
              pageId: existingParams['pageId'],
              serverId: context
                  .read<DashboardBloc>()
                  .state
                  .metaDataServerId
                  .toString(),
              widgetId: existingParams['widgetId'],
            ),
          ),
          projectId: routerState.pathParameters['projectId'] ?? "",
        ),
      );
    }
  }

  void _createNodeFromWorkflowChild(
    BuildContext context,
    DashboardBloc bloc,
    DashboardState state,
    WorkflowChild details,
    Offset world, {
    String? parentNodeId,
    PlusButtonPosition? plusButtonPosition,
    required String direction,
    required String buttonId,
  }) {
    var randomId = Random().nextInt(999999999);

    final routerState = GoRouterState.of(context);
    final currentUri = routerState.uri;
    var projectId = routerState.pathParameters;
    final existingParams = Map<String, String>.from(currentUri.queryParameters);

    final createNodePlusPositions = PlusPositions.fromJson(
      details.plusPositions.toJson(),
    );
    final nodePlusPositions = NodeConfigPlusPositions.fromJson(
      details.plusPositions.toJson(),
    );

    _disableConnectorButtonsForNewNode(
      plusButtonPosition,
      nodePlusPositions,
      createNodePlusPositions,
    );

    var body = CreateNodeArgModel(
      inputData: CreateNodeArgInputData(
        pageId: existingParams["pageId"],
        workFlow: CreateNodeArgWorkFlow(
          the1755356852766772: The1755356852766772(
            metadata: CreateNodeArgMetadata(
              flowId: "untitled-flow",
              serverId: state.metaDataServerId,
              serverParentId: 0,
              trigger: details.trigger,
              projectId: projectId["projectId"],
              order: 0,
              pageId: existingParams["pageId"],
              widgetId: existingParams["widgetId"],
              title: "Main",
              parentId: null,
              selectedTrigger: null,
            ),
            flowData: CreateNodeArgFlowData(
              actions: [
                CreateNodeArgAction(
                  id: randomId,
                  serverId: 0,
                  direction: direction,
                  buttonId: buttonId,
                  serverParentId: parentNodeId != null
                      ? int.tryParse(parentNodeId) ?? 0
                      : state.serverId,
                  order: randomId,
                  parentId: 0,
                  type: "action",
                  position: CreateNodeArgPosition(
                    dx: (world.dx).toInt(),
                    dy: (world.dy).toInt(),
                  ),
                  label: details.title,
                  subTitle: details.subtitle,
                  description: "",
                  color: details.color,
                  icon: details.icon,
                  plusPositions: createNodePlusPositions,
                  height: details.height,
                  width: details.width,
                  shape: details.shape,
                  children: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    var nodeConfig = NodeConfigDataModel(
      title: details.title,
      subtitle: details.subtitle,
      height: details.height,
      width: details.width,
      shape: details.shape,
      plusPositions: nodePlusPositions,
      icon: details.icon,
      color: details.color,
    );
    bloc.add(
      CreateNode(
        body: body,
        offset: world,
        nodeConfig: nodeConfig,
        widgetId: existingParams["widgetId"] ?? "",
        projectId: projectId["projectId"] ?? "",
        plusButtonPosition: plusButtonPosition,
      ),
    );
  }

  void _disableConnectorButtonsForNewNode(
    PlusButtonPosition? triggerPosition,
    NodeConfigPlusPositions? nodePositions,
    PlusPositions? argPositions,
  ) {
    if (triggerPosition == null) return;
    final targetSide = _oppositeSide(triggerPosition);

    void clearNodeList(List<Bottom>? data, void Function(List<Bottom>?) setter) {
      if (data?.isNotEmpty ?? false) {
        setter([]);
      }
    }

    void clearArgList(List<Bottom>? data, void Function(List<Bottom>?) setter) {
      if (data?.isNotEmpty ?? false) {
        setter([]);
      }
    }

    switch (targetSide) {
      case PlusButtonPosition.top:
        if (nodePositions != null) {
          clearNodeList(nodePositions.top, (v) => nodePositions.top = v);
        }
        if (argPositions != null) {
          clearArgList(argPositions.top, (v) => argPositions.top = v);
        }
        break;
      case PlusButtonPosition.bottom:
        if (nodePositions != null) {
          clearNodeList(nodePositions.bottom, (v) => nodePositions.bottom = v);
        }
        if (argPositions != null) {
          clearArgList(argPositions.bottom, (v) => argPositions.bottom = v);
        }
        break;
      case PlusButtonPosition.left:
        if (nodePositions != null) {
          clearNodeList(nodePositions.left, (v) => nodePositions.left = v);
        }
        if (argPositions != null) {
          clearArgList(argPositions.left, (v) => argPositions.left = v);
        }
        break;
      case PlusButtonPosition.right:
        if (nodePositions != null) {
          clearNodeList(nodePositions.right, (v) => nodePositions.right = v);
        }
        if (argPositions != null) {
          clearArgList(argPositions.right, (v) => argPositions.right = v);
        }
        break;
    }
  }

  PlusButtonPosition _oppositeSide(PlusButtonPosition position) {
    switch (position) {
      case PlusButtonPosition.top:
        return PlusButtonPosition.bottom;
      case PlusButtonPosition.bottom:
        return PlusButtonPosition.top;
      case PlusButtonPosition.left:
        return PlusButtonPosition.right;
      case PlusButtonPosition.right:
        return PlusButtonPosition.left;
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DashboardBloc>();
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Expanded(
          child: DragTarget<WorkflowChild>(
            onAcceptWithDetails: (details) {
              final renderBox =
                  bloc.canvasKey.currentContext?.findRenderObject()
                      as RenderBox?;
              if (renderBox == null) return;
              final localPos = renderBox.globalToLocal(details.offset);
              final world = bloc.controller.screenToWorld(localPos);

              _createNodeFromWorkflowChild(
                context,
                bloc,
                state,
                details.data,
                world,
                buttonId: "",
                direction: "",
              );
            },
            builder: (context, candidate, rejected) {
              if (state.isLoading) {
                return Center(child: Text("Loading..."));
              }
              return KuickCanvas<NodeConfigDataModel>(

                cursorStyle: state.isDragging ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
                onCanvasDraggingChanged: (isDragging) {
                  if (state.isDragging != isDragging) {
                    bloc.add(OnCanvasDragging(isDragging: isDragging));
                  }
                },
                key: bloc.canvasKey,
                controller: bloc.controller,
                gridSize: 1,
                initialNodes: state.flowList ?? [],
                portSize: 0,
                nodeBuilder: (context, node) {
                  if (node.isDragging) {
                    final routerState = GoRouterState.of(context);
                    final currentUri = routerState.uri;

                    final existingParams = Map<String, String>.from(
                      currentUri.queryParameters,
                    );
                    Future.delayed(Duration(seconds: 3)).then((value) {
                      bloc.add(
                        OnDragUpdate(
                          node: node,
                          widgetId: existingParams['widgetId'] ?? "",
                          projectId: routerState.pathParameters['projectId'] ?? "",
                          pageId: existingParams['pageId'] ?? "",
                        ),
                      );
                    });
                  }
                  return MouseRegion(
                    cursor:state.isNodeDrag == true?SystemMouseCursors.grabbing: SystemMouseCursors.click,

                    child: GestureDetector(
                      onTap: () {
                        bloc.add(SelectCanvasNode(node: node));
                      },
                      onPanStart: (details) {
                        bloc.add(OnNodeDragging(isNodeDrag: true));

                      },
                      onPanEnd: (details) {
                        bloc.add(OnNodeDragging(isNodeDrag: false));
                      },
                      child: CanvasNode(
                        item: node,
                        isSelected: state.selectedNode?.id == node.id,
                        onNextStepSelected: (workflowChild, position, parentNodeId, direction, buttonId) {
                          final nodePosition = node.position.value;
                          final nodeSize = node.size.value;
                          var newNodeSize = Size(
                            workflowChild.width.toDouble(),
                            workflowChild.height.toDouble(),
                          );
                          const spacing = 50.0; // Gap between nodes

                          Offset newWorldPosition;
                          switch (position) {
                            case PlusButtonPosition.top:
                              newWorldPosition = Offset(
                                nodePosition.dx,
                                nodePosition.dy - newNodeSize.height - spacing,
                              );
                              break;
                            case PlusButtonPosition.bottom:
                              newWorldPosition = Offset(
                                nodePosition.dx,
                                nodePosition.dy + nodeSize.height + spacing,
                              );
                              break;
                            case PlusButtonPosition.left:

                              newWorldPosition = Offset(
                                nodePosition.dx - newNodeSize.width - spacing,
                                nodePosition.dy,
                              );
                              break;
                            case PlusButtonPosition.right:
                              newWorldPosition = Offset(
                                nodePosition.dx + nodeSize.width + spacing,
                                nodePosition.dy,
                              );
                              break;
                          }

                          _createNodeFromWorkflowChild(
                            context,
                            bloc,
                            state,
                            workflowChild,
                            newWorldPosition,
                            parentNodeId: parentNodeId,
                            plusButtonPosition: position,
                            direction: direction,
                            buttonId: buttonId,
                          );
                        },
                      ),
                    ),
                  );
                },
                theme: Theme.of(context).brightness == Brightness.dark
                    ? NodeFlowTheme.dark
                    : NodeFlowTheme.light,
              );
            },
          ),
        );
      },
    );
  }
}
