import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final listEmoji = ['😶', '😭', '🙁', '😄', '😍', '🤩'];
  final scrollController = FixedExtentScrollController();
  int? currentScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100,
                  child: GestureDetector(
                    child: ListWheelScrollView(
                      onSelectedItemChanged: (index) {
                        log('${scrollController.selectedItem}');
                        setState(() {
                          if (index == 0) {
                            currentScore = null;
                          } else {
                            currentScore = index;
                          }
                        });
                      },
                      physics: const FixedExtentScrollPhysics(),
                      controller: scrollController,
                      itemExtent: 90,
                      children: List.generate(
                        6,
                        (index) => Text(
                          listEmoji[index],
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentScore = index + 1;
                            scrollController.animateTo((index + 1) * 90,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.bounceOut);
                          });
                        },
                        child: Icon(
                          ((currentScore != null) && (currentScore! > index))
                              ? Icons.star
                              : Icons.star_border_outlined,
                          size: 64.0,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
