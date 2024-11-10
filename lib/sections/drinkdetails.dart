import 'package:flutter/material.dart';

class DrinkDetails extends StatelessWidget {
  const DrinkDetails({Key? key, required this.image, required this.text}): super(key: key);
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 28*2,),
            Padding(padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                  )
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          Center(
            child: ClipRRect(borderRadius: const BorderRadius.all(
              Radius.circular(10),
              ),
              child: Image.network(
                image,
                height: 250,
                fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.black,
              )
            ),
          ],
        )
      )
    );
  }
}
