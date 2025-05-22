#if defined(WIN32) || defined(_WIN32)
#define EXPORT_SYMBOL __declspec(dllexport)
#else
#define EXPORT_SYMBOL __attribute__ ((visibility("default")))
#endif

#define TOKEN_CONCAT(a, b) a##b
#define WRAPPED_PY_MODULE(name) \
    extern "C" void *TOKEN_CONCAT(Wrapped_PyInit_, name)(); \
    extern "C" EXPORT_SYMBOL void *TOKEN_CONCAT(PyInit_, name)() { \
        return TOKEN_CONCAT(Wrapped_PyInit_, name)(); \
    }

WRAPPED_PY_MODULE(WRAPPED_PY_MODULE_NAME)
