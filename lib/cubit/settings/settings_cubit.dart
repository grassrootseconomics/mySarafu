// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const InitialSettings());

  @override
  SettingsState fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, Object> toJson(SettingsState state) {
    return state.toJson();
  }

  void setDarkModel(bool value) {
    final newState = state.copyWith(darkMode: value);
    print(newState);
    emit(newState);
  }
}
