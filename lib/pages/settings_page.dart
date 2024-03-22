import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_ind_log450/blocs/language_bloc.dart';
import 'package:projet_ind_log450/blocs/events/settings_event.dart';
import 'package:projet_ind_log450/blocs/states/language_state.dart';
import '../blocs/settings_bloc.dart';
import '../blocs/events/language_event.dart';
import '../blocs/states/settings_state.dart';
import '../localizations/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        // Initialize localizations with the current language from LanguageBloc
        print(languageState.currentLanguage);
        var localizations = AppLocalizations(languageState.currentLanguage);
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.translate('settings')),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  // Extracts the selected language from the state
                  String selectedLanguage = (state is SettingsUpdated
                              ? state.selectedLanguage
                              : (state as SettingsInitial).selectedLanguage) ==
                          'fr'
                      ? 'French'
                      : 'English';
                  // Extracts the custom dictionary URI from the state, handling both possible state types
                  String customDictionaryUri = state is SettingsUpdated
                      ? state.customDictionaryUri
                      : (state as SettingsInitial).customDictionaryUri;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.translate('language'),
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0),
                      DropdownButton<String>(
                        value: selectedLanguage,
                        onChanged: (String? newValue) {
                          // Sets the language code based on the dropdown selection
                          String languageCode =
                              newValue == 'French' ? 'fr' : 'en';
                          BlocProvider.of<LanguageBloc>(context)
                              .add(LanguageChanged(languageCode: languageCode));
                          BlocProvider.of<SettingsBloc>(context)
                              .add(LanguageSelected(languageCode: languageCode));
                        },
                        items: <String>['English', 'French']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        localizations.translate('import_dic'),
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                          hintText: localizations.translate('import_dic'),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Sends an event to update the custom dictionary URI
                          BlocProvider.of<SettingsBloc>(context)
                              .add(CustomDictionaryUriChanged(newUri: value));
                        },
                        controller:
                            TextEditingController(text: customDictionaryUri),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }, // This closes the builder method of the first BlocBuilder
    ); // This closes the BlocBuilder<LanguageBloc, LanguageState>
  }
}
