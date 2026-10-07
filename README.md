# lecture2 · Dart 语言基础一

第 4 周课堂作业 2：Dart 语言基础（变量与类型、空安全、函数与命名参数、控制流）。

- 远程仓库：https://github.com/Zhezhengfa/lecture2
- 开发环境：Windows 11 + Dart SDK 3.13.3 (stable)
- 作业进度报告：见 [progress.md](progress.md)

## 目录结构

```
dart_basics/
├── bin/
│   ├── dart_basics.dart   # 案例复现入口：依次调用三个 demo
│   ├── types_demo.dart    # 变量类型与空安全（var/int/double、String?、?.、??）
│   ├── func_demo.dart     # 命名参数（required/默认值/可空）与箭头函数
│   ├── flow_demo.dart     # 控制流：成绩分级 if 分支 + for-in 循环
│   └── practice.dart      # 自主实践：空安全改写/命名参数/分级器扩展
├── docs/
│   └── ai_quiz_round1.md  # TraeCode 对拍记录（5 题，含批改与复核）
├── lib/
├── test/
└── progress.md            # 进度报告（十节）
```

## 运行方式

```bash
# 案例复现：三个 demo
dart run

# 自主实践：空安全改写、报告生成器、分级器扩展
dart run bin/practice.dart
```

## 任务清单

| 任务 | 文件 | 状态 |
|---|---|---|
| 案例复现 dart_basics | bin/*_demo.dart | 已完成 |
| 空安全改写 | bin/practice.dart 任务1 | 已完成 |
| 命名参数设计 | bin/practice.dart 任务2 | 已完成 |
| 成绩分级器 | bin/practice.dart 任务3 | 已完成 |
| TraeCode 对拍一组 | docs/ai_quiz_round1.md | 已完成 |
| AI 使用标注 | progress.md 第七节 | 已完成 |

## Git 提交记录

```
227b839 feat: 完成空安全改写/命名参数/成绩分级器三项实践，修复入口文件
d3b51b5 docs: ai quiz round 1 records
a9020a4 feat: types/func/flow demos all pass
ea57c46 first commit
```
