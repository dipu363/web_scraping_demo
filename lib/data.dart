
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:web_scraping_demo/product.dart';

Future <List<Product>>getAllProduct() async{
  List<Product> products = [];
  final response = await http.Client().get(
    Uri.parse(
        'https://api.croma.com/product/allchannels/v1/search?query=iphone'),
   /* headers: {
      'User-Agent':
      'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4'
    },*/
  );
  if (response.statusCode == 200) {
    print(response.body.toString());
/*
    var document = parser.parse(response.body);
    var data = document.getElementsByClassName('plpGridItem');

    for (int index = 0; index < data.length; index++) {
      var title = data[index].getElementsByClassName('prdDesrpHed')[0].text;
      var desc = data[index].getElementsByClassName('prdInfoDesc')[0].text;
      var price = data[index].getElementsByClassName('oldPricee')[0].text;
      var oldPrice = data[index].getElementsByClassName('prdPrice')[0].text;
      var offText = data[index].getElementsByClassName('offText')[0].text;
      var image =
      data[index].getElementsByTagName('img')[0].attributes['src'].toString();

      products.add(
        Product(
            title: title,
            desc: desc,
            price: price,
            oldPrice: oldPrice,
            offText: offText,
            image: image),
      );

      print(image);
    }
*/

    /*Product(
        title: document.outerHtml.toString(),
        desc: "desc",
        price: "price",
        oldPrice: "oldPrice",
        offText: "offText",
        image: "image");*/

    return products;
  } else {
    print("data "+response.body.toString());

    return products;
  }
}
