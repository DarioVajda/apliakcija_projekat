import 'package:aplikacija_projekat/front_end/screens_navigation.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija_projekat/back_end/home_screen/home_screen_be.dart';
import 'package:aplikacija_projekat/front_end/universal_widgets/popup_options.dart';
import 'package:aplikacija_projekat/back_end/universal_functions/follow.dart';
import 'package:aplikacija_projekat/front_end/universal_widgets/profile_screen.dart';
import 'package:flutter/services.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskData data;
  final List<PopupButton> popupButtons = []; // ovi dugmici se pojave kad se klikne na 3 tacke u cosku

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            onPressed: () {
              // Funkcija koja prikazuje neke opcije
              _popUpPostOptions(context);
            },
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.more_vert, size: 20),
            splashRadius: 24,
          ) /// druge opcije
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        // prikazuje se profil osobe koja je postavila ovaj zadatak
                        pushProfileScreen(context);
                        // _fullScreenPrimer('Profile', context); - obrisati ovo
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(data.profilePicture),
                            Text(data.username),
                          ]
                      )
                  ), /// profilna, ime
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
                ],
              ),
            ), /// Sadrzaj
          ), /// kolona sa svim informacijama
          TextButton(
            child: const Text('accept task'),
            onPressed: () {
              NavigationFunctions.popFunctionStack.add(() => Navigator.pop(context));
              showModalBottomSheet(
                context: context,
                useRootNavigator: false,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return ConfirmationWidget(data: data);
                }
              );
            }
          )
        ],
      )
    );
  }
}
///_________________________________________________________________________________________
/// Confirmation widget in the modal bottom sheet:
class ConfirmationWidget extends StatefulWidget {
  final TaskData data;

  const ConfirmationWidget({Key? key, required this.data}) : super(key: key);

  @override
  _ConfirmationWidgetState createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  final messageTextController = TextEditingController();
  late final TextEditingController priceTextController;

  @override
  void initState() {
    super.initState();
    priceTextController = TextEditingController(text: '${widget.data.price}');
  }

  @override
  void dispose() {
    messageTextController.dispose();
    priceTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.6,
      maxChildSize: 0.9,
      initialChildSize: 0.8,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16)
          ),
          color: Colors.white
        ),
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text('Suggest a different price:'),
                TextFormField(
                  controller: priceTextController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{1,5}(\.[0-9]{0,2})?'))
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price (USD)'
                  ), // TODO change USD to the local currency in the label
                ),
                Text('Send a message to ${widget.data.username}:'),
                TextField(
                  controller: messageTextController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Message...'
                  )
                ),
                ElevatedButton(
                  onPressed: () async {
                    /// TODO navigate-uje do todo-liste i ispise nesto na ekran
                    NavigationFunctions.popFunctionStack[NavigationFunctions.popFunctionStack.length - 1].call();
                    NavigationFunctions.popFunctionStack[NavigationFunctions.popFunctionStack.length - 1].call();
                    NavigationFunctions.gotoScreen(2);
                  },
                  child: Text('Send offer to ${widget.data.username}'),
                  style: ButtonStyle(shadowColor: MaterialStateProperty.all<Color>(Colors.transparent))
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}





















