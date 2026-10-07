// 【安全改写如下】
void task1NullableRewrite() {
  print('=== 任务 1：空安全改写 ===');

  // 改写点①：用安全调用 ?. 代替直接 .length
  //   隐患：nickname.length          → 可空类型直接取属性，编译不通过
  //   安全：nickname?.length         → 为 null 时短路，整体返回 null，不报错
  String? nickname = getNickname();
  print('昵称长度：${nickname?.length}'); // 输出：昵称长度：null

  // 改写点②：用 ?? 提供默认值，把 String? 安全降为 String
  //   隐患：String level = grade;     → 可空变量不能赋给不可空变量
  //   安全：String level = grade ?? '未评定';  → null 时用兜底字符串
  String? grade = getGrade();
  String level = grade ?? '未评定';
  print('等级：$level'); // 输出：等级：未评定

  // 改写点③：先判空再使用，避免空断言 ! 的风险
  //   隐患：team!.length              → team 为 null 时运行时抛 Null check 异常
  //   安全：先 if (team != null) 判空，分支内 team 被自动提升为非空
  String? team;
  if (team != null) {
    print('团队名：$team，长度：${team.length}'); // team 已被类型提升，无需 !
  } else {
    print('团队名：未加入'); // 输出：团队名：未加入
  }

  // 改写点④：对确实"保证非空"的场景用 late 延迟初始化
  //   场景：变量声明时没法赋值，但使用前一定会赋值
  late String token;
  token = fetchToken();
  print('令牌：$token'); // 输出：令牌：abc123

  print('');
}

String? getNickname() => null;
String? getGrade() => null;
String fetchToken() => 'abc123';

// 任务 2：命名参数设计 —— 实验报告生成器
String buildReport({
  required String title,
  required String author,
  required String content,
  String course = '移动应用软件开发', // 有默认值，调用时可省略
  int? score,                        // 可空，省略时为 null
}) {
  String scoreText = score == null ? '待评定' : '$score 分';
  return '【$course】$title\n作者：$author\n内容：$content\n评分：$scoreText';
}

void task2ReportGenerator() {
  print('=== 任务 2：实验报告生成器（三种调用方式）===');

  // 调用方式一：只填必填参数，其余使用默认值
  print('--- 调用一：仅必填项 ---');
  print(buildReport(
    title: 'Dart 空安全实验',
    author: '李华',
    content: '学习了 ?. 与 ?? 的用法',
  ));
  print('');

  // 调用方式二：必填项 + 部分可选项
  print('--- 调用二：必填 + 评分 ---');
  print(buildReport(
    title: 'Dart 命名参数实验',
    author: '王芳',
    content: '掌握了 required 与默认值',
    score: 95,
  ));
  print('');

  // 调用方式三：全部参数显式写出
  print('--- 调用三：全部参数显式 ---');
  print(buildReport(
    title: 'Dart 控制流实验',
    author: '陈强',
    content: '实现了成绩分级器',
    course: 'Dart 程序设计',
    score: 88,
  ));
  print('');
}

// 任务 3：成绩分级器扩展
String gradeOfExtended(int score) {
  // 第一步：先拦截非法输入，避免进入分级逻辑
  if (score < 0 || score > 100) {
    return '非法输入';
  }
  // 第二步：正常分级（100 归入优，0 归入不及格）
  if (score >= 90) return '优';   // 100 在此分支
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';                 // 0 在此分支
}

void task3GradeGrader() {
  print('=== 任务 3：成绩分级器扩展（含边界与非法输入）===');

  // 测试用例：覆盖 100、0、负数、超 100、各分段边界
  final testCases = [100, 0, -1, 120, 59, 60, 89, 90, 75];
  for (final s in testCases) {
    print('$s 分 → ${gradeOfExtended(s)}');
  }
  print('');
}

void main() {
  task1NullableRewrite();
  task2ReportGenerator();
  task3GradeGrader();
}
