
class AppLocalizations {
  final String currentLanguage;

  AppLocalizations(this.currentLanguage);

  // Translations data
  static final Map<String, Map<String, String>> _localizedValues = {
    'play': {
      'en': 'Play',
      'fr': 'Jouer',
      // Add more translations
    },
    'settings': {
      'en': 'Settings',
      'fr': 'Paramètres',
      // Add more translations
    },
    'language': {
      'en': 'Language',
      'fr': 'Langue',
      // Add more translations
    },
    'import_dic': {
      'en': 'Enter URL for custom dictionary',
      'fr': 'Entrer le URL du dictionnaire personnalisé',
      // Add more translations
    },
    'congratulations_title': {
      'en': 'Congratulations!',
      'fr': 'Félicitations!',
      // Add more translations
    },
    'times_up_title': {
      'en': 'Time\'s up!',
      'fr': 'C\'est fini!',
      // Add more translations
    },
    'congratulations_description': {
      'en': 'Congratulations!',
      'fr': 'Félicitations!',
      // Add more translations
    },
    'times_up_description': {
      'en': 'Time\'s up!',
      'fr': 'C\'est fini!',
      // Add more translations
    },
    'next': {
      'en': 'Next',
      'fr': 'Prochain',
      // Add more translations
    },
    'restart': {
      'en': 'Restart',
      'fr': 'Recommencer',
      // Add more translations
    },
    'home': {
      'en': 'Home',
      'fr': 'Accueil',
      // Add more translations
    },
    'time remaining': {
      'en': 'Time remaining: ',
      'fr': 'Temps restant: ',
      // Add more translations
    },
    'remove': {
      'en': 'remove',
      'fr': 'enlever',
      // Add more translations
    },
    
    // Add more keys and translations
  };

  String translate(String key) {
    if (!_localizedValues.containsKey(key)) {
      print("Key not found: $key for language $currentLanguage");
      return 'Key not found';
    }
    if (!_localizedValues[key]!.containsKey(currentLanguage)) {
      print("Translation not found for language: $currentLanguage, key: $key");
      return 'Translation not found';
    }
    return _localizedValues[key]![currentLanguage]!;
  }
}