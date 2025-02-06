import 'package:cold_drink_animated_ui/models/drinks.dart';
import 'package:flutter/material.dart';

class CanDetailScreen extends StatelessWidget {
  final DrinkData drink;
  const CanDetailScreen({
    super.key,
    required this.drink,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              // Add to cart functionality
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 20.8,
                fontFamily: "FugazOne",
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: drink.colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: -50,
                child: Hero(
                  tag: 'can_${drink.title}',
                  child: Image.asset(
                    drink.image,
                    height: MediaQuery.of(context).size.height * .6,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .45,
                  ),
                  Text(
                    drink.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.29,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    drink.type, // Use the passed drink type
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.4,
                      color: Colors.white,
                      fontFamily: "FugazOne",
                    ),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: drink.packageOptions
                        .map(
                          (option) => Text(
                            option,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.71,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 5),
                  Text(
                    drink.description, // Use the passed description
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "FugazOne",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'read more...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Remove the old Add to Cart button from here
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
