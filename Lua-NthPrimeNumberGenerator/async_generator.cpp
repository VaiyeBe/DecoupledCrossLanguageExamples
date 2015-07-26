
#include <templatious/FullPack.hpp>

#include <LuaPlumbing/messageable.hpp>

#include "async_generator.h"

TEMPLATIOUS_TRIPLET_STD;

struct AsyncPrimeNumberGen : public Messageable {

    void message(templatious::VirtualPack& pack) {

    }

    void message(const StrongPackPtr& pack) {
        // not needed, only we send updates
    }

private:
    typedef std::unique_ptr< templatious::VirtualMatchFunctor > VmfPtr;

    VmfPtr genHandler() {
        typedef AsyncPrimeGenerator APG;
        SF::virtualMatchFunctorPtr(
            SF::virtualMatch< APG::AsyncJob, StrongMsgPtr, int, int >(
                [=](APG::AsyncJob,StrongMsgPtr& msg,int to,int update) {

                }
            )
        );
    }
};

StrongMsgPtr AsyncPrimeGenerator::makeGenerator() {

}

