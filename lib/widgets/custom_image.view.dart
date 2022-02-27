import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {this.imageUrl, this.height = Vx.dp40, this.width, this.boxFit, Key key})
      : super(key: key);

  final String imageUrl;
  final double height;
  final double width;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return this.imageUrl != null
        ? CachedNetworkImage(
            imageUrl: this.imageUrl,
            errorWidget: (context, imageUrl, _) => Image.asset(
              AppImages.appLogo,
              fit: this.boxFit ?? BoxFit.cover,
            ),
            fit: this.boxFit ?? BoxFit.cover,
            progressIndicatorBuilder: (context, imageURL, progress) =>
                BusyIndicator().centered(),
          ).h(this.height).w(this.width ?? context.percentWidth)
        : Image.asset(
            AppImages.appLogo,
            fit: this.boxFit ?? BoxFit.cover,
          ).h(this.height).w(this.width ?? context.percentWidth);
  }
}
