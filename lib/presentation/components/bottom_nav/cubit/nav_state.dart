part of 'nav_cubit.dart';

@immutable
class NavState {
  const NavState({
    required this.route,
    required this.bottomNavIndex,
  });
  final String route;
  final int bottomNavIndex;
}

class NavInitial extends NavState {
  const NavInitial() : super(route: '/', bottomNavIndex: 0);
}
