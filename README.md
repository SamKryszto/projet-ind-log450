# projet_ind_log450

## Info
Auteur: Samuel Krysztofiak
Cours: LOG-450-01
Chargé: Bilal Alchalabi

## Configuration
0. Avoir installé Flutter et Android Studio au préalable
1. Démarrer Android studio et utiliser l'AVD pour émuler un téléphone (testé sur Pixel 8 Pro)
2. Utiliser la commande flutter run en choisissant l'émulateur de téléphone
3. Jouer!

## Jeu
L'utilisation de l'application est très simple. Avec la page paramètres, on peut choisir la langue ainsi que télécharger un dictionaire personnalisé à partir d'un URL( L'implémentation du dictionaire personalisé n'est pas complète). Le changement de lange change tous les textes des boutons de l'application ainsi que le dictionnaire utilisé.

Voici ce qui ce passe quand on joue:
1. On clique sur jouer
2. La page s'affiche en choisissant un mot de départ et un mot de fin aléatoirement dans le dictionnaire selon la langue mise dans les paramètres. Le mot modifiable (milieu de l'écran) affiche le mot de départ
3. On rajoute une lettre au mot en cliquant sur le clavier en bas de l'écran. Cette lettre est rajoutée à la fin du mot modifiable. La lettre peut être déplacée en drag-and-drop entre les lettres du mot modifiable pour former un mot possible de la chaîne de mot. Quand le mot formé est accepté, la lettre bleue devient alors verte, et le clavier débloque la prochaine lettre.
4. On continue de la même façon jusqu'à atteindre le mot de fin. Si on réussit, un dialog nous propose de rejouer ou de revenir au menu principal. Si on échoue, on obtient un dialog similaire, mais avec un message différent.

## Notes

Mise à part le dictionnaire personnalisé, le reste de l'application est complètement fonctionnel!




