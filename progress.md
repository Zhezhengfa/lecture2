# 进度报告2（第4周·Dart语言基础一）

> 仓库：https://github.com/Zhezhengfa/lecture2
> 姓名/学号：者正发/20251060231
> 日期：2026-10-07

## 一、任务理解

本次作业围绕 **Dart 语言基础一**展开，核心是掌握 Dart 的三大基础语法模块：**变量与类型系统（含空安全）、函数（含命名参数）、控制流语句**。具体要完成三件事：

1. **案例复现**：跟随课堂案例搭建 `dart_basics` 项目，实现 `typesDemo`、`funcDemo`、`flowDemo` 三个示例函数，并在 `main` 中统一调用，保证 `dart run` 全部输出正确、空安全无编译告警。
2. **自主实践基本要求**：完成空安全改写、命名参数设计、成绩分级器小程序、TraeCode 对拍一组，以及 AI 使用标注。
3. **代码管理**：将本次作业单独建仓库 `lecture2`，按步骤进行 Git 提交并推送到 GitHub。

**验收标准**：

- `dart run` 无报错，三个 demo 输出内容正确；
- 代码符合 Dart 空安全规范，无编译告警；
- 仓库 `lecture2` 包含完整代码、README 与进度报告，可运行。

## 二、环境与工具

| 项目 | 说明 |
|------|------|
| 操作系统 | Windows 11（x64） |
| Dart SDK | 3.13.3 (stable)，windows_x64 |
| 项目类型 | 纯 Dart 命令行工程（`dart create` 模板） |
| 运行目标 | 命令行终端（本次作业不涉及 Web/模拟器/真机） |
| 包管理 | Dart pub（含 `pubspec.yaml` / `pubspec.lock`） |
| 编辑器 | Trae CN（内置 AI 编程助手 TraeCode） |
| 版本控制 | Git，远程仓库 GitHub：`Zhezhengfa/lecture2`，分支 main |
| AI 工具 | TraeCode（代码骨架辅助、错误诊断、对拍出题与批改） |

## 三、过程记录（时间线）

1. **创建项目（10-06）**：使用 `dart create dart_basics` 生成命令行模板，得到 `bin/`、`lib/`、`test/` 目录和 `pubspec.yaml`。
2. **编写类型示例**：新建 `bin/types_demo.dart`，练习 `var`、`int`、`double`、`String?` 可空类型、`?.` 安全调用与 `??` 空合并运算符。
3. **编写函数示例**：新建 `bin/func_demo.dart`，练习命名参数（`required`、默认值、可空参数）和箭头函数（`=>`）。
4. **编写控制流示例**：新建 `bin/flow_demo.dart`，实现成绩分级函数 `gradeOf`（多分支 if）和 `for-in` 循环。
5. **修改入口文件并首次运行**：在 `bin/dart_basics.dart` 中 import 三个 demo 并在 `main` 中调用；`dart run` 报 `Directives must appear before any declarations` 与 `'main' is already declared` 两类错误。
6. **定位与修复**：原因是模板自带的旧 `main` 未删除、且 import 被写在了函数之后。将三条 import 移到文件顶部，删除模板旧 `main`，运行通过。
7. **Git 首次提交并推送**：`git init` → 提交（`ea57c46 first commit`）→ `git remote add origin` 关联 `lecture2` 仓库 → `git branch -M main` → `git push -u origin main`。
8. **TraeCode 对拍（10-06）**：让 AI 出 5 道"预测输出"题，本人先手写答案再由 AI 批改，逐题复核后整理成 `docs/ai_quiz_round1.md` 并提交（`d3b51b5`）。
9. **完成自主实践三项（10-07）**：新建 `bin/practice.dart`，包含任务1 空安全改写（4 个改写点）、任务2 命名参数实验报告生成器（3 种调用方式）、任务3 成绩分级器扩展（边界 0/100 与非法输入拦截），`dart run bin/practice.dart` 全部输出正确。
10. **提交并推送实践代码（10-07）**：提交 `227b839`；推送时一度遇到 `Connection was reset` 网络错误，确认代码已在本地安全提交后重试，推送成功，本地与 `origin/main` 同步。

## 四、关键代码（空安全改写前后对照）

以任务1 为例。辅助函数 `getNickname()`、`getGrade()` 均返回 `null`，`fetchToken()` 返回 `'abc123'`。

### 代码段 1：改写前（4 处空安全隐患）

```dart
void unsafeVersion() {
  String? nickname = getNickname();
  print('昵称长度：${nickname.length}');   // 隐患① 编译错误

  String? grade = getGrade();
  String level = grade;                    // 隐患② 编译错误
  print('等级：$level');

  String? team;
  print('团队名：$team，长度：${team!.length}'); // 隐患③ 运行时抛异常
}

// 隐患④（类成员字段场景）：非空字段声明时必须初始化，否则编译错误
// class Account {
//   String token;   // 编译错误，需改为 late String token;
// }
```

四处隐患分别是：① 对可空变量直接用 `.length`，编译不通过；② 把 `String?` 赋给 `String`，类型不兼容；③ 用空断言 `!` 强行压过编译，null 时运行时抛 `Null check operator used on a null value`；④ 非空成员字段声明时无法立即赋值，编译不通过。

### 代码段 2：改写后（`bin/practice.dart` 任务1 安全版本）

```dart
void task1NullableRewrite() {
  String? nickname = getNickname();
  print('昵称长度：${nickname?.length}');   // 改写① ?. 安全调用

  String? grade = getGrade();
  String level = grade ?? '未评定';         // 改写② ?? 提供兜底默认值
  print('等级：$level');

  String? team;
  if (team != null) {                       // 改写③ 先判空再使用
    print('团队名：$team，长度：${team.length}'); // 分支内类型自动提升，无需 !
  } else {
    print('团队名：未加入');
  }

  late String token;                        // 改写④ late 延迟初始化
  token = fetchToken();
  print('令牌：$token');
}
```

### 逐点对照解释

| 改写点 | 改写前 | 问题 | 改写后 | 原理 |
|---|---|---|---|---|
| ① | `nickname.length` | 可空变量直接取属性，**编译错误** | `nickname?.length` | `?.` 安全调用：接收者为 null 时短路返回 null，不抛异常 |
| ② | `String level = grade` | `String?` 不能赋给 `String`，**编译错误** | `grade ?? '未评定'` | `??` 空合并：左侧为 null 时取右侧值，结果类型安全降为 `String` |
| ③ | `team!.length` | 空断言 `!` 能压过编译，但 null 时**运行时抛异常** | `if (team != null) { team.length }` | 判空后分支内发生"类型提升"，`team` 自动变成非空，无需 `!`；else 分支处理 null |
| ④ | 非空字段声明时必须赋值 | 声明时拿不到值，**编译错误** | `late String token;` 使用前赋值 | `late` 承诺"使用前一定初始化"；典型用于类成员字段，违背承诺会抛 `LateInitializationError` |

**是否 AI 生成**：TraeCode 提示了 `?.`、`??`、判空类型提升、`late` 四种改写手段，四个改写点和注释由本人对照隐患逐个手写。**验证方式**：`dart run bin/practice.dart` 任务1 实际输出四行——`昵称长度：null`、`等级：未评定`、`团队名：未加入`、`令牌：abc123`，与逐点推导的结果一致；改写后代码无空安全编译告警。

## 五、检查点结果

**检查点①：`dart run` 全部输出正确 —— 通过。**

`bin/dart_basics.dart` 运行输出：

```
第一次作业 2026 成绩92.5
null
未填写
李华，18 岁，2班
8
优
第1题
第2题
第3题
```

`bin/practice.dart` 运行输出：任务1 四条（昵称长度 null、等级未评定、团队未加入、令牌 abc123）、任务2 三份报告、任务3 九个分级用例，全部与预期一致。

**检查点②：空安全无编译告警 —— 通过。**

- 所有可能为空的变量均显式声明为可空类型（`String?`、`int?`）；
- 访问可空变量时使用 `?.`、`??` 或先 `if (x != null)` 判空（分支内依赖类型提升，未滥用空断言 `!`）；
- "使用前一定赋值"的场景使用 `late`；
- 代码在编辑器中无空安全相关报错/告警。

**证据说明**：运行截图见第八节；Git 提交链 `ea57c46 → a9020a4 → d3b51b5 → 227b839` 可在 GitHub 仓库 `Zhezhengfa/lecture2` 的提交历史中核验。

## 六、问题与调试

**问题1（编译错误）：import 位置错误 + 重复的 main 函数**

- 现象：首次 `dart run` 报两组错误：`Directives must appear before any declarations`（第 6/7/8 行）和 `'main' is already declared in this scope`。
- 定位：对照报错行号查看 `bin/dart_basics.dart`，发现自己在模板自动生成的 `main` 函数**之后**追加了三条 import，并且又新写了一个 `main`，导致同一文件出现两个入口函数。
- 解决：把三条 import 全部移到文件顶部，删除模板旧 `main` 及其 package import，只保留调用三个 demo 的唯一 `main`。重跑 `dart run` 输出全部正确。
- 收获：Dart 文件结构固定为"import 在前 → 声明在后 → 唯一 main 入口"。

**问题2（Git）：在错误的目录执行 git 命令**

- 现象：在上级文件夹 `移动应用软件开发` 中执行 `git add/commit/push`，连续报 `fatal: not a git repository`。
- 定位：`git init` 是在子文件夹 `dart_basics` 中执行的，上级目录没有 `.git`。
- 解决：先 `cd dart_basics`，确认提示符路径末尾是 `dart_basics` 后再执行 git 命令，提交成功。

**问题3（网络）：推送 GitHub 时连接被重置**

- 现象：`git push` 报 `fatal: unable to access ... Recv failure: Connection was reset`。
- 定位：提交已在本地保存（`git status` 显示 ahead 2），问题出在国内访问 GitHub 的网络链路，与仓库配置无关。
- 解决：不重复提交，稍后直接重试 `git push`，推送成功，本地与 `origin/main` 同步。

## 七、AI使用记录（TraeCode）

| 序号 | 用途 | 指令摘要 | AI 输出 | 本人验证方式 |
|---|---|---|---|---|
| 1 | demo 代码骨架 | 要求生成变量类型/命名参数/控制流的示例 | 三段 demo 骨架 | 逐行读代码、改变量值，`dart run` 比对输出 |
| 2 | 编译错误诊断 | 粘贴 `Directives must appear...` 与 `main already declared` 报错 | 指出 import 位置与重复 main 两处原因 | 按提示手动修改文件并重跑通过 |
| 3 | 空安全改写思路 | 给出可空代码，要求改为安全版本 | 提示 `?.`、`??`、判空类型提升、`late` 四种手段 | 在 practice.dart 任务1 中逐个手写改写点，运行验证 4 条输出 |
| 4 | **对拍出题批改（任务4）** | 要求围绕空安全、命名参数、整除出 5 道预测输出题 | 5 道题 + 参考答案与讲解 | 先手写答案再对答案，分歧题逐题复核，整理为 `docs/ai_quiz_round1.md` |

**对拍结果**：5 题中第 1、2 题全对；第 3 题（命名参数拼接去向）、第 4 题（连续字符串插值）、第 5 题（var 类型锁死、if 条件必须为 bool）出错，已在记录中写明错因和教训。完整记录见仓库 `docs/ai_quiz_round1.md`。

**AI 使用边界**：AI 仅用于生成骨架、出题和解释报错；所有函数签名设计、答案预测、边界用例均由本人完成；AI 给的参考答案不直接照抄，对拍中有分歧的题目以自己读码复核和实际运行为准。

## 八、证据截图

> 提交雨课堂时在此处插入截图（图片无法粘贴时在雨课堂编辑器手工重新上传）。

- 截图1：**`dart run` 运行结果** —— 位置：（待插入）。说明：三个 demo 共 9 行输出全部正确。
- 截图2：**`dart run bin/practice.dart` 运行结果** —— 位置：（待插入）。说明：自主实践三任务输出，含成绩分级器 9 个边界用例。
- 截图3：**`git log --oneline` 提交记录** —— 位置：（待插入）。说明：4 次提交分别对应初始化、案例复现、对拍记录、自主实践。
- 截图4：**GitHub 仓库 lecture2 页面** —— 位置：（待插入）。说明：代码已推送到远程 main 分支。

## 九、自评

| 作业要求 | 完成情况 |
|---|---|
| 案例复现 dart_basics，代码可运行、按步骤 Git 提交 | ✅ 完成，4 次提交并推送 |
| `dart run` 全部输出正确 | ✅ 通过 |
| 空安全无编译告警 | ✅ 通过 |
| 任务1 空安全改写并解释 | ✅ practice.dart 任务1，4 个改写点均有注释 |
| 任务2 命名参数设计合理签名 | ✅ buildReport：required + 默认值 + 可空参数，3 种调用验证 |
| 任务3 控制流小程序：成绩分级器 | ✅ 含 0/100 边界与非法输入拦截，9 用例通过 |
| 任务4 TraeCode 对拍一组 | ✅ docs/ai_quiz_round1.md，5 题含批改与复核 |
| 任务5 AI 使用标注 | ✅ 本报告第七节 + 代码注释 |
| 独立仓库 lecture2（含 README） | ✅ GitHub 仓库 + README.md |
| 进度报告存入 lecture2/progress.md | ✅ 本文件 |
| 独立研究任务（const/final、类型提升、dart format，选做） | ❌ 未做，后续自学补齐 |

## 十、一句话收获与下一步计划

**一句话收获**：Dart 的空安全逼着我在写代码时就想清楚"这个变量会不会是 null"，而 `?.`、`??`、判空类型提升正好给了三种不写危险代码 `!` 的处理方式。

**遗留问题**：对拍暴露的三个薄弱点——命名参数函数体的逐行追踪、连续插值拼接、var 推断后类型锁死与 bool 条件，还需要在 DartPad 上把第 3、4、5 题重跑巩固；选做的独立研究任务尚未完成。

**下一步计划**：① 雨课堂刷"错误定位"类题目；② 自学 `const` 与 `final` 差异并做小实验；③ 预习下一课 Dart 面向对象（类与构造函数），为 Flutter 界面开发做准备。
