import 'package:flutter/material.dart';
import 'package:story_app/common/common.dart';

class DetailStoryPage extends StatelessWidget {
  const DetailStoryPage({
    required this.id,
    super.key,
  });
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.storyOf('Bambang Pacul'),
        ),
      ),
      body: Column(
        children: [
          Image.network(
            'https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/event/dos:dicoding_developer_coaching_45_back_end_pengantar_ke_amazon_web_services_logo_180322090939.png',
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Bambang Pacul',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Text(
                      'January 29, 2023',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '''Lorem Ipsum sit dolored ispuwe weqsz sit dolored ispuwe weqsz sit dolored ispuwe weqsz Lorem Ipsum sit dolored ispuwe weqsz''',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}
