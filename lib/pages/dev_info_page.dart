import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevInfoPage extends StatelessWidget {
  const DevInfoPage({super.key});
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Devs died at $url lol';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontFamily: 'RetroGame'),
        ),
        backgroundColor: const Color.fromARGB(255, 246, 130, 0),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          children: [
            Text(
              'Meet the dev:',
              style: TextStyle(
                  fontFamily: 'RetroGame', fontSize: screenWidth * 0.05),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 215, 171),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Center(
                        child: SizedBox(
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          child: ClipOval(
                            child: Image.network(
                              'https://avatars.githubusercontent.com/u/87719733',
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Icon(Icons.developer_board, size: screenWidth*0.15,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saubaan Shaikh',
                            style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Game logic, UI/UX Design, Frontend',
                            style: TextStyle(fontSize: screenWidth * 0.03),
                          ),
                          Row(
                            children: [
                              Text(
                                'Follow me at: ',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              IconButton(
                                onPressed: () {
                                  const String url =
                                      'https://www.linkedin.com/in/saubaan-shaikh';
                                  launchURL(url);
                                },
                                icon: FittedBox(
                                  child: Image.asset(
                                    'assets/components/linkedin.png',
                                    height: screenWidth * 0.075,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  const String url = 'https://github.com/Saubaan';
                                  launchURL(url);
                                },
                                icon: FittedBox(
                                  child: Image.asset(
                                    'assets/components/github.png',
                                    height: screenWidth * 0.075,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
