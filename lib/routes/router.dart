import 'package:auto_route/auto_route.dart';
import '../pages/app_page.dart';
import '../pages/sign_in_page.dart';
import '../pages/root_page.dart';
import '../pages/navigation/home_page.dart';
import '../pages/navigation/market_page.dart';
import '../pages/navigation/chat_page.dart';
part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AppRoute.page, initial: false),
        AutoRoute(page: SignInRoute.page, path: '/sign-in'),
        AutoRoute(
          page: RootRoute.page,
          path: '/root',
          initial: true,
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home'),
            AutoRoute(page: ChatRoute.page, path: 'chat'),
            AutoRoute(page: MarketRoute.page, path: 'market'),
          ],
        ),
      ];
}
