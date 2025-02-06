import 'package:flutter/material.dart';

class DrinkData {
  final String tagLine;
  final String title;
  final String type;
  final List<Color> colors;
  final String image;
  final List<String> decoratorImages;
  final List<String> packageOptions; // New field for package options
  final String description; // New field for description

  DrinkData({
    required this.tagLine,
    required this.title,
    required this.type,
    required this.colors,
    required this.image,
    required this.decoratorImages,
    required this.packageOptions, // Initialize new field
    required this.description, // Initialize new field
  });
}

final List<DrinkData> drinks = [

  DrinkData(
    tagLine: "Unleash Your THIRST’S Desire",
    title: "Orange",
    type: "Zero Sugar",
    colors: [const Color(0xFFFF9838), Color(0xffE6480C)],
    image: 'assets/Fanta_Orange.png',
    decoratorImages: [
      "assets/Orange/Orange-1.png",
      "assets/Orange/Orange-2.png",
      "assets/Orange/Orange-3.png",
      "assets/Orange/Orange-4.png",
      "assets/Orange/Orange-5.png",
      "assets/Orange/Orange-6.png",
      "assets/Orange/Orange-7.png",
      "assets/Orange/Orange-0.png",
    ],
    packageOptions: [
      "12 fl oz, 8 Pack",
      "12 fl oz, 12 Pack",
      "12 fl oz, 15 Cube Pack",
      "12 fl oz, 18 Pack",
      "12 fl oz, 20 Pack",
    ],
    description: "Carbonated water, high fructose corn syrup, less than 2% of: citric acid, natural flavors, sodium benzoate (to protect taste), modified food starch, glycerol ester of rosin, yellow 6, red 40.",
  ),
  DrinkData(
    tagLine: "Taste The CHILL Factor",
    title: "Grape",
    type: "Zero Sugar",
    colors: [const Color(0xFF7D1894), Color(0xff593064)],
    image: 'assets/Fanta_Grape.png',
    decoratorImages: [
      "assets/Grape/Grape-0.png",
      "assets/Grape/Grape-1.png",
      "assets/Grape/Grape-2.png",
      "assets/Grape/Grape-3.png",
      "assets/Grape/Grape-4.png",
      "assets/Grape/Grape-5.png",
      "assets/Grape/Grape-6.png"
    ],
    packageOptions: [
      "12 fl oz, 8 Pack",
      "12 fl oz, 12 Pack",
      "12 fl oz, 15 Cube Pack",
      "12 fl oz, 18 Pack",
      "12 fl oz, 20 Pack",
    ],
    description: "Carbonated water, high fructose corn syrup, less than 2% of: citric acid, natural flavors, sodium benzoate (to protect taste), modified food starch, glycerol ester of rosin, yellow 6, red 40.",
  ),
  DrinkData(
    tagLine: "FANTA Fun FANTASTIC Refreshment",
    title: "Pineapple",
    type: "Caffeine Free",
    colors: const [Color(0xFFEBC02F), Color(0xffAB7A00)],
    image: 'assets/Fanta_Pineapple.png',
    decoratorImages: [
      "assets/pineapple/pineapple-0.png",
      "assets/pineapple/pineapple-1.png",
      "assets/pineapple/pineapple-2.png",
      "assets/pineapple/pineapple-3.png",
      "assets/pineapple/pineapple-4.png",
      "assets/pineapple/pineapple-5.png",
      "assets/pineapple/pineapple-6.png",
      "assets/pineapple/pineapple-7.png"
    ],
    packageOptions: [
      "12 fl oz, 8 Pack",
      "12 fl oz, 12 Pack",
      "12 fl oz, 15 Cube Pack",
      "12 fl oz, 18 Pack",
      "12 fl oz, 20 Pack",
    ],
    description: "Carbonated water, high fructose corn syrup, less than 2% of: citric acid, natural flavors, sodium benzoate (to protect taste), modified food starch, glycerol ester of rosin, yellow 6, red 40.",
  ),
  DrinkData(
    tagLine: "FANTA Fiesta FESTIVE Flavour",
    title: "Strawberry",
    type: "Caffeine Free",
    colors: [const Color(0xFFDD101F), Color(0xff8D1525)],
    image: 'assets/Fanta_Strawberry.png',
    decoratorImages: [
      "assets/strawberry/strawberry-0.png",
      "assets/strawberry/strawberry-1.png",
      "assets/strawberry/strawberry-2.png",
      "assets/strawberry/strawberry-3.png",
      "assets/strawberry/strawberry-4.png",
      "assets/strawberry/strawberry-5.png",
      "assets/strawberry/strawberry-6.png",
      "assets/strawberry/strawberry-7.png",
      "assets/strawberry/strawberry-8.png",
      "assets/strawberry/strawberry-9.png",
    ],
    packageOptions: [
      "12 fl oz, 8 Pack",
      "12 fl oz, 12 Pack",
      "12 fl oz, 15 Cube Pack",
      "12 fl oz, 18 Pack",
      "12 fl oz, 20 Pack",
    ],
    description: "Carbonated water, high fructose corn syrup, less than 2% of: citric acid, natural flavors, sodium benzoate (to protect taste), modified food starch, glycerol ester of rosin, yellow 6, red 40.",
  ),
  DrinkData(
    tagLine: "Revitalize With COLD Drinks",
    title: "Berry",
    type: "Caffeine Free",
    colors: [const Color(0xFF0462D2), Color(0xff083175)],
    image: 'assets/Fanta_Berry.png',
    decoratorImages: [
      "assets/Berry/Berry-0.png",
      "assets/Berry/Berry-1.png",
      "assets/Berry/Berry-2.png",
      "assets/Berry/Berry-3.png",
      "assets/Berry/Berry-4.png",
      "assets/Berry/Berry-5.png",
      "assets/Berry/Berry-6.png",
      "assets/Berry/Berry-7.png",
      "assets/Berry/Berry-8.png",
    ],
    packageOptions: [
      "12 fl oz, 8 Pack",
      "12 fl oz, 12 Pack",
      "12 fl oz, 15 Cube Pack",
      "12 fl oz, 18 Pack",
      "12 fl oz, 20 Pack",
    ],
    description:
        "Carbonated water, high fructose corn syrup, less than 2% of: citric acid, natural flavors, sodium benzoate (to protect taste), modified food starch, glycerol ester of rosin, yellow 6, red 40.",
  ),
];
