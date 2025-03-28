import 'package:flutter/material.dart';

Widget spearate()
{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      height: 1,
      color: Colors.grey[350],
    ),
  );
}
Widget buildButton(String title,VoidCallback onPressed)
{
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.white
      ),
      child:Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            IconButton(onPressed: onPressed,
                icon: const Icon(Icons.arrow_forward_ios)
            )
          ],
        ),
      ),
    ),
  );
}
