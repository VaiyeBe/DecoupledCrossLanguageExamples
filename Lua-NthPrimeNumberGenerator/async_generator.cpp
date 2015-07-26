
#include <templatious/FullPack.hpp>

#include <LuaPlumbing/messageable.hpp>

#include "async_generator.h"

TEMPLATIOUS_TRIPLET_STD;

namespace {

void asyncRoutine(StrongMsgPtr& msg,int to,int updateMS) {

}

}

struct AsyncPrimeNumberGen : public Messageable {

    AsyncPrimeNumberGen() : _handler(genHandler()) {}

    void message(templatious::VirtualPack& pack) {
        _handler->tryMatch(pack);
    }

    void message(const StrongPackPtr& pack) {
        // not needed, only we send updates
    }

private:
    typedef std::unique_ptr< templatious::VirtualMatchFunctor > VmfPtr;

    VmfPtr genHandler() {
        typedef AsyncPrimeGenerator APG;
        return SF::virtualMatchFunctorPtr(
            SF::virtualMatch< APG::AsyncJob, StrongMsgPtr, int, int >(
                [=](APG::AsyncJob,StrongMsgPtr& msg,int to,int update) {
                    asyncRoutine(msg,to,update);
                }
            )
        );
    }

    VmfPtr _handler;
};

StrongMsgPtr AsyncPrimeGenerator::makeGenerator() {

}

