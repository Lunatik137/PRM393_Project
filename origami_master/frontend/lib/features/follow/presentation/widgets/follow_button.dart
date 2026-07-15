import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../bloc/follow_bloc.dart';
import '../bloc/follow_event.dart';
import '../bloc/follow_state.dart';

import '../../../../../core/di/injection.dart';

class FollowButton extends StatefulWidget {
  final String userId;
  final bool initialIsFollowing;
  final double width;
  final double height;
  final VoidCallback? onFollowToggle;

  const FollowButton({
    super.key,
    required this.userId,
    required this.initialIsFollowing,
    this.width = double.infinity,
    this.height = 48,
    this.onFollowToggle,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool _isFollowing;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.initialIsFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FollowBloc>(),
      child: BlocListener<FollowBloc, FollowState>(
        listener: (context, state) {
          if (state is FollowingUser && state.targetUserId == widget.userId) {
            setState(() {
              _isFollowing = true;
              _isLoading = false;
            });
            widget.onFollowToggle?.call();
          } else if (state is UnfollowingUser && state.targetUserId == widget.userId) {
            setState(() {
              _isFollowing = false;
              _isLoading = false;
            });
            widget.onFollowToggle?.call();
          } else if (state is FollowLoaded || state is FollowError || state is FollowInitial) {
            if (mounted) setState(() => _isLoading = false);
          }
        },
        child: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      setState(() => _isLoading = true);
                      if (_isFollowing) {
                        context.read<FollowBloc>().add(UnfollowUserEvent(widget.userId));
                      } else {
                        context.read<FollowBloc>().add(FollowUserEvent(widget.userId));
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFollowing ? AppColors.surfaceMuted : AppColors.primary,
                foregroundColor: _isFollowing ? AppColors.textPrimary : AppColors.surface,
                minimumSize: Size(widget.width, widget.height),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.button,
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isFollowing ? 'Following' : 'Follow'),
            );
          },
        ),
      ),
    );
  }
}
