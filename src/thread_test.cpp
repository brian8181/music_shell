#include <chrono>
#include <iostream>
#include <syncstream>
#include <thread>
using namespace std::chrono_literals;
 
void foo()
{
    std::thread::id this_id = std::this_thread::get_id();
 
    std::osyncstream(std::cout) << "thread " << this_id << " sleeping...\n";
 
    std::this_thread::sleep_for(500ms);
}
 
int main()
{
    std::jthread t1{foo};
    std::jthread t2{foo};
}