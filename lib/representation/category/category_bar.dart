import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/name_itemcategory.dart';


class CategoryBar extends StatefulWidget {
  CategoryBar({Key? key, required this.size}) : super(key: key);

  final Size size;
  final List<ItemCategory> items = [
    ItemCategory("All"),
    ItemCategory("TopView"),
    ItemCategory("Update"),
    ItemCategory("Comedy"),
    ItemCategory("Message"),
    ItemCategory("Romance"),
    ItemCategory("Add"),
  ];

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        height: size.height / 18,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                
              },
              child: Container(
                margin: EdgeInsets.only(left: 16),
                alignment: Alignment.center,
                width: size.width / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: selectedIndex == index ? Colors.blue : Colors.transparent,
                ),
                child: Text(
                  widget.items[index].name,
                  style: TextStyle(

                    color: selectedIndex == index ? Colors.white : Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
