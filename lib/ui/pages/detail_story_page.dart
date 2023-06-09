import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/assets_path.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/data/cubit/story/detail_story_cubit.dart';
import 'package:story_app/data/providers/localization_provider.dart';

class DetailStoryPage extends StatefulWidget {
  const DetailStoryPage({
    required this.id,
    required this.detailStoryCubit,
    required this.onMapsShow,
    super.key,
  });

  final String id;
  final DetailStoryCubit detailStoryCubit;
  final void Function() onMapsShow;

  @override
  State<DetailStoryPage> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends State<DetailStoryPage> {
  Future<void> getData() async {
    await widget.detailStoryCubit.getDetailStory(widget.id);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.storyDetail,
        ),
      ),
      body: BlocBuilder<DetailStoryCubit, DetailStoryState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state is DetailStoryLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (state is DetailStoryFailure)
                detailStoryErrorWidget(context, state),
              if (state is DetailStorySuccess)
                Builder(
                  builder: (context) {
                    final locale =
                        Provider.of<LocalizationProvider>(context).locale;
                    final storyDateTime =
                        DateTime.parse(state.result.createdAt).toLocal();
                    final parsedDate =
                        DateFormat.yMMMMEEEEd(locale.languageCode).format(
                      storyDateTime,
                    );
                    return detailStoryContent(state, context, parsedDate);
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget detailStoryContent(
    DetailStorySuccess state,
    BuildContext context,
    String parsedDate,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            image: state.result.photoUrl,
            placeholder: AssetsPath.placeHodler,
            fit: BoxFit.cover,
            placeholderFit: BoxFit.cover,
            fadeInCurve: Curves.linear,
            fadeInDuration: const Duration(milliseconds: 250),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            state.result.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            parsedDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: widget.onMapsShow,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_pin),
                          Text(
                            AppLocalizations.of(context)!.showLocation,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  state.result.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding detailStoryErrorWidget(
    BuildContext context,
    DetailStoryFailure state,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.failedGetData,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: getData,
            child: Text(AppLocalizations.of(context)!.refresh),
          )
        ],
      ),
    );
  }
}
