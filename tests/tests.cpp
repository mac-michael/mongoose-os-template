#include <cstdio>
#include <gtest/gtest.h>
#include "../include/Module.h"

int run();
extern "C" void helper();

int main(int argc, char **argv) {
	::testing::InitGoogleTest(&argc, argv);
	int res = RUN_ALL_TESTS();

	return res;
}

// TODO cannot link with mgos used functionality - extract logic
TEST(Tests, Test) {

	helper();
	run();
	//Module m;

	//m.start();
}

TEST(Tests, Test2) {

	//helper();
	run();
//	Module m;
//
//	m.start();
}