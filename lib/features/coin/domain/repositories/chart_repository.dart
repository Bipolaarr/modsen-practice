// features/coin/domain/repositories/chart_repository.dart
abstract interface class ChartRepository {
  Future<List<Map<String, dynamic>>> getCoinChart(String id, int days);
}