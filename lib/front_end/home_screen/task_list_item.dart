import 'package:aplikacija_projekat/front_end/screens_navigation.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';
import 'package:aplikacija_projekat/front_end/universal_widgets/popup_options.dart';
import 'package:aplikacija_projekat/back_end/universal_functions/follow.dart';
import 'package:aplikacija_projekat/front_end/home_screen/task_detail_screen.dart';
import 'package:aplikacija_projekat/front_end/universal_widgets/profile_screen.dart';

class SingleTask extends StatelessWidget {

  final TaskData data;
  final List<PopupButton> popupButtons = [];

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

  SingleTask({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trebacu da dodam style-ove svim tekstovima
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: GestureDetector(
        onTap: () {
          NavigationFunctions.pushFullScreen(TaskDetailScreen(data: data));
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
                        // prikazuje se profil osobe koja je postavila ovaj zadatak
                        pushProfileScreen(context);
                        // _fullScreenPrimer('Profile', context); - obrisati ovo
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
