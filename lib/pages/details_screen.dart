// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flower_app_project/model/Prodact.dart';
import 'package:flower_app_project/shared/appBar.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  late Prodact prodacts;
  Details({required this.prodacts});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool showMore = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 141, 95),
        title: Text("Details Item "),
        actions: [
          AppBarRebited()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.prodacts.pathImage),
            const SizedBox(
              height: 10,
            ),
            Text(
            " \$${widget.prodacts.price}",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10),
                      height: 25,
                      width: 30,
                      child: Text("New"),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 129, 129),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 191, 0),
                      size: 26,
                    ),
                    Icon(Icons.star,
                        color: Color.fromARGB(255, 255, 191, 0), size: 26),
                    Icon(Icons.star,
                        color: Color.fromARGB(255, 255, 191, 0), size: 26),
                    Icon(Icons.star,
                        color: Color.fromARGB(255, 255, 191, 0), size: 26),
                    Icon(Icons.star,
                        color: Color.fromARGB(255, 255, 191, 0), size: 26),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.edit_location,
                      color: Color.fromARGB(168, 3, 65, 27),
                      size: 26,
                    ),
                    Text(widget.prodacts.location),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                width: double.infinity,
                child: Text(
                  "Details : ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                )),
            const SizedBox(
              height: 16,
            ),
            Text(
              "A flower, also known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers consist of a combination of vegetative organs – sepals that enclose and protect the developing flower, petals that attract pollinators, and reproductive organs that produce gametophytes, which in flowering plants produce gametes. The male gametophytes, which produce sperm, are enclosed within pollen grains produced in the anthers. The female gametophytes are contained within the ovules produced in the carpels.",
              style: TextStyle(fontSize: 15),
              maxLines: showMore ? 3 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: showMore ? Text("Show more") : Text("Show less"))
          ],
        ),
      ),
    );
  }
}
