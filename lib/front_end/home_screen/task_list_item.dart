import 'package:aplikacija_projekat/front_end/screens_navigation.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';
import 'package:aplikacija_projekat/front_end/universal_widgets/popup_options.dart';

///__________________________________________________________________________________
/// Single task widget
class SingleTask extends StatelessWidget {

  final TaskData data;
  final List<PopupButton> popupButtons = [];

  void _initPopupButtons() {
    popupButtons.clear();
    popupButtons.addAll([
      PopupButton(func: () => print('followed ${data.username}'), buttonName: 'follow @${data.username}'),
      PopupButton(func: () => print('saved post for later'), buttonName: 'save'),
      PopupButton(func: () => print('shared'), buttonName: 'share'),
    ]); /// kasnije cu trebati da pozovem sve redovne funkcije umesto da prosledjujem () => print(...)
  } /// inicijalizuje se lista popupButtons

  /// funkcija koja stvara popup opcije - ovo cu trebati da promenim
  void _popUpPostOptions(BuildContext context) {
    _initPopupButtons();
    showPopupOptions(context, popupButtons);
  }

  /// funkcija koja prikazuje neki string full screen
  /// ovo ce trebati da se promeni kad budem menjao te screen-ove
  void _fullScreenPrimer(String s) {
    NavigationFunctions.pushFullScreen(
      Scaffold(
        appBar: AppBar(title: Text(s)),
        body: Center(
          child: Text(s)
        ),
      )
    );
  }

  /// Konstruktor
  SingleTask({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trebacu da dodam style-ove svim tekstovima
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: GestureDetector(
        onTap: () {
          // otvara se profil osobe
          _fullScreenPrimer('Detail Screen');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        // otvara se detail screen ovog zadatka
                        _fullScreenPrimer('Profile');
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(data.profilePicture),
                            Text(data.username),
                          ]
                      )
                  ), /// profilna, ime
                  IconButton(
                    onPressed: () {
                      // Funkcija koja prikazuje neke opcije
                      _popUpPostOptions(context);
                    },
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.more_vert, size: 18),
                    splashRadius: 24,
                  ) /// more options
                ]
            ), /// profilna, ime, opcije
            Text(
              data.title,
              style: const TextStyle(fontSize: 30),
            ), /// naslov
            Text(
                '#${data.topic}',
                style: const TextStyle()
            ), /// tema zadatka
            /// slika:
            (data.image != null) ? Image(image: data.image!) : const SizedBox(height: 0, width: 0),
            Text(
                'Suggested price: \$${data.price}',
                style: const TextStyle()
            ), /// cena
            Text(
                data.taskType,
                style: const TextStyle()
            ), /// tip zadatka
            Text(
                'Due ${data.dueDate}',
                style: const TextStyle()
            ) /// trebace neka funkcija koja pretvara datum u string
          ],
        ),
      ), /// post na koji moze da se klikne
    ); /// podaci o post-u
  }
}
