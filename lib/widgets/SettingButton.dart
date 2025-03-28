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

Widget PreButton(VoidCallback onPressed)
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
            const Text("头像",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.only(left: 220),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[400]),
              ),
            ),
            IconButton(onPressed: onPressed,
                icon: const Icon(Icons.arrow_forward_ios)
            )
          ],
        ),
      ),
    ),
  );
}

Widget PhoneEmailButton(String title,VoidCallback onPressed,Icon theIcon)
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
            theIcon,
            Text(title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(width: 150,),
            Text("待填写",style: TextStyle(fontSize: 20,color: Colors.grey[400]),),
            IconButton(onPressed: onPressed,
                icon: const Icon(Icons.arrow_forward_ios)
            )
          ],
        ),
      ),
    ),
  );
}

