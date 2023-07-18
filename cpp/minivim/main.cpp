#include "minivim.hpp"

int main( int argc , char **argv )
{
	auto minivim = std::make_shared<MiniVim>("");

	if(argc > 1) minivim = std::make_shared<MiniVim>(argv[1]);
	minivim->run();
	return EXIT_SUCCESS;
}

