import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_ind_log450/blocs/events/play_event.dart';
import 'package:projet_ind_log450/blocs/language_bloc.dart';
import 'package:projet_ind_log450/blocs/states/language_state.dart';
import '../pages/home_page.dart';
import '../pages/play_page.dart';
import '../blocs/play_bloc.dart'; // Import the PlayBloc
import '../localizations/app_localizations.dart'; // Import your localization class

class TimeUpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
      var localizations = AppLocalizations(languageState.currentLanguage);

      return AlertDialog(
        title: Text(localizations.translate('times_up_title')),
        content: Text(localizations.translate('times_up_description')),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                ),
                child: Text(
                  localizations.translate('home'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Dispatch an event to reset the game state
                  context.read<PlayBloc>().add(GameStartedEvent());

                  // Close the dialog
                  Navigator.of(context).pop();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => PlayPage()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                ),
                child: Text(
                  localizations.translate('restart'),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
