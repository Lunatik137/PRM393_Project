import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/empty_state.dart';
import '../bloc/share_bloc.dart';
import '../bloc/share_event.dart';
import '../bloc/share_state.dart';
import '../widgets/share_link_card.dart';

class SharedLinksPage extends StatelessWidget {
  final String? source;
  final String? creationId;

  const SharedLinksPage({super.key, this.source, this.creationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShareBloc>()..add(LoadShareLinks()),
      child: const SharedLinksView(),
    );
  }
}

class SharedLinksView extends StatelessWidget {
  const SharedLinksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Shared Links'),
      body: BlocConsumer<ShareBloc, ShareState>(
        listener: (context, state) {
          if (state is ShareDeletedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share link deleted successfully')),
            );
          } else if (state is ShareToggledSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share link status updated')),
            );
          } else if (state is ShareError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
            );
          }
        },
        builder: (context, state) {
          if (state is ShareLoading || state is ShareInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ShareLinksLoaded) {
            if (state.links.isEmpty) {
              return const EmptyState(
                title: 'No shared links',
                message: 'Generate links to share your origami creations.',
                icon: Icons.link_off,
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ShareBloc>().add(LoadShareLinks());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.links.length,
                itemBuilder: (context, index) {
                  return ShareLinkCard(link: state.links[index]);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
