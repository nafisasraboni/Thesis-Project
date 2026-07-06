/// Aggregated scan count for a single day in the analytics trend view.
class ScanVolumeBucketEntity {
  /// Creates a scan volume bucket.
  const ScanVolumeBucketEntity({
    required this.label,
    required this.date,
    required this.count,
  });

  final String label;
  final DateTime date;
  final int count;
}
