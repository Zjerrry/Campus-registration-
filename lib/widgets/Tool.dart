

//固定长度文字截断
String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

//KMP算法实现搜索内容对比
int StrStr(String KnowValue,String Searchvalue)
{
  List next = build_next(Searchvalue);

  int i = 0;
  int j = 0;
  while(i < KnowValue.length)
  {
    if(KnowValue[i] == Searchvalue[j])
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

//获取当前时间
class getTime
{
  DateTime nowTime = DateTime.now();

  int getTitleTime()
  {
    if(nowTime.hour >= 6 && nowTime.hour <= 9)  { return 0;}
    else if(nowTime.hour > 9 && nowTime.hour <= 12)  {return 1;}
    else if(nowTime.hour > 12 && nowTime.hour <= 18) {return 2;}
    else if(nowTime.hour > 18 && nowTime.hour <= 11) {return 3;}
    else {return 4;}

  }

}