import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lab4/controller/ProductController.dart';
import 'package:lab4/controller/CategoryController.dart';
import 'package:lab4/models/Category.dart';
import 'package:lab4/screen/home/components/_body.dart';

import '../../models/Category.dart' as category;
import '../../models/Product.dart';

class HomePage extends StatefulWidget {
  /* clasa HomePage moștenește clasa StatelessWidget
   extends = moștenire: principiu OOP ce reprezintă posibilitatea de a prelua
             funcționalitatea existentă într-o clasă și de a adăuga una nouă sau de
             a o modela pe cea existentă
   StatelessWidget = widget fără stare care descrie o parte a interfeței cu  utilizatorul
        prin construirea unei constelații de alte widget-uri care descriu interfața cu utilizatorul
   widget = descrie configurația pentru un element. Un widget este descrierea unei părți a unei interfețe cu utilizatorul */
  const HomePage({Key key}) : super(key: key);
  /* constructorul HomePage folosește o cheie ca parametru. Cheile sunt cele care păstrează starea widget-urilor.
     super = exact ca this cuvântul cheie care indică clasa părinte
     odată ce folosim moștenirea cu extends constructorul clasei copil va fi executat după executarea constructorului părintelui */


  @override
  /* @override subliniază că funcția este definită și într-o clasă părinte, dar este redefinită pentru a face altceva în
     clasa curentă. De asemenea, este folosit pentru a adnota implementarea unei metode abstracte
     Recomandat deoarece îmbunătățește lizibilitatea (care poate fi citit cu ușurință) */
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //listele goale pentru produse si categorii
  List<Product> productList = [];
  List<category.Category> categoryList = [];

  //future - asteptam un raspuns dar nu stim daca va veni
  //async await pentru ca anuntam intentia de a primi un raspuns
  //se initializeaza controlerele
  //din fisierul json /assets/shop.json fiecare controller citeste lista de categorii si lista de produse
  //returneaza controllerele aceste liste catre initialfetch
  //!important set state permite schimbarea starii acestor liste goale si popularea lor
  Future<void> initialFetch() async {
    final ProductController productController = Get.put(ProductController());
    final CategoryController categoryController = Get.put(CategoryController());
    List<Category> listCategoryFromRequest = await categoryController.readJsonCategories();
    List<Product> listProductsFromRequest = await productController.readJsonProducts();
    setState(() {
      categoryList.addAll(listCategoryFromRequest);
      productList.addAll(listProductsFromRequest);
    });
  }

  @override
  Widget build(BuildContext context) {
    //initial fetch se cheama inainte de a construi ecranul
    initialFetch();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          //se cheama o alta clasa care va construi ambele liste
          child: detailBody(productList, categoryList, context),
        ),
      ),
    );
  }
}
