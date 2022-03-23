// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial());

  Future<void> changeRoute(int index) async {
    if (index == 0) {
      emit(NavState(bottomNavIndex: index, route: '/'));
    } else if (index == 1) {
      emit(NavState(bottomNavIndex: index, route: '/tokens'));
    } else if (index == 2) {
      emit(NavState(bottomNavIndex: index, route: '/settings'));
    }
  }
}
