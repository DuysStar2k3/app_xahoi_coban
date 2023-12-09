// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:project_ui_hocphan1/representation/detail/movie_detail.dart';

// class Sider extends StatelessWidget {
//   const Sider({Key? key, required this.size}) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//           autoPlay: true,
//           autoPlayInterval: Duration(seconds: 3),
//           enlargeCenterPage: true),
//       items: [1, 2, 3, 4, 5].map((i) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MovieDetail(heroTag: 'dash-hero-$i',),
//               ),
//             );
//           },
//           child: Builder(
//             builder: (BuildContext context) {
//               return Hero(
//                 tag: 'dash-hero-$i',
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.only(left: 10, bottom: 24),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage("assets/images/sider1.png"),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         width: size.width,
//                         padding: EdgeInsets.only(left: 5),
//                         child: Text(
//                           "Ovelopp",
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                       ),
//                       Container(
//                           margin: EdgeInsets.only(left: 5),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 15,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 15,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 15,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 15,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//                                 size: 15,
//                               ),
//                               Text(
//                                 "(5.0)",
//                                 style: TextStyle(color: Colors.white),
//                               )
//                             ],
//                           ))
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_ui_hocphan1/representation/detail/movie_detail.dart';

class Sider extends StatelessWidget {
  const Sider({Key? key, required this.size}) : super(key: key);

  final Size size;
  static const double ratingValue = 5.0;
  static const String ratingText = "(5.0)";

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return buildCarouselItem(context, index);
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
        height: MediaQuery.of(context).size.height / 2,
      ),
    );
  }

  Widget buildCarouselItem(BuildContext context, int index) {
    String imagePath = "assets/images/sider${index + 1}.png";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetail(heroTag: 'dash-hero-$imagePath'),
          ),
        );
      },
      child: Hero(
        tag: 'dash-hero-$imagePath',
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10, bottom: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(imagePath),
            ),
          ),
          child: buildRatingAndTitle(context),
        ),
      ),
    );
  }

  Widget buildRatingAndTitle(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.only(left: 5),
          child: const Text(
            "Ovelopp",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5),
          child: const Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 15,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 15,
              ),
              Text(
                ratingText,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
