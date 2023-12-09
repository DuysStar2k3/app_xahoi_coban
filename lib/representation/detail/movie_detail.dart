import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final String heroTag;

  const MovieDetail({Key? key, required this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: size.height / 3.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/images/sider${heroTag.substring(heroTag.length - 5)}"),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24, top: size.height / 5.5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width / 3,
                        height: size.height / 4,
                        child: Hero(
                          tag: heroTag,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/sider${heroTag.substring(heroTag.length - 5)}"))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
// child: Hero(
//         tag: 
//         child: Image.asset("assets/images/sider${heroTag.substring(heroTag.length - 5)}"),
//       ),