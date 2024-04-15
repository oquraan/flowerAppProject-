class Prodact {
  String pathImage;
  double price;
  String location;
  String flowerName;

  Prodact({
    required this.pathImage,
    required this.price,
    required this.location,
    required this.flowerName,
  });
}

List<Prodact> l1 = [
  Prodact( pathImage: "assets/1.webp", price: 1, location: "Omar shop",flowerName: "flower1"),
  Prodact( pathImage: "assets/2.webp", price: 2, location: "Ahmad shop",flowerName: "flower2"),
  Prodact( pathImage: "assets/3.webp", price: 3, location: "Ali shop",flowerName: "flower3"),
  Prodact( pathImage: "assets/4.webp", price: 4, location: "Mohammad shop",flowerName: "flower4"),
  Prodact( pathImage: "assets/5.webp", price: 5, location: "Sammeh shop",flowerName: "flower5"),
  Prodact( pathImage: "assets/6.webp", price: 6, location: "Moneeb shop",flowerName: "flower6"),
  Prodact( pathImage: "assets/7.webp", price: 7, location: "Ramez shop",flowerName: "flower7"),
  Prodact( pathImage: "assets/8.webp", price: 8, location: "Sanad shop",flowerName: "flower8"),
  Prodact(pathImage: "assets/8.webp", price: 5, location: "asad", flowerName: "sdadad"),
  
];
