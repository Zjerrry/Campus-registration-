import 'package:flutter/material.dart';
class ClubMainPage extends StatefulWidget {
  const ClubMainPage({super.key,required this.clubname});

  final String clubname;
  @override
  State<ClubMainPage> createState() => _ClubMainPageState();
}

class _ClubMainPageState extends State<ClubMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: CustomScrollView(
        slivers: [
          //社团信息
          Club_Information(context,widget.clubname),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context,index)
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("$index"),
                    onTap: (){},
                  ),
                );
              })
          )
        ],
      ),
    );
  }
}

Widget Club_Information(context,ClubName)
{
  return SliverToBoxAdapter(
    child: Container(
      child: Column(
        children: [
          //社团信息部分
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network("https://s3-alpha-sig.figma.com/img/4a92/272c/15495ba4b99f0c27386610b0fb8af758?Expires=1742774400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=j3j6eWQEj56i-AS6o9HDN0GG9mMKTsfOe4pZH08fLvHvAi~Wcpm8VRO-93vlIChrYffVEpQbKG9xm2wWI7EwtcWfSoPxdjrVmCKD5thR2oDVwk3YfSvqWLltzuYO6CXgcPqHxhmvtODVNnQstDLGT7iXtlJJ7-8F5mFUnXFTDQI035DX2BGvuCoL2ad8rhQhy8Y6lA36z1a3TTbwF1cXE216kD6d4WTXWx6jakwSaeW9~1gNZipuD~PIeRkRxmYImDaY2Z8lYCFJjlbC138s6gthr7DhhjznTTT99-n-4XHRJP6XAWMRjHFtF-oKMGUWCGyyPNEMKAafeEm9AUY~uQ__"), //社团头像
                Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(ClubName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 25
                        ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),//社团名称
                        Text("类型:  育人实践基地",style: TextStyle(
                          color: Colors.grey[600],fontSize: 17
                        ),)//社团类型
                      ],//会溢出屏幕
                    ),
                ),
                IconButton(icon:Icon(Icons.favorite_border,size: 30,),
                onPressed: (){}
                ) //是否关注该社团
              ],),
          ),
          //社团简介部分
          ConstrainedBox(
              constraints:const  BoxConstraints(
                minHeight: 100
              ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20,top: 3),
                    child: Text("社团简介:",style: TextStyle(
                        fontWeight: FontWeight.w700,
                      color: Colors.grey[600],
                      fontSize: 16
                      )
                    ),
                  ),
                  Expanded(
                    child: Text(
                        "该社团是XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                      style: TextStyle(
                        color: Colors.grey[600],
                        height: 1.5,
                        fontSize: 14
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: Text("活动一览",style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.grey
            ),),
          )
        ],
      ),
    ),
  );
}
