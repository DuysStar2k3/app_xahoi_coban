import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 180,
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 90,
            backgroundColor: Colors.black,
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                ),
                const Positioned(
                  top: 70,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi,Nguyễn!",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        "Where are you going next?",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  top: 90,
                  right: 60,
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 80,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                          );
                        },
                      );
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avata.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 160),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              height: 40,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
