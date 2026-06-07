import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';

class SharedLinksScreen extends StatelessWidget {
  const SharedLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shared Links',
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.link),
            title: Text('Link to Creation $index'),
            subtitle: const Text('Expires in 3 days'),
            trailing: IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
