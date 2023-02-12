import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../model/productmodel.dart';
import '../providers/productprovider.dart';
import '../service/utils.dart';
import '../widgets/emptyprdwidget.dart';
import '../widgets/feed_widget.dart';
import '../widgets/textwidhet.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const routename = '/CategoryScreen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose

    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    Color color = Utils(context).colors;
    var productProvider = Provider.of<ProductProvider>(context);

    var args = Get.arguments;

    List<ProductModel> productList = productProvider.findByCategory(args);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Textwidget(
          text: 'All Product',
          color: color,
          textsize: 22,
          istitle: true,
        ),
        // leading: const BackWidget(),
      ),
      body: productList.isEmpty
          ? const EmptyProdScreeen(txt: 'No product at this time')
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: searchController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search),
                            ),
                            suffix: IconButton(
                                onPressed: (() {
                                  searchController.clear();
                                  _focusNode.unfocus();
                                }),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.greenAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.greenAccent)),
                            hintText: 'what\'s yor mind',
                            hintStyle: const TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                  ListView(
                    //  padding: EdgeInsets.symmetric(vertical: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(productList.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: productList[index],
                        child: Container(),
                      );
                    }),
                  )
                ],
              ),
            ),
    );
  }
}
