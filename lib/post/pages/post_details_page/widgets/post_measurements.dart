import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/user_model.dart';

class PostMeasurements extends StatelessWidget {
  final UserModel user;
  final bool isMyPost;
  const PostMeasurements({Key? key, required this.user, required this.isMyPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 9),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white.withOpacity(0.85)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "${user.username}'s measurements",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor),
          ),
          ...measurements
        ]),
      ),
    );
  }

  List<Widget> get measurements {
    if (user.measurementPrivacy == MeasurementPrivacy.following && !user.my_follow && !isMyPost) {
      return const [
        SizedBox(
          width: 268,
          child: Text(
            "This user has only allowed followers to view their measurements",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        )
      ];
    }
    // Change this to dynamic lmao
    const heightUnits = "cm";
    const otherUnits = "in";
    return [
      Text(
        "Height: ${user.height ?? "-"} $heightUnits",
        style: const TextStyle(fontSize: 16),
      ),
      Text(
        "Bust: ${user.bust ?? "-"} $otherUnits | Waist: ${user.waist ?? "-"} $otherUnits | Hips: ${user.hips ?? "-"} $otherUnits",
        style: const TextStyle(fontSize: 16),
      )
    ];
  }
}
