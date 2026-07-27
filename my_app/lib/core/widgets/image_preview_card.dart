import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
import 'cyber_card.dart';

/// Premium image preview card with upload state support.
class ImagePreviewCard extends StatelessWidget {
  const ImagePreviewCard({super.key, this.image, this.fileName, this.onRemove});

  final ImageProvider<Object>? image;
  final String? fileName;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: image == null
                  ? Container(
                      color: AppColors.surfaceSoft,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                    )
                  : Image(image: image!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            fileName ?? 'No image selected',
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            image == null
                ? 'Supported formats: JPG, JPEG, PNG, BMP, WEBP'
                : 'Preview generated and ready for classification.',
            style: AppTextStyles.caption,
          ),
          if (onRemove != null) ...[
            const SizedBox(height: AppSizes.md),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onRemove,
                icon: const Icon(Icons.close, size: AppSizes.iconSm),
                label: const Text('Remove'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}