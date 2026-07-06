/// Aggregated file type metric for analytics ranking widgets.
class FileTypeMetricEntity {
  /// Creates a file type metric.
  const FileTypeMetricEntity({
    required this.extension,
    required this.count,
    required this.ratio,
  });

  final String extension;
  final int count;
  final double ratio;
}
