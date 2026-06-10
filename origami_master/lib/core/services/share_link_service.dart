import 'dart:math';
import '../../data/mock/mock_data.dart';
import '../../models/share_link.dart';

class ShareLinkService {
  ShareLinkService._();
  static final ShareLinkService instance = ShareLinkService._();

  final List<ShareLink> _shareLinks = List.from(MockData.shareLinks);

  void reset() {
    _shareLinks.clear();
    _shareLinks.addAll(MockData.shareLinks);
  }

  Future<List<ShareLink>> getShareLinks() async {
    return List.unmodifiable(_shareLinks);
  }

  Future<ShareLink?> getShareLinkByToken(String token) async {
    try {
      return _shareLinks.firstWhere((link) => link.token == token);
    } catch (_) {
      return null;
    }
  }

  Future<List<ShareLink>> getShareLinksByCreationIds(
    Set<String> creationIds,
  ) async {
    return _shareLinks
        .where((link) => creationIds.contains(link.creationId))
        .toList();
  }

  Future<List<ShareLink>> getShareLinksByCreationId(String creationId) async {
    return _shareLinks.where((link) => link.creationId == creationId).toList();
  }

  Future<void> disableShareLink(String id) async {
    final index = _shareLinks.indexWhere((link) => link.id == id);
    if (index == -1) return;

    final old = _shareLinks[index];
    _shareLinks[index] = ShareLink(
      id: old.id,
      creationId: old.creationId,
      token: old.token,
      url: old.url,
      createdAt: old.createdAt,
      isActive: false,
    );
  }

  Future<ShareLink> generateShareLink(String creationId) async {
    final token = _generateUniqueToken();
    final now = DateTime.now();
    final newLink = ShareLink(
      id: 'link_${now.microsecondsSinceEpoch}_${_shareLinks.length}',
      creationId: creationId,
      token: token,
      url: 'https://origami.master/share/$token',
      createdAt: now,
      isActive: true,
    );
    _shareLinks.add(newLink);
    return newLink;
  }

  String _generateUniqueToken() {
    String token;
    do {
      token = _generateRandomToken();
    } while (_shareLinks.any((link) => link.token == token));
    return token;
  }

  String _generateRandomToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(12, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }
}
