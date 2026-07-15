import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../network/api_client.dart';
import '../../models/origami_model.dart';

abstract class OrigamiRepository {
  Future<List<OrigamiModel>> searchOrigami({String? keyword, String? categoryId, int? difficulty, int pageNumber = 1, int pageSize = 20});
  Future<OrigamiModel> getOrigamiById(String id);
  Future<List<dynamic>> getCategories();
}

@Injectable(as: OrigamiRepository)
class OrigamiRepositoryImpl implements OrigamiRepository {
  final ApiClient _apiClient;

  OrigamiRepositoryImpl(this._apiClient);

  @override
  Future<List<OrigamiModel>> searchOrigami({String? keyword, String? categoryId, int? difficulty, int pageNumber = 1, int pageSize = 20}) async {
    try {
      final responseStr = await _apiClient.searchOrigami(keyword, categoryId, difficulty, pageNumber, pageSize);
      final json = jsonDecode(responseStr);
      final items = json['items'] as List<dynamic>;
      return items.map((e) => OrigamiModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch origami models: $e');
    }
  }

  @override
  Future<OrigamiModel> getOrigamiById(String id) async {
    try {
      final responseStr = await _apiClient.getOrigamiById(id);
      final json = jsonDecode(responseStr);
      return OrigamiModel.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch origami model details: $e');
    }
  }

  @override
  Future<List<dynamic>> getCategories() async {
    try {
      final responseStr = await _apiClient.getCategories();
      return jsonDecode(responseStr) as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
