/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsMemesGen {
  const $AssetsMemesGen();

  /// File path: assets/memes/1.jpg
  AssetGenImage get a1 => const AssetGenImage('assets/memes/1.jpg');

  /// File path: assets/memes/10.jpg
  AssetGenImage get a10 => const AssetGenImage('assets/memes/10.jpg');

  /// File path: assets/memes/11.jpg
  AssetGenImage get a11 => const AssetGenImage('assets/memes/11.jpg');

  /// File path: assets/memes/12.jpg
  AssetGenImage get a12 => const AssetGenImage('assets/memes/12.jpg');

  /// File path: assets/memes/13.jpg
  AssetGenImage get a13 => const AssetGenImage('assets/memes/13.jpg');

  /// File path: assets/memes/14.jpg
  AssetGenImage get a14 => const AssetGenImage('assets/memes/14.jpg');

  /// File path: assets/memes/15.jpg
  AssetGenImage get a15 => const AssetGenImage('assets/memes/15.jpg');

  /// File path: assets/memes/16.jpg
  AssetGenImage get a16 => const AssetGenImage('assets/memes/16.jpg');

  /// File path: assets/memes/17.jpg
  AssetGenImage get a17 => const AssetGenImage('assets/memes/17.jpg');

  /// File path: assets/memes/18.jpg
  AssetGenImage get a18 => const AssetGenImage('assets/memes/18.jpg');

  /// File path: assets/memes/19.jpg
  AssetGenImage get a19 => const AssetGenImage('assets/memes/19.jpg');

  /// File path: assets/memes/2.jpg
  AssetGenImage get a2 => const AssetGenImage('assets/memes/2.jpg');

  /// File path: assets/memes/20.jpg
  AssetGenImage get a20 => const AssetGenImage('assets/memes/20.jpg');

  /// File path: assets/memes/21.jpg
  AssetGenImage get a21 => const AssetGenImage('assets/memes/21.jpg');

  /// File path: assets/memes/22.jpg
  AssetGenImage get a22 => const AssetGenImage('assets/memes/22.jpg');

  /// File path: assets/memes/23.jpg
  AssetGenImage get a23 => const AssetGenImage('assets/memes/23.jpg');

  /// File path: assets/memes/24.jpg
  AssetGenImage get a24 => const AssetGenImage('assets/memes/24.jpg');

  /// File path: assets/memes/25.jpg
  AssetGenImage get a25 => const AssetGenImage('assets/memes/25.jpg');

  /// File path: assets/memes/3.jpg
  AssetGenImage get a3 => const AssetGenImage('assets/memes/3.jpg');

  /// File path: assets/memes/4.jpg
  AssetGenImage get a4 => const AssetGenImage('assets/memes/4.jpg');

  /// File path: assets/memes/5.jpg
  AssetGenImage get a5 => const AssetGenImage('assets/memes/5.jpg');

  /// File path: assets/memes/6.jpg
  AssetGenImage get a6 => const AssetGenImage('assets/memes/6.jpg');

  /// File path: assets/memes/7.jpg
  AssetGenImage get a7 => const AssetGenImage('assets/memes/7.jpg');

  /// File path: assets/memes/8.jpg
  AssetGenImage get a8 => const AssetGenImage('assets/memes/8.jpg');

  /// File path: assets/memes/9.jpg
  AssetGenImage get a9 => const AssetGenImage('assets/memes/9.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
    a1,
    a10,
    a11,
    a12,
    a13,
    a14,
    a15,
    a16,
    a17,
    a18,
    a19,
    a2,
    a20,
    a21,
    a22,
    a23,
    a24,
    a25,
    a3,
    a4,
    a5,
    a6,
    a7,
    a8,
    a9,
  ];
}

class Assets {
  const Assets._();

  static const AssetGenImage appIcon = AssetGenImage('assets/app_icon.jpg');
  static const $AssetsMemesGen memes = $AssetsMemesGen();
  static const AssetGenImage splash = AssetGenImage('assets/splash.jpg');

  /// List of all assets
  static List<AssetGenImage> get values => [appIcon, splash];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
