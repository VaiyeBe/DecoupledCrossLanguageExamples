#ifndef ASYNC_GENERATOR_HGCV21D5
#define ASYNC_GENERATOR_HGCV21D5

#include <memory>

struct Messageable;

#define DUMMY_STRUCT(name) \
    struct name { template <class T> name(T&&) {} };

struct AsyncPrimeGenerator {

    // signature:
    // < AsyncJob, int (number), int (update interval, milliseconds) >
    DUMMY_STRUCT(AsyncJob);

    // signature:
    // < AsyncUpdate, int (progress) >
    DUMMY_STRUCT(AsyncUpdate);

    // signature:
    // < AsyncFinish, int (the number) >
    DUMMY_STRUCT(AsyncFinish);

    static std::shared_ptr< Messageable > makeGenerator();
};

#endif /* end of include guard: ASYNC_GENERATOR_HGCV21D5 */
