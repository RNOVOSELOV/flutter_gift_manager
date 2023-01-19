import 'package:equatable/equatable.dart';

class PaginationInfo extends Equatable {
  final bool canLoadMore;
  final int lastLoadedPage;

  const PaginationInfo({
    required this.canLoadMore,
    required this.lastLoadedPage,
  });

  factory PaginationInfo.initial() =>
      const PaginationInfo(canLoadMore: true, lastLoadedPage: 0);

  @override
  List<Object?> get props => [canLoadMore, lastLoadedPage];
}
