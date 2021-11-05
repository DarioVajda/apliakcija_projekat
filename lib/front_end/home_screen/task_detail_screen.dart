/// TODO - napraviti citav plan za aplikciju
//  cuvanje profila, postavljenih zadataka i svega ostalog
//  (otprilike smisliti strukturu baze podataka)
/// TODO - treba u klasi NavigationFunctions (???) override-ovati sta se desava kad se pritisne dugme unazad
//  (ovde pricam o onom dugmetu koje je ugradjeno u OS, da li bukvalno dugme ili prevlacenje, svejedno)
///___________________________________________________________________________________________
/// TODO - ovo je fajl u kojem cu napraviti screen koji se pojavljuje kad se klikne na zadatak

import 'package:flutter/material.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';
import 'package:aplikacija_projekat/front_end/universal_widgets/popup_options.dart';
import 'package:aplikacija_projekat/back_end/universal_functions/follow.dart';
import 'package:aplikacija_projekat/front_end/screens_navigation.dart';


class TaskDetailScreen extends StatelessWidget {
  final TaskData data;
  final List<PopupButton> popupButtons = [];

  TaskDetailScreen({Key? key, required this.data}) : super(key: key);

  void _initPopupButtons() {
    popupButtons.clear();
    popupButtons.addAll([
      PopupButton(
          func: () => follow(followedPerson: data.username, follower: '@your_username'),
          buttonName: 'follow @${data.username}'
      ),
      PopupButton(func: () => print('saved post for later'), buttonName: 'save'),
      PopupButton(func: () => print('shared'), buttonName: 'share'),
    ]); // kasnije cu trebati da pozovem sve redovne funkcije umesto da prosledjujem () => print(...)
  } // inicijalizuje se lista popupButtons

  // funkcija koja stvara popup opcije - ovo cu trebati da promenim
  void _popUpPostOptions(BuildContext context) {
    _initPopupButtons();
    showPopupOptions(context, popupButtons);
  }

  void _fullScreenPrimer(String s, BuildContext context) {
    NavigationFunctions.pushScreen(
      Scaffold(
        appBar: AppBar(title: Text(s)),
        body: Center(
            child: Text(s)
        ),
      ),
      context
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                        _fullScreenPrimer('Profile', context);
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
            Text(
              data.description * 5,
              style: const TextStyle()
            ), /// opis
            /// SLIKA:
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
            ), /// trebace neka funkcija koja pretvara datum u string
            /// dugme za prihvatanje zadatka
          ],
        ), /// Column sa svim widget-ovima
      ), /// Sadrzaj
    );
  }
}