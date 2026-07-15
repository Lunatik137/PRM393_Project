import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/learning_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../models/origami_model.dart';
import '../../../../models/origami_step.dart';
import '../../../../core/repositories/origami_repository.dart';
import '../../../../core/di/injection.dart';

class LearningStepScreen extends StatefulWidget {
  final String origamiId;

  const LearningStepScreen({super.key, required this.origamiId});

  @override
  State<LearningStepScreen> createState() => _LearningStepScreenState();
}

class _LearningStepScreenState extends State<LearningStepScreen> {
  late OrigamiModel _origami;
  int _currentStepIndex = 0;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOrigamiAndProgress();
  }

  Future<void> _loadOrigamiAndProgress() async {
    try {
      final repo = getIt<OrigamiRepository>();
      final model = await repo.getOrigamiById(widget.origamiId);
      
      // Sort steps by stepNumber
      final sortedSteps = List<OrigamiStep>.from(model.steps)
        ..sort((a, b) => a.stepNumber.compareTo(b.stepNumber));
      
      _origami = OrigamiModel(
        id: model.id,
        name: model.name,
        category: model.category,
        difficulty: model.difficulty,
        imagePath: model.imagePath,
        description: model.description,
        estimatedMinutes: model.estimatedMinutes,
        materials: model.materials,
        steps: sortedSteps,
      );

      final progress = await LearningService.instance.getProgress(widget.origamiId);

      if (mounted) {
        setState(() {
          if (progress != null && !progress.isCompleted && sortedSteps.isNotEmpty) {
            _currentStepIndex = (progress.currentStep - 1).clamp(0, sortedSteps.length - 1);
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }


  OrigamiStep get _currentStep => _origami.steps[_currentStepIndex];
  bool get _isFirstStep => _currentStepIndex == 0;
  bool get _isLastStep => _currentStepIndex == _origami.steps.length - 1;
  double get _progress => (_currentStepIndex + 1) / _origami.steps.length;

  Future<void> _saveProgress({bool isCompleted = false}) async {
    await LearningService.instance.saveProgress(
      origamiId: widget.origamiId,
      currentStep: _currentStepIndex + 1,
      totalSteps: _origami.steps.length,
      isCompleted: isCompleted,
    );
  }

  void _goToPrevious() {
    if (_isFirstStep) return;
    setState(() {
      _currentStepIndex--;
    });
    _saveProgress();
  }

  void _goToNext() {
    if (_isLastStep) {
      _finish();
    } else {
      setState(() {
        _currentStepIndex++;
      });
      _saveProgress();
    }
  }

  void _finish() {
    _saveProgress(isCompleted: true);
    // In a real app, we might create a UserCreation record here.
    // For now, we just navigate to result.
    context.pushReplacementNamed(
      RouteNames.completionResult,
      pathParameters: {'creationId': 'new_creation_${widget.origamiId}'},
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $_error')),
      );
    }

    if (_origami.steps.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('No steps available for this model.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Step ${_currentStepIndex + 1} of ${_origami.steps.length}',
          style: AppTextStyles.label,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: _progress,
            backgroundColor: AppColors.surfaceMuted,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instruction Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: _currentStep.imagePath.startsWith('http')
                      ? Image.network(
                          _currentStep.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.surfaceMuted,
                            child: const Icon(
                              Icons.image_outlined,
                              size: 64,
                              color: AppColors.textDisabled,
                            ),
                          ),
                        )
                      : Image.asset(
                          _currentStep.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.surfaceMuted,
                            child: const Icon(
                              Icons.image_outlined,
                              size: 64,
                              color: AppColors.textDisabled,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Step Title
              Text(_currentStep.title, style: AppTextStyles.titleLarge),
              const SizedBox(height: AppSpacing.md),

              // Step Description
              Text(_currentStep.description, style: AppTextStyles.body),
              const SizedBox(height: AppSpacing.xl),

              // Pro Tip Card
              if (_currentStep.proTip != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                    border: Border.all(
                      color: AppColors.info.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: AppColors.info,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pro Tip',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.info,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              _currentStep.proTip!,
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Previous',
                  onPressed: _isFirstStep ? null : _goToPrevious,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: PrimaryButton(
                  label: _isLastStep ? 'Finish' : 'Next',
                  onPressed: _goToNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
