import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/presentation/color_constants.dart';
import 'package:realty_guys/providers/host_settings.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameSettingsProvider(),
      child: Consumer<GameSettingsProvider>(
        builder: (context, settings, child) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white10,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  child: Text(
                    'Game Settings',
                    style: TextStyle(fontSize: 18, color: Colors.white60),
                  ),
                ),
                Row(children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Initial Money:  \$${settings.money}',
                        style: const TextStyle(color: Colors.white70),
                      )),
                  Expanded(
                    flex: 4,
                    child: Slider(
                      activeColor: Colors.white38,
                      thumbColor: AppColors.solidWhite70,
                      inactiveColor: Colors.white10,
                      value: settings.money.toDouble(),
                      min: settings.minMoney.toDouble(),
                      max: settings.maxMoney.toDouble(),
                      divisions: 5,
                      onChanged: (value) {
                        //call provider
                        settings.updateMoney(value.toInt());
                      },
                    ),
                  ),
                ]),
                Row(children: [
                  Expanded(
                    flex: 3,
                    child: Text('Turn time (sec):   ${settings.time}',
                        style: const TextStyle(color: Colors.white70)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Slider(
                      activeColor: Colors.white38,
                      thumbColor: AppColors.solidWhite70,
                      inactiveColor: Colors.white10,
                      value: settings.time.toDouble(),
                      min: settings.minTime.toDouble(),
                      max: settings.maxTime.toDouble(),
                      divisions: 3,
                      onChanged: (value) => settings.updateTimer(value.toInt()),
                    ),
                  ),
                ]),
                // Row(children: [
                //   Expanded(
                //     flex: 3,
                //     child: Text('Max players:   ${settings.playerCount}',
                //         style: const TextStyle(color: Colors.white70)),
                //   ),
                //   Expanded(
                //     flex: 4,
                //     child: Slider(
                //       activeColor: Colors.white38,
                //       thumbColor: AppColors.solidWhite70,
                //       inactiveColor: Colors.white10,
                //       value: settings.playerCount.toDouble(),
                //       min: settings.minPlayers.toDouble(),
                //       max: settings.maxPlayers.toDouble(),
                //       divisions: settings.maxPlayers - settings.minPlayers,
                //       onChanged: (value) {
                //         //call provider
                //         settings.updateMaxPlayers(value.toInt());
                //       },
                //     ),
                //   ),
                // ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Collect rent in Jail',
                          style: TextStyle(color: Colors.white70)),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Switch(
                          activeColor: AppColors.solidWhite70,
                          activeTrackColor: Colors.teal[200],
                          value: settings.collectIfJailed,
                          onChanged: (value) =>
                              settings.collectIfJailed = value,
                        ),
                      )
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Auction Mode',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Switch(
                        activeColor: AppColors.solidWhite70,
                        activeTrackColor: Colors.teal[200],
                        value: settings.auctionMode,
                        onChanged: (value) => settings.auctionMode = value,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
