#include <iostream>
#include <memory>
#include <vector>

class Counter {
protected:
    int value;

public:
    Counter() : value(0) {}
    virtual ~Counter() = default;

    virtual void increment() {
        value++;
    }

    virtual void decrement() {
        value--;
    }

    void reset() {
        value = 0;
    }

    int get_value() const {
        return value;
    }

    virtual void print_info() const {
        std::cout << "Counter value = " << value << '\n';
    }
};

class BoundedCounter : public Counter {
private:
    int max_value;

public:
    explicit BoundedCounter(int max_value) : max_value(max_value) {}

    void increment() override {
        if (value < max_value) {
            value++;
        }
    }

    void print_info() const override {
        std::cout << "BoundedCounter value = " << value
                  << ", max = " << max_value << '\n';
    }
};

class StepCounter : public Counter {
private:
    int step;

public:
    explicit StepCounter(int step) : step(step) {}

    void increment() override {
        value += step;
    }

    void decrement() override {
        value -= step;
    }

    void print_info() const override {
        std::cout << "StepCounter value = " << value
                  << ", step = " << step << '\n';
    }
};

int main() {
    Counter normal;
    BoundedCounter bounded(2);
    StepCounter stepped(3);

    normal.increment();
    bounded.increment();
    bounded.increment();
    bounded.increment();
    stepped.increment();
    stepped.decrement();

    std::vector<std::unique_ptr<Counter>> counters;
    counters.push_back(std::make_unique<Counter>());
    counters.push_back(std::make_unique<BoundedCounter>(1));
    counters.push_back(std::make_unique<StepCounter>(5));

    for (const auto &counter : counters) {
        counter->increment();
        counter->print_info(); // virtual dispatch calls the actual type.
    }

    return 0;
}
