import 'package:aplikacija_projekat/front_end/screens_navigation.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';

///__________________________________________________________________________________
/// Single task widget
class SingleTask extends StatelessWidget {

  final TaskData data;

  void _popUpPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => print('1'),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Button 1'),
              )
            ),
            TextButton(
              onPressed: () => print('2'),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Button 2'),
              )
            ),
            TextButton(
              onPressed: () => print('3'),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Button 3'),
              )
            )
          ],
        );
      }
    );
  }

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

  const SingleTask({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sve podatke su trebati da preuzmem iz backend-a
    // i trebacu da dodam style-ove svim tekstovima
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
                    ),
                    IconButton(
                      onPressed: () {
                        // Funkcija koja prikazuje neke opcije
                        _popUpPostOptions(context);
                      },
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.more_vert, size: 18),
                      splashRadius: 24,
                    )
                  ]
                ),
                Text(
                  data.title,
                  style: const TextStyle(fontSize: 30),
                ),
                Text(
                  '#${data.topic}',
                  style: const TextStyle()
                ),
                (data.image != null) ? Image(image: data.image!) : const SizedBox(height: 0, width: 0),
                Text(
                  'Suggested price: \$${data.price}',
                  style: const TextStyle()
                ),
                Text(
                  data.taskType,
                  style: const TextStyle()
                ),
                Text(
                  'Due ${data.dueDate}',
                  style: const TextStyle()
                ) // trebace neka funkcija koja pretvara datum u string
              ],
            ),
          )
        ],
      ),
    );
  }
}
