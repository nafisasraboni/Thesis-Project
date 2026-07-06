/// Supported filters for persisted scan history.
enum HistoryFilter { all, safe, suspicious, malwareDetected }

extension HistoryFilterX on HistoryFilter {
  String get label {
    switch (this) {
      case HistoryFilter.all:
        return 'All';
      case HistoryFilter.safe:
        return 'Safe';
      case HistoryFilter.suspicious:
        return 'Suspicious';
      case HistoryFilter.malwareDetected:
        return 'Malware';
    }
  }

  String get predictionLabel {
    switch (this) {
      case HistoryFilter.all:
        return '';
      case HistoryFilter.safe:
        return 'Safe';
      case HistoryFilter.suspicious:
        return 'Suspicious';
      case HistoryFilter.malwareDetected:
        return 'Malware Detected';
    }
  }
}

/// Supported sorting options for persisted scan history.
enum HistorySortOption {
  mostRecent,
  oldestFirst,
  confidenceHighToLow,
  confidenceLowToHigh,
  nameAToZ,
  nameZToA,
}

extension HistorySortOptionX on HistorySortOption {
  String get label {
    switch (this) {
      case HistorySortOption.mostRecent:
        return 'Most Recent';
      case HistorySortOption.oldestFirst:
        return 'Oldest First';
      case HistorySortOption.confidenceHighToLow:
        return 'Confidence High-Low';
      case HistorySortOption.confidenceLowToHigh:
        return 'Confidence Low-High';
      case HistorySortOption.nameAToZ:
        return 'Name A-Z';
      case HistorySortOption.nameZToA:
        return 'Name Z-A';
    }
  }
}

/// Query object for history search, filtering, and sorting.
class HistoryQueryEntity {
  /// Creates a history query.
  const HistoryQueryEntity({
    this.searchTerm = '',
    this.filter = HistoryFilter.all,
    this.sortOption = HistorySortOption.mostRecent,
  });

  final String searchTerm;
  final HistoryFilter filter;
  final HistorySortOption sortOption;

  HistoryQueryEntity copyWith({
    String? searchTerm,
    HistoryFilter? filter,
    HistorySortOption? sortOption,
  }) {
    return HistoryQueryEntity(
      searchTerm: searchTerm ?? this.searchTerm,
      filter: filter ?? this.filter,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}
