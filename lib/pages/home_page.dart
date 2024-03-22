import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/navigation_bloc.dart';
import '../blocs/language_bloc.dart'; // Import LanguageBloc
import '../blocs/states/language_state.dart'; // Import LanguageState
import '../localizations/app_localizations.dart'; // Import AppLocalizations
import 'play_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder for LanguageBloc to rebuild when language changes
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        // Initialize localizations with the current language from LanguageBloc
        var localizations = AppLocalizations(languageState.currentLanguage);

        // Wrap the original BlocBuilder in another BlocBuilder or directly use the translated text
        return BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, navigationState) {
            // Assuming you only want to show this UI when in the 'home' state
            if (navigationState == NavigationState.home) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Colors.green, Colors.blue],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'WordLink', 
                          style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlayPage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 24.0),
                          ),
                        ),
                        child: Text(localizations.translate('play')), // Translated
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SettingsPage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 24.0),
                          ),
                        ),
                        child: Text(localizations.translate('settings')), // Translated
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Return an empty container if we're not in the home state.
              // Alternatively, handle other states if necessary.
              return Container();
            }
          },
        );
      },
    );
  }
}
