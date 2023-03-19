// ignore_for_file: file_names

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:service/view/variables/icon_variables.dart';

import '../variables/colors_variable.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String? filePath;
  final bool isActive;
  final bool isEditable;
  final double? radius;
  final Color borderColor;
  final EdgeInsetsGeometry? margin;
  final void Function()? onEdit;
  const ProfileImageWidget({
    super.key,
    this.imageUrl,
    this.isActive = false,
    this.radius = 20.0,
    this.borderColor = CustomColors.grey,
    this.margin = const EdgeInsets.all(5.0),
    this.isEditable = false,
    this.onEdit,
    this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        width: radius! * 2,
        height: radius! * 2,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                shape: BoxShape.circle,
              ),
              child: filePath != null
                  ? Image.file(
                      File(filePath!),
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: imageUrl ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Container(
                        height: radius!,
                        width: radius!,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: const AssetImage(
                              CustomIcons.person,
                            ),
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.8),
                              BlendMode.modulate,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Icon(
                      //   Icons.person,
                      //   color: CustomColors.grey,
                      //   size: radius! * 0.9,
                      //   fill: 1,
                      // ),
                      fit: BoxFit.cover,
                    ),
            ),
            isActive
                ? Positioned(
                    bottom: radius! / 5,
                    right: radius! / 5,
                    child: Container(
                      height: radius! / 2,
                      width: radius! / 2,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: CustomColors.green),
                    ),
                  )
                : Container(),
            isEditable
                ? Positioned(
                    bottom: -10,
                    right: -12,
                    child: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: onEdit,
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: CustomColors.darkGrey,
                        )),
                  )
                : Container(),
          ],
        ));
  }
}
