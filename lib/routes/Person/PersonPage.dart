import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mail_outline, size: 30),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, size: 30),
          ),
        ],
      ),
      body:  Column(
        children: [
          //-----------------个人信息-----------------------------------
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //--------------------------------------
                  // 头像部分
                      Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey

                      ),
                    ),
                      const SizedBox(width: 16),
                    //----------------------------------------------
                    // 用户信息
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "用户名",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "2023234222",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17,
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(width: 16),
                    //-----------------------------------------------------
                    // 社团标签
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),),

                        child: const Text(
                          "天外天工作室",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          //-----------------------功能按钮----------------------------------
          Padding(padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  Container(
                    //alignment: Alignment.topCenter,
                    decoration: ButtonStyle(),
                    height: 100,
                    width: 120,
                    child: InkWell(
                      onTap: (){},
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.messenger_rounded,color: Colors.blueAccent,size: 30,),
                          Text("消息中心",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),)
                        ],
                      ),

                    ),
                  ),
                Container(
                  //alignment: Alignment.center,
                  decoration: ButtonStyle(),
                  height: 100,
                  width: 120,
                  child: InkWell(
                    onTap: (){},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite,color: Colors.redAccent,size: 30,),
                        Text("我的点赞",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),)
                      ],
                    ),
                  ),
                ),
                Container(
                  //alignment: Alignment.center,
                  height: 100,
                  width: 120,
                  decoration: ButtonStyle(),
                  child: InkWell(
                    onTap: (){},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star,color: Colors.yellow,size: 30,),
                        Text("我的收藏",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}

BoxDecoration ButtonStyle()
{
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 2,
          blurRadius: 5
      ),]
  );
}

