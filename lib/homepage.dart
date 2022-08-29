import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:web_scraping_demo/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productlist = [];
  String text = '';
  bool isLoading = false;

  TextEditingController textfild = TextEditingController();

  @override
  void initState() {
    getAllProduct(" ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Product"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                  onChanged: (value) {
                    text = value;
                    getAllProduct(text);

                  },
                  onSubmitted: (v) {},
                  onEditingComplete: () {
                    textfild.toString();
                     getAllProduct(text);
                  },
                  enableSuggestions: true,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      hintText: 'Search product',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          getAllProduct(text);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.search),
                      ))),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(

                          itemCount: productlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 4,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                productlist[index]
                                                    .title
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  )),
                            );
                          }),
                    )

            ],
          ),
        ),
      ),
    );
  }

  //#search > div.s-desktop-width-max.s-desktop-content.s-opposite-dir.sg-row > div.s-matching-dir.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16 > div > span:nth-child(4) > div.s-main-slot.s-result-list.s-search-results.sg-row > div:nth-child(2) > div > div > div > div > div > div > div > div.sg-col.sg-col-4-of-12.sg-col-8-of-16.sg-col-12-of-20.s-list-col-right > div > div > div.a-section.a-spacing-none.puis-padding-right-small.s-title-instructions-style > h2 > a > span
  // #search > div > div > div > span > div
  // #search > div.s-desktop-width-max.s-desktop-content.s-opposite-dir.sg-row > div.s-matching-dir.sg-col-16-of-20.sg-col.sg-col-8-of-12.sg-col-12-of-16 > div > span:nth-child(4) > div.s-main-slot.s-result-list.s-search-results.sg-row > div:nth-child(2) > div > div > div > div > div > div.sg-col.sg-col-4-of-12.sg-col-8-of-16.sg-col-12-of-20.s-list-col-right > div > div > div.a-section.a-spacing-none.puis-padding-right-small.s-title-instructions-style > h2 > a > span
  Future getAllProduct(String query) async {
    var api = "https://www.amazon.com/s?k= $query";
    // var api = "https://www.croma.com/search/?q= $query";
    final url = Uri.parse(api);
    var response = await Dio().get(url.toString());
    dom.Document html = dom.Document.html(response.data);
    final titles = html
        .querySelectorAll(
            'div> div > div> div > span > div > div > div > div > div > div > div > div> div > div > div > h2 > a > span')
        //.querySelectorAll('.s-title-instructions-style')
        .map((e) => e.innerHtml.trim())
        .toList();
    print("Data titles ${titles.length}");
    for (int t = 0; t < titles.length; t++) {
      print('title : ${titles[t].toString()}');
    }
    setState(() {
      productlist = List.generate(
          titles.length,
              (index) => Product(title: titles[index]));
    });
  }
}
