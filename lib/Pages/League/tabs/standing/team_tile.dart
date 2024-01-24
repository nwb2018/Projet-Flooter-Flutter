import 'package:flooter/Services/sharedPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flooter/models/table_model.dart';
import 'custom_widgets.dart';

class TeamTile extends StatefulWidget {
  const TeamTile({Key? key, required this.standing}) : super(key: key);
  final TableItem standing;

  @override
  _TeamTileState createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Set initial favorite status
    isFavorite =
        SharedPreferencesService.isTeamFavorite(widget.standing.team.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: customBoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add the favorite icon here
          FavoriteButton(
            teamId: widget.standing.team.id,
            isFavorite: isFavorite,
            onFavoriteChanged: _onFavoriteChanged,
          ),
          SizedBox(
            width: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    widget.standing.position.toString(),
                    textAlign: TextAlign.center,
                    style: customTextStyle(12, FontWeight.w400),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 122,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      crestImage(widget.standing.team.crest),
                      const SizedBox(width: 8),
                      Text(
                        customName(widget.standing.team.name),
                        style: customTextStyle(12, FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                standingTab(widget.standing.playedGames.toString(), 20, false),
                standingTab(widget.standing.won.toString(), 20, false),
                standingTab(widget.standing.draw.toString(), 20, false),
                standingTab(widget.standing.lost.toString(), 20, false),
                standingTab(
                    "${widget.standing.goalsFor}:${widget.standing.goalsAgainst}",
                    40,
                    false),
                standingTab(widget.standing.points.toString(), 25, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget crestImage(String crest) {
    return (crest.endsWith('.svg'))
        ? SvgPicture.network(
            crest,
            height: 20,
            width: 20,
          )
        : Image.network(
            crest,
            height: 20,
            width: 20,
          );
  }

  String customName(String name) {
    if (name.length < 15) {
      return name;
    } else {
      return "${name.substring(0, 12)}...";
    }
  }

  void _onFavoriteChanged(bool newFavoriteStatus) {
    setState(() {
      isFavorite = newFavoriteStatus;
    });
  }
}

class FavoriteButton extends StatelessWidget {
  final int teamId;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteChanged;

  const FavoriteButton({
    Key? key,
    required this.teamId,
    required this.isFavorite,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        // Toggle the favorite status and notify the parent about the change
        final bool newFavoriteStatus = !isFavorite;
        SharedPreferencesService.toggleTeamFavorite(teamId);
        onFavoriteChanged(newFavoriteStatus);
      },
    );
  }
}
