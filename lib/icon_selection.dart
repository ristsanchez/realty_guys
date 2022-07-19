import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/providers/icon_select.dart';

class IconSelectorPanel extends StatelessWidget {
  const IconSelectorPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IconSelectionProvider(),
      builder: (context, child) => Consumer<IconSelectionProvider>(
        builder: (context, iconSelector, child) => Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
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
                          padding: const EdgeInsets.all(0),
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
                            padding: const EdgeInsets.all(0),
                            onPressed: () => iconSelector.changeColor(),
                            icon: const Icon(Icons.color_lens_rounded)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
