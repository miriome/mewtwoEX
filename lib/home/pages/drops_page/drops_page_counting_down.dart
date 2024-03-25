import 'package:flutter/material.dart';


class DropsPageCountingDown extends StatelessWidget {
  final Duration timeToDrop;
  const DropsPageCountingDown({Key? key, required this.timeToDrop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text.rich(
          TextSpan(style: TextStyle(fontSize: 20), children: [
            TextSpan(text: "Early bird catches the worm\n\n"),
            TextSpan(text: "We release our curated drops\n"),
            TextSpan(text: "every Tuesday at 7pm\n\n", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "Next drop in:", style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        buildCountDown()
      ],
    );
  }

  Widget buildCountdownUnit(String label, int timeUnit) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...timeUnit.toString().padLeft(2, "0").split('').map((e) => getTimeChar(e))
          ],
        ),
      Text(label)
      ],
    );
  }

  Widget buildCountDown() {
    final days = timeToDrop.inDays;
    final hours = timeToDrop.inHours.remainder(24);
    final minutes = timeToDrop.inMinutes.remainder(60);
    final seconds = timeToDrop.inSeconds.remainder(60);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (days > 0) ...[
          buildCountdownUnit("days", days),
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              ":",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          )
        ],
        if (hours > 0) ...[
          buildCountdownUnit("hours", hours),
          const Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              ":",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          )
        ],
        buildCountdownUnit("minutes", minutes),
        const Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: Text(
            ":",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        buildCountdownUnit("seconds", seconds),
      ],
    );
  }

  Widget getTimeChar(String char) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF7D7878).withOpacity(0.3),
        borderRadius: BorderRadius.circular(6)
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        char,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}
