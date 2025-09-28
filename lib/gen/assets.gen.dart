/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Icon Interface Solid.png
  AssetGenImage get iconInterfaceSolid =>
      const AssetGenImage('assets/images/Icon Interface Solid.png');

  /// File path: assets/images/Icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/Icon.png');

  /// File path: assets/images/activity.svg
  String get activity => 'assets/images/activity.svg';

  /// File path: assets/images/airplane.svg
  String get airplane => 'assets/images/airplane.svg';

  /// File path: assets/images/briefcase-02.svg
  String get briefcase02 => 'assets/images/briefcase-02.svg';

  /// File path: assets/images/calendar.svg
  String get calendar => 'assets/images/calendar.svg';

  /// File path: assets/images/done-succesfly.png
  AssetGenImage get doneSuccesfly =>
      const AssetGenImage('assets/images/done-succesfly.png');

  /// File path: assets/images/filter.svg
  String get filter => 'assets/images/filter.svg';

  /// File path: assets/images/friends.svg
  String get friends => 'assets/images/friends.svg';

  /// File path: assets/images/heart.svg
  String get heart => 'assets/images/heart.svg';

  /// File path: assets/images/home-02.svg
  String get home02 => 'assets/images/home-02.svg';

  /// File path: assets/images/home-line.svg
  String get homeLine => 'assets/images/home-line.svg';

  /// File path: assets/images/house.svg
  String get house => 'assets/images/house.svg';

  /// File path: assets/images/love.svg
  String get love => 'assets/images/love.svg';

  /// File path: assets/images/other.svg
  String get other => 'assets/images/other.svg';

  /// File path: assets/images/people.svg
  String get people => 'assets/images/people.svg';

  /// File path: assets/images/profile.svg
  String get profile => 'assets/images/profile.svg';

  /// File path: assets/images/searsh.svg
  String get searsh => 'assets/images/searsh.svg';

  /// File path: assets/images/splaasg-bouttom-left.png
  AssetGenImage get splaasgBouttomLeft =>
      const AssetGenImage('assets/images/splaasg-bouttom-left.png');

  /// File path: assets/images/splash-top-right.png
  AssetGenImage get splashTopRight =>
      const AssetGenImage('assets/images/splash-top-right.png');

  /// File path: assets/images/trip.svg
  String get trip => 'assets/images/trip.svg';

  /// File path: assets/images/users-03.svg
  String get users03 => 'assets/images/users-03.svg';

  /// List of all assets
  List<dynamic> get values => [
        iconInterfaceSolid,
        icon,
        activity,
        airplane,
        briefcase02,
        calendar,
        doneSuccesfly,
        filter,
        friends,
        heart,
        home02,
        homeLine,
        house,
        love,
        other,
        people,
        profile,
        searsh,
        splaasgBouttomLeft,
        splashTopRight,
        trip,
        users03
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
