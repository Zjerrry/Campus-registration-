import 'package:flutter/material.dart';
import 'ClubMainPage.dart';
import 'package:test_fist/widgets/ClubSearch.dart';
import 'package:test_fist/widgets/Tool.dart';


class Clublistpage extends StatefulWidget {
  const Clublistpage({super.key});

  @override
  State<Clublistpage> createState() => _ClublistpageState();
}

class _ClublistpageState extends State<Clublistpage> {
  static String SearchValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TopSearchBar(
            lable: "搜索社团",
            SearchValue: SearchValue,
            onSearch: (value){
              setState(() {
                SearchValue = value;
                Search(SearchValue);
              });
            },
        ),
      ),
      body: ClubList_Body()
    );
  }
}


//社团列表
class ClubList_Body extends StatefulWidget {
  const ClubList_Body({super.key});

  @override
  State<ClubList_Body> createState() => _ClubList_BodyState();
}

class _ClubList_BodyState extends State<ClubList_Body> {
  List dataList = _ClublistpageState.SearchValue != "" ? searchClub:allClub;
  @override
  Widget build(BuildContext context) {//改为瀑布流式布局，待解决
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8
        ),
        itemCount: _ClublistpageState.SearchValue.isNotEmpty ? searchClub.length:allClub.length,
        itemBuilder: (context,index){
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Container(
                    //alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5
                      ),]
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)
                                {
                                  return ClubMainPage(
                                    clubname:_ClublistpageState.SearchValue.isNotEmpty ? searchClub[index]:allClub[index] ,
                                  );
                                })
                        );
                      },
                      child: AspectRatio(
                          aspectRatio: 1.065,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius:  const BorderRadius.vertical(top: Radius.circular(20)),
                                child: AspectRatio(
                                    aspectRatio: 1,//图片尺寸
                                  child: Image.network("https://s3-alpha-sig.figma.com/img/4a92/272c/15495ba4b99f0c27386610b0fb8af758?Expires=1742774400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=j3j6eWQEj56i-AS6o9HDN0GG9mMKTsfOe4pZH08fLvHvAi~Wcpm8VRO-93vlIChrYffVEpQbKG9xm2wWI7EwtcWfSoPxdjrVmCKD5thR2oDVwk3YfSvqWLltzuYO6CXgcPqHxhmvtODVNnQstDLGT7iXtlJJ7-8F5mFUnXFTDQI035DX2BGvuCoL2ad8rhQhy8Y6lA36z1a3TTbwF1cXE216kD6d4WTXWx6jakwSaeW9~1gNZipuD~PIeRkRxmYImDaY2Z8lYCFJjlbC138s6gthr7DhhjznTTT99-n-4XHRJP6XAWMRjHFtF-oKMGUWCGyyPNEMKAafeEm9AUY~uQ__",
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container( // 错误处理
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                child: Text(truncateText(_ClublistpageState.SearchValue.isNotEmpty ? searchClub[index]:allClub[index], 10),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                      ),
                    )
                ),

          );
        }
    );
  }
}

