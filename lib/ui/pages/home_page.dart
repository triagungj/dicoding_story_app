import 'package:flutter/material.dart';
import 'package:story_app/common/assets_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.onLogout,
    required this.onCardTap,
    required this.onDirectAddStory,
    required this.onSettingTap,
    super.key,
  });

  final void Function() onLogout;
  final void Function() onDirectAddStory;
  final void Function() onSettingTap;
  final void Function(int i) onCardTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dicoding Story',
        ),
        actions: [
          IconButton(
            onPressed: onSettingTap,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            5,
            (index) => Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  onCardTap(index);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 250,
                      child: FadeInImage.assetNetwork(
                        image:
                            'https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/original/event/dos:dicoding_developer_coaching_45_back_end_pengantar_ke_amazon_web_services_logo_180322090939.png',
                        placeholder: AssetsPath.placeHodler,
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.cover,
                        fadeInCurve: Curves.linear,
                        fadeInDuration: const Duration(milliseconds: 250),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Bambang Pacul',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '''Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum 'm Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum 'm Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum 'm Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum 'm Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum ''',
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '2022-01-08T06:34:18.598Z',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onDirectAddStory,
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
