import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/utils/image_helper.dart';

/// Smart image widget that handles both network URLs and local assets.
/// Automatically detects the image type and renders appropriately.
class SmartImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const SmartImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Network image from Firebase Storage
    if (ImageHelper.isNetworkUrl(imageUrl)) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        // Loading placeholder
        placeholder: (context, url) {
          return placeholder ?? 
            Container(
              color: colorScheme.surfaceVariant,
              child: Center(
                child: CircularProgressIndicator(
                  color: colorScheme.primary,
                  strokeWidth: 2,
                ),
              ),
            );
        },
        // Error widget
        errorWidget: (context, url, error) {
          return errorWidget ?? 
            Container(
              color: colorScheme.surfaceVariant,
              child: Icon(
                Icons.broken_image,
                color: colorScheme.onSurfaceVariant,
                size: 48,
              ),
            );
        },
      );
    }
    
    // Local asset image
    return Image.asset(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? 
          Container(
            color: colorScheme.surfaceVariant,
            child: Icon(
              Icons.image_not_supported,
              color: colorScheme.onSurfaceVariant,
              size: 48,
            ),
          );
      },
    );
  }
}