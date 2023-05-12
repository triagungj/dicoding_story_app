import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/api/auth_service.dart';
import 'package:story_app/data/cubit/auth/login_cubit.dart';
import 'package:story_app/data/cubit/auth/register_cubit.dart';
import 'package:story_app/data/cubit/auth/user_token_cubit.dart';
import 'package:story_app/ui/pages/add_story_page.dart';
import 'package:story_app/ui/pages/detail_story_page.dart';
import 'package:story_app/ui/pages/home_page.dart';
import 'package:story_app/ui/pages/login_page.dart';
import 'package:story_app/ui/pages/register_page.dart';
import 'package:story_app/ui/widgets/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate<dynamic>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<dynamic> {
  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _navigatorKey;

  final userTokenCubit = UserTokenCubit();
  final loginCubit = LoginCubit(AuthService());
  final registerCubit = RegisterCubit(AuthService());

  List<Page<dynamic>> historyStack = [];

  String? selectedStoryId;
  bool isLoggedIn = false;
  bool isRegister = false;
  bool isForm = false;
  bool isSetting = false;

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
            onDirectAddStory: () {
              isForm = true;
              notifyListeners();
            },
            onCardTap: (index) {
              selectedStoryId = '232d';
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
            ),
          ),
        if (isForm)
          const MaterialPage(
            key: ValueKey('AddStoryPage'),
            child: AddStoryPage(),
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
        BlocProvider(
          create: (context) => userTokenCubit,
          child: Container(),
        ),
        BlocProvider(
          create: (context) => loginCubit,
          child: Container(),
        ),
        BlocProvider(
          create: (context) => registerCubit,
          child: Container(),
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

              isRegister = false;
              selectedStoryId = null;
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
