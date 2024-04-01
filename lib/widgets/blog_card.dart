import 'package:flutter/material.dart';

class BottomBlogCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String author;
  final String date;
  final Function() tap;
  const BottomBlogCard(
      {super.key,
      required this.imageUrl,
      required this.category,
      required this.title,
      required this.author,
      required this.date,
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Card(
        // color: const Color(0XFFF5F5F5),
        elevation: 0.5,
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                flex: 40,
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.fill)),
                ),
              ),
              Expanded(
                flex: 70,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 5.0, top: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        maxLines: 2,
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(author,
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(width: 36.0),
                          Expanded(
                            child: Text(date,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
