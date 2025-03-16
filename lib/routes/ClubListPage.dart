import 'package:flutter/material.dart';
import 'ClubMainPage.dart';

List allClub = ["天外天工作室","青年志愿者协会XXXXXXXXXXXXXXXXXXX","学生会","天津大学校园建设发展协会（北洋讲解队）","abcdef","abc"];//全部社团列表
List searchClub = [];//筛选后的社团列表

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

//顶部搜索栏
class TopSearchBar extends StatefulWidget {
  const TopSearchBar({super.key,required this.lable,required this.onSearch});

  final String lable;
  final Function(String) onSearch;

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  FocusNode _focusNode = FocusNode();//焦点
  //String SearchValue = "";
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    //屏幕尺寸
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      width: queryData.size.width ,
      height: 40,
      padding: EdgeInsets.only(left: 20,right: 20),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child:Padding(
          padding: EdgeInsets.all(5),
          child:TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: false,
            decoration: InputDecoration(
                hintText: widget.lable,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                icon: const Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(Icons.search,
                    size: 20,
                    color: Colors.blue,
                  ),),
                //输入后显示的清除输入内容按键
                suffixIcon: _ClublistpageState.SearchValue.isNotEmpty ?
                  IconButton(onPressed: ()
                  {
                    setState(() {
                      _ClublistpageState.SearchValue = "";
                      _controller.clear();
                      //Search(_ClublistpageState.SearchValue);
                    });
                  }, icon: Icon(Icons.close)):null,

                ),
            onChanged: (value){
              setState(() {
                _ClublistpageState.SearchValue = value;
              });
            },
            onSubmitted: (value){
              widget.onSearch(value);
              },
        ),
      ),

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
                                child: Text("${_ClublistpageState.SearchValue.isNotEmpty ? searchClub[index]:allClub[index]}",
                                  style: TextStyle(
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
//搜索筛选的实现
void Search(String SearchValue)
{
  searchClub = [];//初始化筛选列表
  if(SearchValue == "") {
    return;
  }
  for(int i=0;i<allClub.length;i++)
    {
      if(allClub[i].length<SearchValue.length)
        continue;
      if(StrStr(allClub[i], SearchValue) >= 0)
        {
          searchClub.add(allClub[i]);
        }
    }
}
//KMP算法实现搜索内容对比
int StrStr(String Clubname,String Searchvalue)
{
  List next = build_next(Searchvalue);

  int i = 0;
  int j = 0;
  while(i < Clubname.length)
    {
      if(Clubname[i] == Searchvalue[j])
      {
        i++;
        j++;
      }
      else if(j>0)
        {
          j = next[j-1];
        }
      else
        {
          i++;
        }
      if(j == Searchvalue.length)
      {
        return i-j;
      }
    }
    return -1;
}

List build_next(String Searchvalue)
{
  List next = [0];
  int prefix_len = 0;
  int i = 1;
  while(i<Searchvalue.length)
    {
      if(Searchvalue[prefix_len] == Searchvalue[i])
        {
          prefix_len++;
          next.add(prefix_len);
          i++;
        }
      else
        {
          if(prefix_len == 0)
            {
              next.add(0);
              i++;
            }
          else
          {
            prefix_len = next[prefix_len];
          }
        }
    }
    return next;
}

