
#include <templatious/FullPack.hpp>

#include <LuaPlumbing/messageable.hpp>

#include "async_generator.h"

TEMPLATIOUS_TRIPLET_STD;

typedef AsyncPrimeGenerator APG;

namespace {

bool isPrime(int number) {
    int count = 0;
    for (int i = 1; i <= number; ++i) {
        if (number % i == 0) {
            ++count;
        }
    }
    return count == 2;
}

long currentMillis() {
    static auto referencePoint = std::chrono::high_resolution_clock::now();

    return std::chrono::duration_cast< std::chrono::milliseconds >(
        std::chrono::high_resolution_clock::now() - referencePoint
    ).count();
}

void asyncRoutine(StrongMsgPtr& msg,int to,int updateMS) {
    WeakMsgPtr weak = msg;
    std::thread([=]() {
        int primeCount = 0;
        int i = 1;
        long lastCount = currentMillis();
        while (primeCount < to) {
            ++i;
            if (isPrime(i)) {
                ++primeCount;
                long curr = currentMillis();
                if (curr - lastCount >= updateMS) {
                    // lock weak pointer
                    auto locked = weak.lock();
                    if (weak.expired()) {
                        // object to notify dead,
                        // return
                        return;
                    }

                    auto update = SF::vpackPtr< APG::AsyncUpdate, int >(nullptr,primeCount);
                    locked->message(update);

                    lastCount = curr;
                }
            }
        }

        auto locked = weak.lock();
        if (weak.expired()) {
            // object to notify dead,
            // return
            return;
        }
        auto update = SF::vpackPtr< APG::AsyncFinish, int >(nullptr,i);

    }).detach();
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
    return std::make_shared< AsyncPrimeNumberGen >();
}

