/// TODO - ovo je fajl u kojem ce se nalaziti funkcija koja prikazuje pop-up opcije
/// funckija treba da ima argument listu funkcija i listu stringova koji ce se prikazati
/// takodje mozda mogu da dodam nesto kao "leading widget" da se nalazi na godnjem delu toga sto se prikaze
import 'package:flutter/material.dart';

class PopupButton {
  Function func;
  String buttonName;

  PopupButton({required this.func, required this.buttonName});
}

/// funkcija koja stvara po TextButton za svaki element u list buttons
void showPopupOptions(BuildContext context, List<PopupButton> buttons) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          buttons.length,
          (index) => TextButton(
            onPressed: () => buttons[index].func(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(buttons[index].buttonName),
            )
          )
        ),
      );
    }
  );
}
