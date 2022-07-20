import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/providers/icon_select.dart';
//screen size of 300 to 380, default icon size works fine

class IconSelectorPanel extends StatelessWidget {
  const IconSelectorPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IconSelectionProvider(),
      builder: (context, child) => Consumer<IconSelectionProvider>(
        builder: (context, iconSelector, child) => Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Name & Icon',
                  style: TextStyle(fontSize: 18, color: Colors.white60),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 5),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white10,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Your name',
                        hintStyle: TextStyle(color: Colors.white30)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    tooltip: 'Random',
                    padding: const EdgeInsets.only(left: 10),
                    onPressed: () => iconSelector.randomize(),
                    icon: const Icon(Icons.casino),
                  ),
                  Opacity(
                    opacity: .7,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => iconSelector.previousIcon(),
                      icon: const Icon(Icons.skip_previous_rounded),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: iconSelector.currentIcon,
                  ),
                  Opacity(
                    opacity: .7,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => iconSelector.nextIcon(),
                      icon: const Icon(Icons.skip_next_rounded),
                    ),
                  ),
                  IconButton(
                      padding: const EdgeInsets.only(right: 10),
                      onPressed: () => iconSelector.changeColor(),
                      icon: const Icon(Icons.color_lens_rounded)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
