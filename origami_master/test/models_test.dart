import 'package:flutter_test/flutter_test.dart';
import 'package:origami_master/models/origami_model.dart';
import 'package:origami_master/models/origami_step.dart';
import 'package:origami_master/models/user_profile.dart';
import 'package:origami_master/models/user_creation.dart';
import 'package:origami_master/models/share_link.dart';
import 'package:origami_master/models/learning_progress.dart';

void main() {
  group('Model Construction Tests', () {
    test('OrigamiStep construction', () {
      const step = OrigamiStep(
        id: 's1',
        origamiId: 'o1',
        stepNumber: 1,
        title: 'Step 1',
        description: 'Description 1',
        imagePath: 'path/1.png',
        proTip: 'Pro tip 1',
      );

      expect(step.id, 's1');
      expect(step.origamiId, 'o1');
      expect(step.stepNumber, 1);
      expect(step.title, 'Step 1');
      expect(step.description, 'Description 1');
      expect(step.imagePath, 'path/1.png');
      expect(step.proTip, 'Pro tip 1');
    });

    test('OrigamiModel construction', () {
      const step = OrigamiStep(
        id: 's1',
        origamiId: 'o1',
        stepNumber: 1,
        title: 'Step 1',
        description: 'Description 1',
        imagePath: 'path/1.png',
      );

      const model = OrigamiModel(
        id: 'o1',
        name: 'Crane',
        description: 'A classic crane',
        category: 'Birds',
        difficulty: 'Easy',
        estimatedMinutes: 5,
        imagePath: 'path/o1.png',
        materials: ['Paper'],
        steps: [step],
      );

      expect(model.id, 'o1');
      expect(model.name, 'Crane');
      expect(model.materials, contains('Paper'));
      expect(model.steps.length, 1);
      expect(model.steps.first, step);
    });

    test('UserProfile construction', () {
      const profile = UserProfile(
        id: 'u1',
        name: 'John Doe',
        email: 'john@example.com',
        avatarPath: 'avatar.png',
        completedFoldsCount: 10,
        publicCreationsCount: 5,
      );

      expect(profile.id, 'u1');
      expect(profile.name, 'John Doe');
      expect(profile.completedFoldsCount, 10);
      expect(profile.publicCreationsCount, 5);
    });

    test('UserCreation construction with defaults', () {
      final now = DateTime.now();
      final creation = UserCreation(
        id: 'c1',
        origamiId: 'o1',
        foldName: 'My Crane',
        imagePath: 'creation.png',
        creatorId: 'u1',
        creatorNickname: 'John',
        creatorAvatarPath: 'avatar.png',
        completedAt: now,
      );

      expect(creation.id, 'c1');
      expect(creation.isPublic, isFalse); // Default is Private
      expect(creation.completedAt, now);
      expect(creation.description, isNull);
    });

    test('ShareLink construction with defaults', () {
      final now = DateTime.now();
      final link = ShareLink(
        id: 'l1',
        creationId: 'c1',
        token: 'token123',
        url: 'https://origami.master/share/token123',
        createdAt: now,
      );

      expect(link.id, 'l1');
      expect(link.isActive, isTrue); // Default is active
      expect(link.createdAt, now);
    });

    test('LearningProgress construction', () {
      const progress = LearningProgress(
        origamiId: 'o1',
        currentStep: 2,
        totalSteps: 5,
        isCompleted: false,
      );

      expect(progress.origamiId, 'o1');
      expect(progress.currentStep, 2);
      expect(progress.totalSteps, 5);
      expect(progress.isCompleted, isFalse);
    });
  });

  group('Model Equality Tests', () {
    test('OrigamiStep equality', () {
      const step1 = OrigamiStep(
        id: 's1',
        origamiId: 'o1',
        stepNumber: 1,
        title: 'Step 1',
        description: 'Description 1',
        imagePath: 'path/1.png',
      );
      const step2 = OrigamiStep(
        id: 's1',
        origamiId: 'o1',
        stepNumber: 1,
        title: 'Step 1',
        description: 'Description 1',
        imagePath: 'path/1.png',
      );
      expect(step1, equals(step2));
    });

    test('OrigamiModel equality', () {
      const model1 = OrigamiModel(
        id: 'o1',
        name: 'Crane',
        description: 'A classic crane',
        category: 'Birds',
        difficulty: 'Easy',
        estimatedMinutes: 5,
        imagePath: 'path/o1.png',
        materials: ['Paper'],
        steps: [],
      );
      const model2 = OrigamiModel(
        id: 'o1',
        name: 'Crane',
        description: 'A classic crane',
        category: 'Birds',
        difficulty: 'Easy',
        estimatedMinutes: 5,
        imagePath: 'path/o1.png',
        materials: ['Paper'],
        steps: [],
      );
      expect(model1, equals(model2));
    });
  });
}
