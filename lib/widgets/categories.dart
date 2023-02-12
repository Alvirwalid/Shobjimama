import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shobjimama/innerscreen/categoryscreen.dart';

import '../service/utils.dart';
import 'textwidhet.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map<String, dynamic>> cat = [
    {
      'cattext': 'Fruits',
      'imagepath': './asset/image/cat/fruits.png',
      'color': Colors.red
    },
    {
      'cattext': 'Nuts',
      'imagepath': './asset/image/cat/nuts.png',
      'color': Colors.yellow
    },
    {
      'cattext': 'Grains',
      'imagepath': './asset/image/cat/grains.png',
      'color': Colors.pink
    },
    {
      'cattext': 'Herbs',
      'imagepath': './asset/image/cat/Spinach.png',
      'color': Colors.teal
    },
    {
      'cattext': 'Vegetable',
      'imagepath': './asset/image/cat/veg.png',
      'color': Colors.cyan
    },
    {
      'cattext': 'Spicy',
      'imagepath': './asset/image/cat/spices.png',
      'color': Colors.purple
    },
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.colors;

    double screensize = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (() {
                Get.toNamed(CategoryScreen.routename,
                    arguments: cat[index]['cattext']);
              }),
              child: Container(
                // width: 100,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: cat[index]['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 2, color: cat[index]['color'].withOpacity(0.7))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: screensize * 0.28,
                    //   height: screensize * 0.22,
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           fit: BoxFit.fill,
                    //           image: AssetImage(cat[index]['imagepath']))),
                    // ),
                    Textwidget(
                      text: cat[index]['cattext'],
                      color: cat[index]['color'],
                      textsize: 15,
                      istitle: true,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: cat.length),
    );
  }
}
