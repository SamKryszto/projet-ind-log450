import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_ind_log450/blocs/states/language_state.dart';
import 'blocs/navigation_bloc.dart'; // Correct the import path as necessary
import 'blocs/settings_bloc.dart'; // Correct the import path for SettingsBloc
import 'blocs/language_bloc.dart'; // Add the correct import path for LanguageBloc
import 'blocs/play_bloc.dart';
import 'pages/home_page.dart'; // Correct the import path as necessary

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        BlocProvider<SettingsBloc>(create: (context) => SettingsBloc()),
        BlocProvider<PlayBloc>(
          create: (context) => PlayBloc(),
        ),
        BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            home: HomePage(),
            locale: Locale(state.currentLanguage), // Update the locale based on the state
            // Ensure your localizations are configured to support the locales you need
          );
        },
      ),
    );
  }
}

