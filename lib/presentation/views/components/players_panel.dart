import 'package:flutter/material.dart';

class PlayersConnectedPanel extends StatelessWidget {
  const PlayersConnectedPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white10,
      ),
      child: Column(
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
    );
  }
}
