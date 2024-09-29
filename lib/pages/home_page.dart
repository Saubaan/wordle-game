import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle/components/image_button.dart';
import 'package:wordle/pages/game_page.dart';

import '../utils/words_list.dart';
import 'dev_info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> duration = [0, 60, 120, 300, 600, 900];
  List<String> time = ['Off', '1 min', '2 min', '5 min', '10 min', '15 min'];
  int selection = 0;
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: screenWidth / 20,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text('Timer:', style: TextStyle(
                        fontFamily: 'RetroGame', fontSize: screenWidth * 0.06),),
                    Container(
                      width: screenWidth/2.5,
                      padding: EdgeInsets.all(screenWidth / 80),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black,),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 1,
                          ),
                          Text(time[selection % time.length], style: TextStyle(
                              fontFamily: 'RetroGame', fontSize: screenWidth * 0.05),),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selection++;
                              });
                            },
                            icon: const Icon(Icons.navigate_next_rounded),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenWidth / 8,
                    ),
                    ImageButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GamePage(
                                    word: words[random.nextInt(words.length)]
                                        .toUpperCase(),
                                    duration: duration[
                                    selection % duration.length])));
                      },
                      imagePath1: 'assets/components/play.png',
                      height: screenWidth / 2.5,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ImageButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const DevInfoPage()));
                          },
                          imagePath1: 'assets/components/about.png',
                          height: screenWidth / 12,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
