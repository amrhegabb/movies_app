import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/PopularResponse.dart';

class WatchlistWidget extends StatelessWidget {
  Results results;
  WatchlistWidget({required this.results});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      child: Row(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500' + '${results.posterPath}',
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(results.title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500)),
              Text(
                results.releaseDate ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                results.originalLanguage ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
