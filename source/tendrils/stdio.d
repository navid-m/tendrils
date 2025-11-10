module tendrils.stdio;

extern (C) void printf(const char*, ...);
extern (C) int scanf(const char*, ...);
extern (C) int fflush(void*);
extern (C) __gshared void* stdout;
extern (C) __gshared void* stdin;
extern (C) __gshared void* fopen(const char* filename, const char* mode);
extern (C) int fclose(void* stream);
extern (C) size_t fread(void* ptr, size_t size, size_t count, void* stream);
extern (C) size_t fwrite(const void* ptr, size_t size, size_t count, void* stream);
extern (C) int fseek(void* stream, long offset, int origin);
extern (C) long ftell(void* stream);
extern (C) int vprintf(const char* fmt, void* arg);
extern (C) int fprintf(void* stream, const char* fmt, ...);
extern (C) void flushAll()
{
    auto _ = fflush(null);
}

extern (C) void print(const char* str)
{
    printf("%s", str);
    auto _ = fflush(stdout);
}

extern (C) void println(const char* str)
{
    printf("%s\n", str);
    auto _ = fflush(stdout);
}

extern (C) bool tryReadInt(ref int val) => scanf("%d", &val) == 1;
extern (C) bool tryReadFloat(ref float val) => scanf("%f", &val) == 1;
extern (C) bool tryReadString(char* buffer) => scanf("%s", buffer) == 1;

extern (C) int readIntWithDefault(int defaultValue)
{
    int val;
    return tryReadInt(val) ? val : defaultValue;
}

extern (C) float readFloatWithDefault(float defaultValue)
{
    float val;
    return tryReadFloat(val) ? val : defaultValue;
}

extern (C) int readInt()
{
    int val;
    if (!tryReadInt(val))
        assert(0, "Failed to read int");
    return val;
}

extern (C) float readFloat()
{
    float val;
    if (!tryReadFloat(val))
    {
        assert(0, "Failed to read float");
    }
    return val;
}

extern (C) void readString(char* buffer)
{
    if (!tryReadString(buffer))
    {
        assert(0, "Failed to read string");
    }
    auto _ = fflush(stdin);
}

extern (C) void printfmt(const char* fmt, ...)
{
    import core.vararg;

    va_list args;
    va_start(args, fmt);
    auto _ = vprintf(fmt, args);
    va_end(args);

    _ = fflush(stdout);
}

extern (C) void printInt(int val)
{
    printf("%d", val);
    auto _ = fflush(stdout);
}

extern (C) void printFloat(float val)
{
    printf("%f", val);
    auto _ = fflush(stdout);
}

extern (C) bool tryReadLine(char* buffer, int maxLen) => scanf("%[^\n]", buffer) == 1;

extern (C) void readLine(char* buffer, int maxLen)
{
    if (!tryReadLine(buffer, maxLen))
        assert(0, "Failed to read line");
    auto _ = fflush(stdin);
}

extern (C) bool fileExists(const char* filename)
{
    auto file = fopen(filename, "r");
    if (file)
    {
        auto _ = fclose(file);
        return true;
    }
    return false;
}

extern (C) long fileSize(void* file)
{
    auto pos = ftell(file);
    auto _ = fseek(file, 0, 2);
    auto size = ftell(file);
    _ = fseek(file, pos, 0);
    return size;
}

extern (C) size_t readFile(void* file, void* buffer, size_t size) => fread(buffer, 1, size, file);
extern (C) size_t writeFile(void* file, const void* buffer, size_t size) => fwrite(
    buffer, 1, size, file
);
