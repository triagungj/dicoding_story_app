import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:story_app/data/api/auth_service.dart';
import 'package:story_app/data/api/story_service.dart';
import 'package:story_app/data/cubit/auth/login_cubit.dart';
import 'package:story_app/data/cubit/auth/register_cubit.dart';
import 'package:story_app/data/cubit/auth/user_token_cubit.dart';
import 'package:story_app/data/cubit/story/add_story_cubit.dart';
import 'package:story_app/data/cubit/story/detail_story_cubit.dart';
import 'package:story_app/data/cubit/story/list_story_cubit.dart';
import 'package:story_app/data/models/story_model.dart';
import 'package:story_app/ui/pages/add_story_page.dart';
import 'package:story_app/ui/pages/detail_story_page.dart';
import 'package:story_app/ui/pages/home_page.dart';
import 'package:story_app/ui/pages/login_page.dart';
import 'package:story_app/ui/pages/maps_detail_page.dart';
import 'package:story_app/ui/pages/register_page.dart';
import 'package:story_app/ui/widgets/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate<dynamic>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<dynamic> {
  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _navigatorKey;

  final userTokenCubit = UserTokenCubit();
  final loginCubit = LoginCubit(AuthService());
  final registerCubit = RegisterCubit(AuthService());
  final listStoryCubit = ListStoryCubit(StoryService());
  final addStoryCubit = AddStoryCubit(StoryService());
  final detailStoryCubit = DetailStoryCubit(StoryService());

  List<Page<dynamic>> historyStack = [];

  String? selectedStoryId;
  bool isLoggedIn = false;
  bool isRegister = false;
  bool isForm = false;
  bool isSetting = false;
  bool isMaps = false;

  final PagingController<int, StoryModel> _pagingController =
      PagingController(firstPageKey: 0);

  void onDirectRegister() {
    isRegister = true;
    notifyListeners();
  }

  void onRegisterSuccess() {
    isRegister = false;
    notifyListeners();
  }

  Future<void> onLoginSuccess(String key) async {
    await userTokenCubit.setUserToken(key);
  }

  void onLoggedInChanged() {
    isLoggedIn = true;
    notifyListeners();
  }

  void onLoggedOutChanged() {
    isLoggedIn = false;
    notifyListeners();
  }

  void onLogout() {
    userTokenCubit.removeUserToken();
  }

  void onAddStorySuccess() {
    _pagingController.refresh();
    isForm = false;
    notifyListeners();
  }

  List<Page<dynamic>> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginPage(
            loginCubit: loginCubit,
            onLoginSuccess: onLoginSuccess,
            onRegister: onDirectRegister,
          ),
        ),
        if (isRegister)
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterPage(
              registerCubit: registerCubit,
              onRegisterSuccess: onRegisterSuccess,
            ),
          ),
      ];

  List<Page<dynamic>> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey('HomePage'),
          child: HomePage(
            onLogout: onLogout,
            listStoryCubit: listStoryCubit,
            storyPagingController: _pagingController,
            onDirectAddStory: () {
              isForm = true;
              notifyListeners();
            },
            onCardTap: (id) {
              selectedStoryId = id;
              notifyListeners();
            },
            onSettingTap: () {
              isSetting = true;
              notifyListeners();
            },
          ),
        ),
        if (selectedStoryId != null)
          MaterialPage(
            key: ValueKey('DetailStoryPage-$selectedStoryId'),
            child: DetailStoryPage(
              id: selectedStoryId!,
              detailStoryCubit: detailStoryCubit,
              onMapsShow: () {
                isMaps = true;
                notifyListeners();
              },
            ),
          ),
        if (isForm)
          MaterialPage(
            key: const ValueKey('AddStoryPage'),
            child: AddStoryPage(
              addStoryCubit: addStoryCubit,
              onAddStorySuccess: onAddStorySuccess,
            ),
          ),
        if (selectedStoryId != null && isMaps)
          MaterialPage(
            key: ValueKey('MapsDetailPage-$selectedStoryId'),
            child: MapsDetailPage(
              id: selectedStoryId!,
              detailStoryCubit: detailStoryCubit,
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserTokenCubit>(
          create: (context) => userTokenCubit,
        ),
        BlocProvider<LoginCubit>(
          create: (context) => loginCubit,
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => registerCubit,
        ),
        BlocProvider<ListStoryCubit>(
          create: (context) => listStoryCubit,
        ),
        BlocProvider<AddStoryCubit>(
          create: (context) => addStoryCubit,
        ),
        BlocProvider<DetailStoryCubit>(
          create: (context) => detailStoryCubit,
        ),
      ],
      child: BlocConsumer<UserTokenCubit, UserTokenState>(
        listener: (context, state) {
          if (state is GetUserSuccess) {
            if (state.token != null) {
              onLoggedInChanged();
            } else {
              onLoggedOutChanged();
            }
          }

          if (state is RemoveTokenSuccess) {
            onLoggedOutChanged();
          }
          if (state is SaveTokenSuccess) {
            onLoggedInChanged();
          }
        },
        builder: (context, state) {
          if (state is UserTokenLoading) {
            return const SplashScreen();
          }

          return Navigator(
            key: navigatorKey,
            pages: historyStack,
            onPopPage: (route, result) {
              final didPop = route.didPop(result);
              if (!didPop) {
                return false;
              }

              if (isMaps) {
                isMaps = false;
              } else {
                selectedStoryId = null;
              }

              isRegister = false;
              isForm = false;
              isSetting = false;

              notifyListeners();

              return true;
            },
          );
        },
      ),
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(dynamic configuration) async {
    //
  }
}
