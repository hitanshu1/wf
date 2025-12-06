import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart' show CacheManager, Config;
import 'package:flutter_svg/svg.dart';

import '../utils/app_logs.dart';

class AppImage extends StatelessWidget {
  final EdgeInsets margin;
  final double? width;
  final double? height;
  final String? imageUrl;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final BlendMode? blendMode;
  final String? placeholderAsset;
  final Alignment alignment;
  final ColorFilter? colorFilter;
  final Map<String, String>? httpHeaders;

  const AppImage(
      this.imageUrl, {
        super.key,
        this.margin = EdgeInsets.zero,
        this.width,
        this.height,
        this.fit = BoxFit.cover,
        this.borderRadius,
        this.color,
        this.blendMode,
        this.placeholderAsset,
        this.alignment = Alignment.center,
        this.colorFilter,
        this.httpHeaders,
      });

  //==============================================================================
  // ** Flutter Build Cycle **
  //==============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(borderRadius: borderRadius ?? BorderRadius.zero, child: _getImageType()),
    );
  }

  //==============================================================================
  // ** Widgets **
  //==============================================================================

  Widget _networkImage() {
    // String? networkUrl =
    //     imageUrl!.startsWith('/')
    //         ? "${EnvParams.instance.serverBase}/api2$imageUrl"
    //         : imageUrl;
    try {
      return CachedNetworkImage(
        alignment: alignment,
        color: color,
        colorBlendMode: blendMode,
        width: width,
        height: height,
        imageUrl: imageUrl ?? "",
        fit: fit,
        repeat: ImageRepeat.noRepeat,
        httpHeaders: httpHeaders,
        cacheManager: CacheManager(Config('pocketGiving')),
        errorWidget: (context, url, error) => _placeholderImage(),
      );
    } catch (e) {
      Log.i("Image Error: $e");
      return _placeholderImage();
    }
  }



  Widget _placeholderImage() {
    return Image.asset(
      placeholderAsset ?? "",
      width: width,
      height: height,
      fit: BoxFit.fitHeight,
      color: color,
      colorBlendMode: blendMode,
      alignment: alignment,
    );
  }

  Widget _assetImage() {
    return Image.asset(
      imageUrl ?? "",
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: blendMode,
      alignment: alignment,
    );
  }

  Widget _svgAssetImage() {
    return SvgPicture.asset(
      imageUrl ?? "",
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      color: color,
    );
  }



  Widget _svgNetworkImage() {
    // String? networkUrl =
    //     imageUrl!.startsWith('/')
    //         ? "${EnvParams.instance.serverBase}/api2$imageUrl"
    //         : imageUrl;
    return SvgPicture.network(
      imageUrl ?? "",
      width: width,
      height: height,
      fit: fit,
      colorFilter: colorFilter,
      alignment: alignment,
    );
  }

  Widget _fileImage() {
    return Image.file(
      File(imageUrl ?? ""),
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: blendMode,
      alignment: alignment,
    );
  }

  //============================================================
  // ** Helper Functions **
  //============================================================

  Widget _getImageType() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _placeholderImage();
    }
    if (imageUrl!.startsWith('assets') && imageUrl!.endsWith('svg')) {
      return _svgAssetImage();
    }
    if (imageUrl!.startsWith('http') && imageUrl!.endsWith('svg')) {
      return _svgNetworkImage();
    }
    if (imageUrl!.startsWith('/') && imageUrl!.endsWith('svg')) {
      return _svgNetworkImage();
    }
    if (imageUrl == null || imageUrl == "") {
      return _placeholderImage();
    }

    if (imageUrl!.startsWith('http') || imageUrl!.startsWith('/')) {
      return _networkImage();
    }
    if (imageUrl!.startsWith('assets')) {
      return _assetImage();
    }

    return _fileImage();
  }
}
