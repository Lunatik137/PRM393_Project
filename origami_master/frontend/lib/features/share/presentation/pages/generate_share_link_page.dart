import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/share_bloc.dart';
import '../bloc/share_event.dart';
import '../bloc/share_state.dart';

class GenerateShareLinkPage extends StatelessWidget {
  final String creationId;
  
  const GenerateShareLinkPage({super.key, required this.creationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShareBloc>()..add(GenerateShareLink(creationId)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocConsumer<ShareBloc, ShareState>(
          listener: (context, state) {
            if (state is ShareGeneratedSuccess) {
              context.pushReplacementNamed(RouteNames.sharedLinks);
            } else if (state is ShareError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
              );
              context.pop();
            }
          },
          builder: (context, state) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Generating Share Link...'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
