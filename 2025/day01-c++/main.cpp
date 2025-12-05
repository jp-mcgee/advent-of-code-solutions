#include <cstdint>
#include <fstream>
#include <iostream>
#include <string>

void part_1(const char* filename)
{
    std::ifstream in_file(filename);

    uint64_t password = 0;
    int32_t lock = 50;
    static constexpr int32_t LOCK_MIN = 0;
    static constexpr int32_t LOCK_MAX = 100;

    for(std::string line; std::getline(in_file, line); )
    {
        const char direction = line[0];
        const int x = std::stoi(line.erase(0, 1));
        if (direction == 'R')
        {
            // go right
            lock = (lock + x) % LOCK_MAX;
        }
        else if (direction == 'L')
        {
            // go left
            lock = ((lock - x) % LOCK_MAX) + LOCK_MAX;
            if (lock == LOCK_MAX)
            {
                lock = LOCK_MIN;
            }
        }

        if(lock == LOCK_MIN)
        {
            ++password;
        }
    }
    std::cout << password << std::endl;
}

void part_2(const char* filename)
{
    std::ifstream in_file(filename);

    uint64_t password = 0;
    int32_t lock = 50;
    static constexpr int32_t LOCK_MIN = 0;
    static constexpr int32_t LOCK_MAX = 100;

    for(std::string line; std::getline(in_file, line); )
    {
        const char direction = line[0];
        const int x = std::stoi(line.erase(0, 1));
        if (direction == 'R')
        {
            // go right
            password += x / LOCK_MAX;
            lock += x % LOCK_MAX;
            if(lock >= LOCK_MAX)
            {
                ++password;
                lock -= LOCK_MAX;
            }
        }
        else if (direction == 'L')
        {
            // go left
            const int32_t prev_lock = lock; 
            password += x / LOCK_MAX;
            lock -= x % LOCK_MAX;

            if(lock <= LOCK_MIN && prev_lock != 0)
            {
                ++password;
            }

            if(lock < LOCK_MIN)
            {
                lock += LOCK_MAX;
            }
        }
    }
    std::cout << password << std::endl;
}

int main(int argc, char** argv)
{
    if(argc < 2) return 1;

    part_1(argv[1]);
    part_2(argv[1]);

    return 0;
}