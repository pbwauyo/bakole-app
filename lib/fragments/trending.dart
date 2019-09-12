import 'package:flutter/material.dart';

class Trending extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TrendingState();
}

class TrendingState extends State<Trending>{
  final List <String> trendingImages = ["cleaning.jpg", "construction.jpg", "handyman.jpg", "moving.jpg", "painting.jpg"];
  final List<String> trendingImageNames = ["Cleaning services", "Construction work", "Handyman services", "Moving goods", "Painting work"];
  final List<String> prices = ["from UGX 30,000", "from UGX 200,000", "from UGX 50,000", "from UGX 25,000", "from UGX 60,000"];

  List<Item> items = []; 

  @override
  Widget build(BuildContext context){
    items = buildItems();

    return (
      ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index){ 
            return SweetRow(items.elementAt(index).image, items.elementAt(index).caption, items.elementAt(index).price);
        },
      )
    );
  }

  
  List<Item> buildItems(){
    List<Item> list = []; 

    for(var i=0; i<trendingImages.length; i++){
      list.add(Item(trendingImages[i], trendingImageNames[i], prices[i]));
    }

    return list;
  }

  
}

class SweetRow extends StatelessWidget{
  SweetRow(this.imageUrl, this.caption, this.price);

  final String imageUrl, caption, price;
  final radius = 16.0;

  @override
  Widget build(BuildContext context){
    return Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
                        child: Image(image: AssetImage("assets/images/$imageUrl"), fit: BoxFit.cover,),
                      ),
                    ),
                    Text(caption),
                    Text(price), 
                  ],
                ),
            ),
          );
  }
}

class Item{
  String image, caption, price;

  Item(String image, String caption, String price){
    this.image = image;
    this.caption = caption;
    this.price = price;
  }

}