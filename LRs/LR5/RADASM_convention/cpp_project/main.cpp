#include <iostream>

// cdecl is supported even on UNIX
extern "C" void __fastcall STR_DEL_REPEATS(char* str);

int main() {
    std::cout << "Input text (max symbols: 255)" << std::endl;
    std::string input_str;
    std::getline(std::cin, input_str);

    if ((input_str.size() <= 255) && (!input_str.empty())) {
        char* str_ = new char[255];
        strcpy(str_, input_str.c_str());

        // call asm module with str_
        // CALL
        // STR_DEL_REPEATS(str_);

        // 0 - end of the output code
        std::cout << str_;

        delete[] str_;
    } else {
        std::cout << "Invalid input";
    }


    return 0;
}
