import 'package:flutter/material.dart';
import 'package:story_app/ui/pages/add_story_page.dart';
import 'package:story_app/ui/pages/detail_story_page.dart';
import 'package:story_app/ui/pages/home_page.dart';
import 'package:story_app/ui/pages/login_page.dart';
import 'package:story_app/ui/pages/register_page.dart';

class MyRouterDelegate extends RouterDelegate<dynamic>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<dynamic> {
  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _navigatorKey;

  List<Page<dynamic>> historyStack = [];

  String? selectedStoryId;
  bool isLoggedIn = false;
  bool isRegister = false;
  bool isForm = false;
  bool isSetting = false;

  void onRegister() {
    isRegister = true;
    notifyListeners();
  }

  void onLogin() {
    isLoggedIn = true;
    notifyListeners();
  }

  void onLogout() {
    isLoggedIn = false;
    notifyListeners();
  }

  List<Page<dynamic>> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginPage(
            onLogin: onLogin,
            onRegister: onRegister,
          ),
        ),
        if (isRegister)
          const MaterialPage(
            key: ValueKey('RegisterPage'),
            child: RegisterPage(),
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
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(dynamic configuration) async {
    //
  }
}
