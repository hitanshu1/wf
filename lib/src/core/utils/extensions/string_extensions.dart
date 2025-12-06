import 'package:flutter/material.dart';
import 'package:kuick_workflow/src/config/theme/extensions/textstyle_extensions.dart';
import 'package:kuick_workflow/src/core/utils/extensions/context_extensions.dart';

extension StringTextExtensions on String {
  Text _asText(
    BuildContext context,
    TextStyle style, {
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      this,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: style,
    );
  }

  // Headings
  Text asH1(BuildContext context, {Color? color, TextAlign? align}) => _asText(
    context,
    context.h1.textColor(color ?? context.onPrimary).getSize(28).thin,
    align: align,
  );

  Text asH2(
    BuildContext context, {
    Color? color,
    double? size,
    TextAlign? align,
  }) => _asText(
    context,
    context.h2.textColor(color ?? context.onPrimary).getSize(size ?? 22),
    align: align,
  );

  Text asH3(
    BuildContext context, {
    Color? color,
    double? size,
    TextAlign? align,
  }) => _asText(
    context,
    context.h3.textColor(color ?? context.onPrimary).getSize(size ?? 18),
    align: align,
  );

  // Body and caption text
  Text asBody(
    BuildContext context, {
    Color? color,
    double? size,
    TextAlign? align,
  }) => _asText(
    context,
    context.body.textColor(color ?? context.onPrimary).getSize(size ?? 14),
    align: align,
  );

  Text asCaption(
    BuildContext context, {
    Color? color,
    double? size,
    TextAlign? align,
  }) => _asText(
    context,
    context.caption
        .textColor(color ?? context.colors.secondary)
        .getSize(size ?? 12),
    align: align,
  );

  Text asLabel(
    BuildContext context, {
    Color? color,
    double? size,
    TextAlign? align,
  }) => _asText(
    context,
    context.label.textColor(color ?? context.onPrimary).getSize(size ?? 10),
    align: align,
  );
}
