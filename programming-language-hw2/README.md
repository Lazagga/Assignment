# HW #2 Implementation of Various Imperative Languages

이 폴더는 과제 PDF 요구사항에 맞춰 3개 문제를 언어별로 구현한 제출 초안입니다.

## 폴더 구조

- `problem1/`: Statement-level control structures
  - C, Python, Ruby, Ada
- `problem2/`: Subprogram-based data processing
  - C, Python, Ruby, Lua
- `problem3/`: ADT and OOP extension
  - C++, Objective-C, Ruby, Ada
- `report/report.md`: 분석 보고서 초안

## 실행 예시

로컬 컴파일러가 있으면 아래 명령으로 실행할 수 있습니다.

```powershell
python .\problem1\maximum_positive_segment.py
python .\problem2\stateful_pipeline.py
```

다른 언어는 컴파일러/인터프리터가 설치되어 있어야 합니다.

```powershell
gcc .\problem1\maximum_positive_segment.c -o p1_c.exe
.\p1_c.exe

ruby .\problem1\maximum_positive_segment.rb

gnatmake .\problem1\maximum_positive_segment.adb
.\maximum_positive_segment.exe

gcc .\problem2\stateful_pipeline.c -o p2_c.exe
.\p2_c.exe

ruby .\problem2\stateful_pipeline.rb
lua .\problem2\stateful_pipeline.lua

g++ .\problem3\counter.cpp -o p3_cpp.exe
.\p3_cpp.exe

ruby .\problem3\counter.rb
gnatmake .\problem3\counter.adb
.\counter.exe
```

Objective-C는 Windows 기본 환경에서 바로 실행하기 어렵습니다. macOS 또는 GNUstep/clang 환경에서 컴파일하거나 OneCompiler와 같은 웹 실행 환경을 사용할 수 있습니다.

## 구현상 가정

2번 문제의 `make_transformer()`는 PDF에서 구체적인 변환 수식이 지정되어 있지 않아 `value * 2`로 구현했습니다. 중요한 요구사항은 변환 자체보다 `transformer`가 호출 횟수 상태를 유지하고 `process`가 subprogram parameter를 통해 간접 호출한다는 점입니다.
