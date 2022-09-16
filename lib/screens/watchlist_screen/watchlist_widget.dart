import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/database/my_dataBase.dart';
import 'package:movies_app/models/PopularResponse.dart';
import 'package:movies_app/screens/watchlist_screen/watchlist_screen.dart';

class WatchlistWidget extends StatefulWidget {
  Results results;
  WatchlistWidget({required this.results});

  @override
  State<WatchlistWidget> createState() => _WatchlistWidgetState();
}

class _WatchlistWidgetState extends State<WatchlistWidget> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      child: Row(
        children: [
          Stack(
            children: [
              Image.network(
                'https://image.tmdb.org/t/p/w500' +
                    '${widget.results.posterPath}',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
              IconButton(
                onPressed: () {
                  if (WatchlistScreen.watchlist.any(
                      (element) => element.title == widget.results.title)) {
                    if (WatchlistScreen.watchlist.length == 1) {
                      MyDB.deletemovie(widget.results);
                      WatchlistScreen.watchlist = [];
                    } else {
                      MyDB.deletemovie(widget.results);
                    }
                  }
                },
                icon: Stack(
                  children: const [
                    ImageIcon(
                      AssetImage("assets/images/preseedbookmark.png"),
                      color: Colors.amber,
                      size: 60,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.results.title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500)),
              Text(
                widget.results.releaseDate ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                widget.results.originalLanguage ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
