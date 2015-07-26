
#include <templatious/FullPack.hpp>

#include <LuaPlumbing/messageable.hpp>

#include "async_generator.h"

struct AsyncPrimeNumberGen : public Messageable {

    void message(templatious::VirtualPack& pack) {

    }

    void message(const StrongPackPtr& pack) {

    }
};

StrongMsgPtr AsyncPrimeGenerator::makeGenerator() {

}

