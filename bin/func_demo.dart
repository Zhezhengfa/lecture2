void enroll({required String name, int age = 18, String? className}) {
  print('$name，$age 岁，${className ?? "未分班"}');
}
int add(int a, int b) => a + b;

void funcDemo() {
  enroll(name: '李华', className: '2班');
  print(add(3, 5));
}