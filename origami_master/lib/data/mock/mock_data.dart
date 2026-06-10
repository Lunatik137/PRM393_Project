import '../../models/origami_model.dart';
import '../../models/origami_step.dart';
import '../../models/user_profile.dart';
import '../../models/user_creation.dart';
import '../../models/share_link.dart';
import '../../models/learning_progress.dart';

abstract final class MockData {
  MockData._();

  static const String currentUserId = 'user_001';

  static const UserProfile currentUserProfile = UserProfile(
    id: currentUserId,
    name: 'Hiroshi Sato',
    email: 'hiroshi.sato@origami.app',
    avatarPath: 'assets/images/avatars/user_001.png',
    completedFoldsCount: 15,
    publicCreationsCount: 8,
  );

  static final List<OrigamiModel> origamiModels = [
    OrigamiModel(
      id: 'origami_crane',
      name: 'Paper Crane',
      description:
          'The most iconic origami model, symbolizing peace and longevity.',
      category: 'Traditional',
      difficulty: 'Medium',
      estimatedMinutes: 10,
      imagePath: 'assets/images/origami/paper_crane.jpg',
      materials: ['Square paper'],
      steps: [
        OrigamiStep(
          id: 'step_crane_1',
          origamiId: 'origami_crane',
          stepNumber: 1,
          title: 'Initial Fold',
          description: 'Fold the paper in half diagonally to form a triangle.',
          imagePath: 'assets/images/tutorials/crane/step_01.webp',
          proTip: 'Ensure the edges line up perfectly.',
        ),
        OrigamiStep(
          id: 'step_crane_2',
          origamiId: 'origami_crane',
          stepNumber: 2,
          title: 'Square Base',
          description:
              'Fold again to create a smaller triangle, then open to form a square base.',
          imagePath: 'assets/images/tutorials/crane/step_02.webp',
        ),
        OrigamiStep(
          id: 'step_crane_3',
          origamiId: 'origami_crane',
          stepNumber: 3,
          title: 'Petal Fold',
          description: 'Fold the edges to the center crease.',
          imagePath: 'assets/images/tutorials/crane/step_03.webp',
        ),
        OrigamiStep(
          id: 'step_crane_4',
          origamiId: 'origami_crane',
          stepNumber: 4,
          title: 'Final Touches',
          description: 'Pull out the head and tail.',
          imagePath: 'assets/images/tutorials/crane/step_04.webp',
        ),
      ],
    ),
    OrigamiModel(
      id: 'origami_frog',
      name: 'Jumping Frog',
      description:
          'A fun, interactive model that actually jumps when you press its back.',
      category: 'Interactive',
      difficulty: 'Easy',
      estimatedMinutes: 5,
      imagePath: 'assets/images/origami/jumping_frog.webp',
      materials: ['Rectangular paper'],
      steps: [
        OrigamiStep(
          id: 'step_frog_1',
          origamiId: 'origami_frog',
          stepNumber: 1,
          title: 'Top Fold',
          description: 'Fold the top corners to the center line.',
          imagePath: 'assets/images/tutorials/frog_placeholder.png',
        ),
      ],
    ),
    OrigamiModel(
      id: 'origami_tulip',
      name: 'Tulip Flower',
      description: 'A simple yet elegant flower that looks great in a bouquet.',
      category: 'Flowers',
      difficulty: 'Easy',
      estimatedMinutes: 3,
      imagePath: 'assets/images/origami/tulip_flower.jpg',
      materials: ['Square paper', 'Green paper for stem'],
      steps: [
        OrigamiStep(
          id: 'step_tulip_1',
          origamiId: 'origami_tulip',
          stepNumber: 1,
          title: 'Petal Fold',
          description: 'Fold the bottom point up slightly off-center.',
          imagePath: 'assets/images/tutorials/tulip_placeholder.png',
        ),
      ],
    ),
    OrigamiModel(
      id: 'origami_lotus',
      name: 'Water Lotus',
      description: 'A beautiful multi-layered flower that requires patience.',
      category: 'Flowers',
      difficulty: 'Hard',
      estimatedMinutes: 20,
      imagePath: 'assets/images/origami/water_lotus.jpg',
      materials: ['Square paper'],
      steps: [
        OrigamiStep(
          id: 'step_lotus_1',
          origamiId: 'origami_lotus',
          stepNumber: 1,
          title: 'Blintz Fold',
          description: 'Fold all four corners to the center point.',
          imagePath: 'assets/images/tutorials/lotus_placeholder.png',
        ),
      ],
    ),
    OrigamiModel(
      id: 'origami_dragon',
      name: 'Ancient Dragon',
      description: 'An advanced model with intricate details and many steps.',
      category: 'Fantasy',
      difficulty: 'Expert',
      estimatedMinutes: 120,
      imagePath: 'assets/images/origami/ancient_dragon.jpg',
      materials: ['Large thin square paper'],
      steps: [
        OrigamiStep(
          id: 'step_dragon_1',
          origamiId: 'origami_dragon',
          stepNumber: 1,
          title: 'Pre-creasing',
          description:
              'Make a series of complex pre-creases across the entire sheet.',
          imagePath: 'assets/images/tutorials/dragon_placeholder.png',
        ),
      ],
    ),
  ];

  static final List<UserCreation> communityCreations = [
    UserCreation(
      id: 'creation_001',
      origamiId: 'origami_crane',
      foldName: 'Golden Crane',
      imagePath: 'assets/images/creations/community_crane_01.jpg',
      creatorId: 'user_002',
      creatorNickname: 'OrigamiMaster99',
      creatorAvatarPath: 'assets/images/avatars/user_002.png',
      completedAt: DateTime(2023, 10, 15),
      isPublic: true,
      description: 'Folded with special washi paper.',
    ),
    UserCreation(
      id: 'creation_002',
      origamiId: 'origami_crane',
      foldName: 'Peace Crane',
      imagePath: 'assets/images/creations/community_crane_02.jpg',
      creatorId: 'user_003',
      creatorNickname: 'PaperArtist',
      creatorAvatarPath: 'assets/images/avatars/user_003.png',
      completedAt: DateTime(2023, 10, 16),
      isPublic: true,
    ),
    UserCreation(
      id: 'creation_003',
      origamiId: 'origami_frog',
      foldName: 'Super Jumper',
      imagePath: 'assets/images/creations/creation_placeholder.jpg',
      creatorId: 'user_004',
      creatorNickname: 'FoldingFanatic',
      creatorAvatarPath: 'assets/images/avatars/user_004.png',
      completedAt: DateTime(2023, 10, 17),
      isPublic: true,
    ),
    UserCreation(
      id: 'creation_004',
      origamiId: 'origami_dragon',
      foldName: 'Red Wyvern',
      imagePath: 'assets/images/creations/creation_placeholder.jpg',
      creatorId: 'user_002',
      creatorNickname: 'OrigamiMaster99',
      creatorAvatarPath: 'assets/images/avatars/user_002.png',
      completedAt: DateTime(2023, 10, 18),
      isPublic: true,
    ),
  ];

  static final List<UserCreation> userGallery = [
    UserCreation(
      id: 'user_creation_001',
      origamiId: 'origami_crane',
      foldName: 'My First Crane',
      imagePath: 'assets/images/creations/my_crane.jpg',
      creatorId: currentUserId,
      creatorNickname: 'Hiroshi',
      creatorAvatarPath: 'assets/images/avatars/user_001.png',
      completedAt: DateTime(2023, 10, 10),
      isPublic: true,
      description: 'A bit messy but I am proud of it.',
    ),
    UserCreation(
      id: 'user_creation_002',
      origamiId: 'origami_tulip',
      foldName: 'Spring Tulip',
      imagePath: 'assets/images/creations/creation_placeholder.jpg',
      creatorId: currentUserId,
      creatorNickname: 'Hiroshi',
      creatorAvatarPath: 'assets/images/avatars/user_001.png',
      completedAt: DateTime(2023, 10, 12),
      isPublic: false,
    ),
    UserCreation(
      id: 'user_creation_003',
      origamiId: 'origami_lotus',
      foldName: 'Summer Lotus',
      imagePath: 'assets/images/creations/my_lotus.jpg',
      creatorId: currentUserId,
      creatorNickname: 'Hiroshi',
      creatorAvatarPath: 'assets/images/avatars/user_001.png',
      completedAt: DateTime(2023, 10, 14),
      isPublic: true,
    ),
  ];

  static final List<LearningProgress> learningProgress = [
    const LearningProgress(
      origamiId: 'origami_crane',
      currentStep: 2,
      totalSteps: 4,
      isCompleted: false,
    ),
    const LearningProgress(
      origamiId: 'origami_tulip',
      currentStep: 1,
      totalSteps: 1,
      isCompleted: true,
    ),
  ];

  static final List<ShareLink> shareLinks = [
    ShareLink(
      id: 'link_001',
      creationId: 'user_creation_001',
      token: 'active_token_abc',
      url: 'https://origami.master/share/active_token_abc',
      createdAt: DateTime(2023, 10, 20),
      isActive: true,
    ),
    ShareLink(
      id: 'link_002',
      creationId: 'user_creation_003',
      token: 'disabled_token_xyz',
      url: 'https://origami.master/share/disabled_token_xyz',
      createdAt: DateTime(2023, 10, 19),
      isActive: false,
    ),
  ];
}
