import 'package:canvas_package/kuick_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kuick_workflow/src/core/utils/extensions/localization_extension.dart';
import 'package:kuick_workflow/src/core/utils/extensions/string_extensions.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/radius/radius.dart';
import '../../../../config/theme/space/edge.dart';
import '../../../../config/theme/space/gap.dart';
import '../../../../core/utils/color_converter.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/kuick_icon.dart';
import '../../data/models/local_models/node_config_model.dart';
import '../bloc/dashboard/dashboard_bloc.dart';
import '../bloc/dashboard/dashboard_event.dart';
import '../bloc/dashboard/dashboard_state.dart';

class RightSidebar extends StatefulWidget {
  const RightSidebar({super.key});

  @override
  State<RightSidebar> createState() => _RightSidebarState();
}

class _RightSidebarState extends State<RightSidebar> {
  // REALTIME width without lag
  final ValueNotifier<double> rightWidth = ValueNotifier(300);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // sync initial bloc width → notifier
    final blocWidth = context.read<DashboardBloc>().state.rightSidebarWidth;
    rightWidth.value = blocWidth;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final bloc = context.read<DashboardBloc>();
        final selectedNode = state.selectedNode;

        if (selectedNode == null) {
          return const SizedBox.shrink();
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Stack(
            key: ValueKey(selectedNode.id),
            children: [
              // REALTIME RESIZABLE PANEL
              ValueListenableBuilder<double>(
                valueListenable: rightWidth,
                builder: (context, width, _) {
                  return RepaintBoundary(
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: Border(
                          left: BorderSide(
                            color:
                                Theme.of(context).dividerColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: RepaintBoundary(
                        child: _RightPanelContent(
                          node: selectedNode,
                          onClose: () =>
                              bloc.add(SelectCanvasNode(node: null)),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // DRAG HANDLE
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeColumn,
                  child: GestureDetector(
                    onHorizontalDragStart: (_) =>
                        bloc.add(SetRightSidebarDragging(true)),

                    onHorizontalDragUpdate: (details) {
                      // CALCULATE NEW WIDTH
                      final newWidth =
                          (rightWidth.value - details.delta.dx).clamp(
                        DashboardState.minRightSidebarWidth,
                        DashboardState.maxRightSidebarWidth,
                      );

                      // REALTIME (NO LAG)
                      rightWidth.value = newWidth;

                      // SYNC BLOC (lightweight)
                      bloc.add(UpdateRightSidebarWidth(newWidth));
                    },

                    onHorizontalDragEnd: (_) =>
                        bloc.add(SetRightSidebarDragging(false)),

                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          width: 6,
                          color: Colors.transparent,
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              width: 2,
                              height: constraints.maxHeight,
                              color: state.isDraggingRightSidebar
                                  ? AppColor.blueHoverColor
                                  : AppColor.color1(context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RightPanelContent extends StatelessWidget {
  final Node<NodeConfigDataModel> node;
  final VoidCallback onClose;

  const _RightPanelContent({
    required this.node,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final data = node.data;
    final theme = Theme.of(context);
    final layoutWidth = data.width ?? node.size.value.width.toInt();
    final layoutHeight = data.height ?? node.size.value.height.toInt();
    final position = node.position.value;
    final plus = data.plusPositions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: edge.l16.t20.r16.b12,
          child: Row(
            children: [
              Expanded(child: context.l10n.project_inspector.asLabel(context)),
              IconButton(
                tooltip: 'Close',
                onPressed: onClose,
                icon: KuickIcon(Icons.close),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: edge.h16,
            children: [
              _NodeSummaryCard(
                title: data.title ?? context.l10n.project_inspector,
                subtitle: data.subtitle,
                color: data.color,
                shape: data.shape?.name ?? '-',
                icon: data.icon,
              ),
              gap.h20,
              _InfoSection(
                title: 'Node',
                items: [
                  _InfoTile(label: 'Title', value: data.title ?? '-'),
                  _InfoTile(label: 'Subtitle', value: data.subtitle ?? '-'),
                  _InfoTile(label: 'Shape', value: data.shape?.name ?? '-'),
                  _InfoTile(label: 'Color', value: data.color ?? '-'),
                ],
              ),
              gap.h20,
              _InfoSection(
                title: 'Layout',
                items: [
                  _InfoTile(label: 'Width', value: '$layoutWidth px'),
                  _InfoTile(label: 'Height', value: '$layoutHeight px'),
                  _InfoTile(
                    label: 'Position',
                    value:
                        '(${position.dx.toStringAsFixed(0)}, ${position.dy.toStringAsFixed(0)})',
                  ),
                ],
              ),
              if (plus != null) ...[
                gap.h20,
                _InfoSection(
                  title: 'Next steps',
                  items: [
                    _InfoTile(
                        label: 'Top options',
                        value: '${plus.top?.length ?? 0}'),
                    _InfoTile(
                        label: 'Bottom options',
                        value: '${plus.bottom?.length ?? 0}'),
                    _InfoTile(
                        label: 'Left options',
                        value: '${plus.left?.length ?? 0}'),
                    _InfoTile(
                        label: 'Right options',
                        value: '${plus.right?.length ?? 0}'),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final List<_InfoTile> items;

  const _InfoSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        gap.h10,
        ...items.map(
              (item) => Padding(
            padding: edge.b8,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.label,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ),
                ),
                Text(item.value,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoTile {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});
}

class _NodeSummaryCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? color;
  final String shape;
  final String? icon;

  const _NodeSummaryCard({
    required this.title,
    this.subtitle,
    this.color,
    required this.shape,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorValue = color != null ? HexColor.fromHex(color!) : null;

    return Card(
      margin: edge.x0,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: edge.x16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (colorValue ?? theme.colorScheme.primaryContainer)
                        .withOpacity(0.2),
                    borderRadius: radius.x12,
                  ),
                  child: icon != null && icon!.isNotEmpty
                      ? Center(child: AppImage(icon, height: 22))
                      : const KuickIcon(Icons.analytics_outlined, size: 22),
                ),
                gap.w10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title.asH2(context,size: 18),
                      if (subtitle != null && subtitle!.isNotEmpty)
                        subtitle!.asH3(context,size: 10),
                    ],
                  ),
                ),
                'Shape: $shape'.asH2(context,size: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
