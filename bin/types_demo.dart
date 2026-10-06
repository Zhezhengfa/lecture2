void typesDemo() {
  var title = '第一次作业';
  int year = 2026;
  double score = 92.5;
  print('$title $year 成绩$score');

  String? nickname;
  print(nickname?.length); 
  print(nickname ?? '未填写'); 
}