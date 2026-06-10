import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/data/mock/mock_data.dart';

void main() {
  group('MockData Business Rules Tests', () {
    test('Community creations must be public', () {
      for (final creation in MockData.communityCreations) {
        expect(
          creation.isPublic,
          isTrue,
          reason: 'Creation ${creation.id} should be public',
        );
      }
    });

    test('User gallery contains both public and private creations', () {
      final hasPublic = MockData.userGallery.any((c) => c.isPublic);
      final hasPrivate = MockData.userGallery.any((c) => !c.isPublic);

      expect(
        hasPublic,
        isTrue,
        reason: 'User gallery should have at least one public creation',
      );
      expect(
        hasPrivate,
        isTrue,
        reason: 'User gallery should have at least one private creation',
      );
    });

    test('At least one share link is active and at least one is disabled', () {
      final hasActive = MockData.shareLinks.any((l) => l.isActive);
      final hasDisabled = MockData.shareLinks.any((l) => !l.isActive);

      expect(
        hasActive,
        isTrue,
        reason: 'Should have at least one active share link',
      );
      expect(
        hasDisabled,
        isTrue,
        reason: 'Should have at least one disabled share link',
      );
    });

    test('Tutorial steps must belong to the correct origamiId', () {
      for (final model in MockData.origamiModels) {
        for (final step in model.steps) {
          expect(
            step.origamiId,
            equals(model.id),
            reason: 'Step ${step.id} has incorrect origamiId',
          );
        }
      }
    });

    test('Tutorial steps should be in correct order', () {
      for (final model in MockData.origamiModels) {
        if (model.steps.length > 1) {
          for (int i = 0; i < model.steps.length - 1; i++) {
            expect(
              model.steps[i].stepNumber,
              lessThan(model.steps[i + 1].stepNumber),
              reason:
                  'Steps in model ${model.id} are not ordered by stepNumber',
            );
          }
        }
      }
    });

    test('Community Gallery data must support filtering by origamiId', () {
      const targetId = 'origami_crane';
      final filtered = MockData.communityCreations
          .where((c) => c.origamiId == targetId)
          .toList();

      expect(
        filtered.isNotEmpty,
        isTrue,
        reason: 'Filtering by origamiId $targetId returned no results',
      );
      for (final creation in filtered) {
        expect(creation.origamiId, equals(targetId));
      }
    });

    test('Learning progress contains at least one unfinished item', () {
      final hasUnfinished = MockData.learningProgress.any(
        (p) => !p.isCompleted,
      );
      expect(
        hasUnfinished,
        isTrue,
        reason: 'Should have at least one unfinished learning progress item',
      );
    });

    test('All required sample origami models are present', () {
      final names = MockData.origamiModels.map((m) => m.name).toList();
      expect(names, contains('Paper Crane'));
      expect(names, contains('Jumping Frog'));
      expect(names, contains('Tulip Flower'));
      expect(names, contains('Water Lotus'));
      expect(names, contains('Ancient Dragon'));
    });
  });
}
