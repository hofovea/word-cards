import 'package:auto_route/auto_route.dart';
import 'package:word_cards/feats/cards/presentation/cards_screen/cards_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CardsRoute.page, initial: true),
  ];
}
