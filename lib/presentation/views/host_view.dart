import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realty_guys/providers/host_settings.dart';

class HostView extends StatelessWidget {
  const HostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HostSettings(),
      child: Consumer<HostSettings>(builder: (context, settings, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 19, 19, 19),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Host Game',
                  style: TextStyle(fontSize: 22, color: Colors.white70),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Room Code: 4325',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ),
              CardCol(children: [
                const SelectorPanel(),
                Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Game Settings',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(children: [
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
                            value: settings.time.toDouble(),
                            min: settings.minTime.toDouble(),
                            max: settings.maxTime.toDouble(),
                            divisions: 3,
                            onChanged: (value) =>
                                settings.updateTimer(value.toInt()),
                          ),
                        ),
                      ]),
                      Row(children: [
                        Expanded(
                          flex: 3,
                          child: Text('Max players:   ${settings.playerCount}',
                              style: const TextStyle(color: Colors.white70)),
                        ),
                        Expanded(
                          flex: 4,
                          child: Slider(
                            value: settings.playerCount.toDouble(),
                            min: settings.minPlayers.toDouble(),
                            max: settings.maxPlayers.toDouble(),
                            divisions:
                                settings.maxPlayers - settings.minPlayers,
                            onChanged: (value) {
                              //call provider
                              settings.updateMaxPlayers(value.toInt());
                            },
                          ),
                        ),
                      ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Collect rent in Jail',
                                style: TextStyle(color: Colors.white70)),
                            Switch(
                              value: settings.collectIfJailed,
                              onChanged: (value) =>
                                  settings.collectIfJailed = value,
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Auction Mode',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Switch(
                            value: settings.auctionMode,
                            onChanged: (value) => settings.auctionMode = value,
                          )
                        ],
                      ),
                    ]),
                  ),
                ]),

                //players
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Players',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.queue_rounded),
                              Icon(Icons.playlist_add_check_circle_outlined),
                              Text("KonkeyDong")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.playlist_add_check_circle_outlined,
                                color: Colors.redAccent,
                              ),
                              Text(
                                "Jarold xpl",
                                style: const TextStyle(color: Colors.redAccent),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //
                //ConnectedPlayers() // name and container
              ]),
            ]),
          ),
        );
      }),
    );
  }
}

class CardCol extends StatelessWidget {
  const CardCol({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(children: children.map((e) => MyCard(child: e)).toList());
  }
}

class MyCard extends StatelessWidget {
  const MyCard({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white10,
      ),
      child: child,
    );
  }
}

class SelectorPanel extends StatelessWidget {
  const SelectorPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Start')),
            )),
        Expanded(
          flex: 4,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: const Icon(Icons.casino_rounded),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous_rounded),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(Icons.ac_unit_outlined),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next_rounded),
                  ),
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: const Icon(Icons.color_lens_rounded)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
