# HW #2 분석 보고서 초안

## 1. Statement-Level Control Structures

1번 문제는 `0`을 sentinel로 사용하여 반복을 즉시 종료하고, 음수를 positive segment의 경계로 처리한다. C는 배열 인덱스를 직접 증가시키는 `for` 반복문을 사용했기 때문에 현재 위치, 현재 구간 시작점, 현재 합을 모두 명시적으로 관리한다. Python은 `enumerate`를 사용하여 값과 인덱스를 함께 순회하고, Ruby는 `each_with_index` 블록을 사용한다. Ada는 배열 범위인 `Data'Range`를 기반으로 반복하고, `exit`로 sentinel 종료를 표현한다.

조건문과 반복문의 역할은 네 언어에서 동일하지만 표현 방식은 다르다. C는 가장 기계적이고 명시적이며, Python과 Ruby는 반복 대상 자체를 중심으로 코드를 작성한다. Ruby의 `next`는 현재 블록 반복을 건너뛰는 역할을 하며 C/Python의 `continue`와 대응된다. Ada의 `exit`는 반복문을 종료하는 역할로 C/Python/Ruby의 `break`와 비슷하지만, Ada 문법에서는 반복문 제어가 더 구조적으로 드러난다.

가독성 측면에서는 Python 구현이 가장 단순하다. `enumerate`가 인덱스와 값을 동시에 제공하고, `None`을 사용해 현재 segment가 없는 상태를 자연스럽게 표현할 수 있기 때문이다. C는 포인터나 배열 크기 등 저수준 요소를 직접 관리해야 하므로 코드가 길어지는 반면, Ada는 타입과 범위가 명확해 안전하지만 문법이 더 엄격하다.

## 2. Subprogram-Based Data Processing

2번 문제는 조건 판단과 변환 동작을 `process` 함수에 직접 작성하지 않고, predicate와 transformer라는 subprogram parameter로 전달하는 것이 핵심이다. Python과 Lua는 함수를 값처럼 다루고 closure를 지원하므로 `make_greater_than(threshold)`가 threshold를 내부에 보존한 predicate 함수를 반환한다. transformer도 내부 count를 closure 상태로 유지하고, 호출될 때마다 count를 증가시킨다.

Ruby 구현은 lambda를 사용해 predicate와 transformer를 표현했다. Ruby의 블록과 lambda는 함수형 값을 전달하는 데 적합하며, `.call`을 통해 간접 호출한다. C는 closure가 없으므로 `struct`에 상태와 function pointer를 함께 넣었다. predicate는 threshold를 구조체 필드로 가지고, transformer는 count와 apply 함수를 함께 가진다. `process`는 이 구조체의 function pointer를 호출하므로, C에서도 subprogram parameter와 간접 호출 구조를 흉내낼 수 있다.

이 문제에서 side effect는 transformer 호출 시 count가 증가하는 부분에서 발생한다. 장점은 변환 횟수를 별도 순회 없이 자연스럽게 기록할 수 있다는 점이다. 단점은 함수 호출이 내부 상태를 변경하므로 완전한 순수 함수보다 테스트와 추론이 어려워진다는 점이다. 특히 C에서는 상태가 어디에 저장되는지 명시적으로 설계해야 하고, closure 기반 언어보다 구현이 장황하다.

## 3. ADT-Based Encapsulation and OOP Extension

3번 문제는 `Counter`의 내부 값 `value`를 외부에서 직접 접근하지 못하게 하고, 공개 연산을 통해서만 조작하도록 설계한다. C++에서는 `protected`와 `public` 접근 제어자를 사용하고, `increment`, `decrement`, `print_info`를 `virtual`로 선언하여 동적 바인딩을 가능하게 했다. Objective-C는 `@interface`와 `@implementation`으로 인터페이스와 구현을 분리하고, 메시지 전송 방식으로 메서드를 호출한다. Ruby는 인스턴스 변수 `@value`와 메서드 인터페이스를 사용하며, 관례적으로 외부 직접 접근을 제한한다. Ada는 package와 private type, tagged type extension으로 ADT와 OOP 확장을 표현한다.

`BoundedCounter`와 `StepCounter`는 모두 `Counter`의 특수한 형태이므로 is-a 관계로 볼 수 있다. `BoundedCounter`는 최대값 제한을 추가하고 `increment`를 override한다. `StepCounter`는 증가/감소 단위인 step을 추가하고 `increment`와 `decrement`를 override한다. 공통 인터페이스는 유지하지만 실제 동작은 하위 타입마다 달라진다.

다형성은 같은 리스트/배열에 여러 counter 객체를 저장하고 동일한 메서드를 호출할 때 드러난다. C++에서는 base class pointer 또는 reference를 통해 `virtual` 함수가 실제 객체 타입에 맞게 호출된다. Objective-C와 Ruby는 런타임 메시지 디스패치를 사용하므로 객체가 받은 메시지를 자신의 클래스에 맞게 처리한다. Ada는 tagged type과 dispatching call을 통해 실제 태그에 해당하는 overriding procedure를 선택한다.

ADT 중심 설계는 데이터 은닉과 연산 인터페이스를 강조하고, OOP 중심 설계는 여기에 상속, overriding, dynamic binding을 추가한다. Ada package는 ADT 경계를 분명히 보여주며, C++/Objective-C/Ruby의 class 기반 설계는 객체 생성과 상속 관계를 더 직접적으로 표현한다.

## 테스트 메모

1번의 기본 입력 `[3, 5, -2, 4, 6, -1, 2, 8, 0, 100, 7]`에서는 두 구간 `[4, 6]`, `[2, 8]`의 합이 모두 10이지만, 먼저 등장한 `[4, 6]`을 선택하여 `max_sum = 10`, `start = 3`, `end = 4`가 출력된다.

2번은 `threshold = 2`, 변환 함수 `value * 2`를 사용했다. 선택되는 값은 `3, 4, 5, 8`이고 변환 결과 합은 `6 + 8 + 10 + 16 = 40`이다. transformer 호출 횟수는 `4`이다.

3번은 각 객체에 대해 같은 `increment`와 `print_info`를 호출해도 실제 객체 타입에 따라 출력과 값 변화가 달라지는 것을 확인한다.
