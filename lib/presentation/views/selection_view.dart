import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/presentation/views/components/board_background.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseGray,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Text(
              "Realty Guys",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.shortestSide,
                child: const RotatedBox(
                    quarterTurns: 2,
                    child: Opacity(opacity: .8, child: BoardBackground()))),
          ),
          Center(
            child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: MediaQuery.of(context).size.shortestSide,
                  )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomButton(text: 'Online', action: 'call prov'),
              CustomButton(text: 'Local', action: 'call prov'),
              CustomButton(text: 'Pass and Play', action: 'call prov'),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, required this.action})
      : super(key: key);
  final String text;
  final String action;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white24),
            textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(fontSize: 18)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () => action, //call provider of client/server connect
          child: Padding(padding: const EdgeInsets.all(15), child: Text(text)),
        ),
      ),
    );
  }
}

// text in center
