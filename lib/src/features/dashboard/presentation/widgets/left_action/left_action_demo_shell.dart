import 'package:flutter/material.dart';

import '../../../../../config/theme/radius/radius.dart';
import '../../../../../config/theme/space/edge.dart';
import '../../../../../config/theme/space/gap.dart';
import '../../../../../core/widgets/kuick_icon.dart';

class LeftActionDemoScaffold extends StatelessWidget {
  final String title;
  final String description;
  final List<LeftActionHighlight> highlights;
  final Widget? trailingSection;

  const LeftActionDemoScaffold({
    super.key,
    required this.title,
    required this.description,
    required this.highlights,
    this.trailingSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:edge.l20.t16.r20.b8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gap.h10,
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: edge.x20,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: highlights
                      .map(
                        (item) => LeftActionHighlightCard(
                          label: item.label,
                          value: item.value,
                        ),
                      )
                      .toList(),
                ),
                if (trailingSection != null) ...[
                  gap.h25,
                  trailingSection!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeftActionHighlight {
  final String label;
  final String value;

  const LeftActionHighlight(this.label, this.value);
}

class LeftActionHighlightCard extends StatelessWidget {
  final String label;
  final String value;

  const LeftActionHighlightCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 180,
      padding: edge.x16,
      decoration: BoxDecoration(
        borderRadius: radius.x12,
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          gap.h5,
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class LeftActionDemoListSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const LeftActionDemoListSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        gap.h10,
        ...items.map(
          (item) => Padding(
            padding: edge.b10,
            child: Row(
              children: [
                KuickIcon(Icons.circle, size: 8),
                gap.w10,
                Expanded(child: Text(item, style: theme.textTheme.bodyMedium)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

