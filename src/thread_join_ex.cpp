#include <iostream>
#include <chrono>
#include <thread>
 
void foo()
{
    // simulate expensive operation
    std::this_thread::sleep_for(std::chrono::seconds(5));
    std::cout << " helper1 done!\n";
}
 
void bar()
{
    // simulate expensive operation
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << " helper2 done!\n";
}
 
int main(int argc, char* argv[])
{
    std::cout << "starting first helper...\n";
    std::thread helper1(foo);
 
    std::cout << "starting second helper...\n";
    std::thread helper2(bar);
    std::cout << "waiting for helpers to finish..." << std::endl;
 
    helper1.join();
    helper2.join();
    std::cout << "done!\n";
}