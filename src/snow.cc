
#include <iostream>

#include "standard.hh"
#include "reader.hh"

using namespace snow;

int
main(int argc, char* argv[])
{
    vector<string> args(argv, argv + argc);
   
    if (argc != 2) {
        std::cout << "Usage:" << std::endl;
        std::cout << args[0] << " [file.sn]" << std::endl;
        return 1;
    }

    Source* ss = read_file(args[1]);
    std::cout << ss->text << std::endl;

    return 0;
}
