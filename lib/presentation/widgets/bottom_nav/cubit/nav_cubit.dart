import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial());

  Future<void> changeRoute(int index) async {
    if (index == 0) {
      emit(NavState(bottomNavIndex: index, route: '/home'));
    } else if (index == 1) {
      emit(NavState(bottomNavIndex: index, route: '/tokens'));
    } else if (index == 2) {
      emit(NavState(bottomNavIndex: index, route: '/settings'));
    }
  }
}
