import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/data/cubit/story/list_story_cubit.dart';
import 'package:story_app/data/models/list_story_body.dart';
import 'package:story_app/data/models/story_model.dart';
import 'package:story_app/ui/widgets/flag_icon_widget.dart';
import 'package:story_app/ui/widgets/story_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.onLogout,
    required this.onCardTap,
    required this.onDirectAddStory,
    required this.onSettingTap,
    required this.listStoryCubit,
    required this.storyPagingController,
    super.key,
  });
  final ListStoryCubit listStoryCubit;
  final void Function() onLogout;
  final void Function() onDirectAddStory;
  final void Function() onSettingTap;
  final void Function(String i) onCardTap;
  final PagingController<int, StoryModel> storyPagingController;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 20;

  final logoutDialogShow = ValueNotifier<bool>(false);

  int _pageKey = 0;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final paginationBody = ListStoryBody(pageKey, _pageSize);

      await widget.listStoryCubit.getListStory(paginationBody);
    } catch (error) {
      widget.storyPagingController.error = error;
    }
  }

  Future<void> _showLogoutDialog() async {
    logoutDialogShow.value = true;
  }

  @override
  void initState() {
    widget.storyPagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: logoutDialogShow,
      builder: (context, value, _) {
        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                _pageKey = 0;
                widget.storyPagingController.refresh();
              },
              child: BlocListener<ListStoryCubit, ListStoryState>(
                listener: (context, state) {
                  if (state is ListStorySuccess) {
                    final newItems = state.result.listStory ?? [];
                    final isLastPage = newItems.length < _pageSize;
                    if (isLastPage) {
                      widget.storyPagingController.appendLastPage(newItems);
                    } else {
                      final nextPageKey = _pageKey + 1;
                      widget.storyPagingController
                          .appendPage(newItems, nextPageKey);
                    }

                    _pageKey++;
                  }

                  if (state is ListStoryFailure) {
                    widget.storyPagingController.error = state.message;
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      AppLocalizations.of(context)!.appTitle,
                    ),
                    actions: [
                      const FlagIconWidget(),
                      IconButton(
                        onPressed: _showLogoutDialog,
                        icon: const Icon(Icons.logout),
                      )
                    ],
                  ),
                  body: PagedListView<int, StoryModel>(
                    pagingController: widget.storyPagingController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<StoryModel>(
                      itemBuilder: (context, item, index) {
                        return StoryCard(
                          story: item,
                          onTap: () => widget.onCardTap(item.id),
                        );
                      },
                    ),
                  ),
                  floatingActionButton: addStoryButton(),
                ),
              ),
            ),
            if (logoutDialogShow.value)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.5),
                child: Center(
                  child: Center(
                    child: logoutDialogContent(context),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  FloatingActionButton addStoryButton() {
    return FloatingActionButton(
      onPressed: widget.onDirectAddStory,
      child: const Icon(
        Icons.add,
        size: 32,
      ),
    );
  }

  Widget logoutDialogContent(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.outline,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            AppLocalizations.of(context)!.logoutAccount,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                ),
                onPressed: () {
                  logoutDialogShow.value = false;
                },
              ),
              TextButton(
                onPressed: () {
                  logoutDialogShow.value = false;
                  widget.onLogout();
                },
                child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
