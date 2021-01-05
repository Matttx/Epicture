import 'package:epicture/api/images.dart';
import 'package:epicture/components/post.dart';
import 'package:epicture/data/constants.dart';
import 'package:epicture/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FooterPost extends StatelessWidget {
  const FooterPost({
    Key key,
    @required this.widget,
    @required this.provider,
  }) : super(key: key);

  final Post widget;
  final GeneralState provider;

  String incrementVote(String vote) {
    var finalVote = int.parse(vote) + 1;
    return finalVote.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    widget.image.title,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {
                        provider.setVote(widget.image,
                            widget.image.vote == "up" ? null : "up", "feed");
                        vote(context, widget.image, "up");
                      },
                      child: SvgPicture.asset(
                        widget.image.vote == "up"
                            ? "assets/icons/up-arrow-yellow.svg"
                            : "assets/icons/up-arrow-filled.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  Text(
                    widget.image.vote == "up"
                        ? incrementVote(widget.image.ups)
                        : widget.image.ups,
                    style: TextStyle(
                        fontSize: 14,
                        color: widget.image.vote == "up"
                            ? upVoteColor
                            : Colors.white),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: GestureDetector(
                    onTap: () {
                      provider.setVote(widget.image,
                          widget.image.vote == "down" ? null : "down", "feed");
                      vote(context, widget.image, "down");
                    },
                    child: SvgPicture.asset(
                      widget.image.vote == "down"
                          ? "assets/icons/down-arrow-red.svg"
                          : "assets/icons/down-arrow-filled.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                Text(
                  widget.image.vote == "down"
                      ? incrementVote(widget.image.downs)
                      : widget.image.downs,
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.image.vote == "down"
                          ? downVoteColor
                          : Colors.white),
                )
              ],
            ),
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  provider.setFavorite(widget.image,
                      provider.selectedIndex == 0 ? "feed" : "favorites");
                  favoriteImages(context,
                      "https://api.imgur.com/3/album/${widget.image.id}/favorite");
                },
                icon: SvgPicture.asset(
                  widget.image.favorite
                      ? "assets/icons/star-yellow.svg"
                      : "assets/icons/star-white.svg",
                  height: 20,
                  width: 20,
                ))
          ],
        ),
      ),
    );
  }
}
