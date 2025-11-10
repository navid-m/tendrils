module tendrils.minstdio;

extern (C) void printf(const char*, ...);
extern (C) int scanf(const char*, ...);
extern (C) int fflush(void*);
extern (C) __gshared void* stdout;
extern (C) __gshared void* stdin;

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
extern (C) bool tryReadString(char* buffer, int maxLen) => scanf("%s", buffer) == 1;

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

extern (C) void readString(char* buffer, int maxLen)
{
    if (!tryReadString(buffer, maxLen))
    {
        assert(0, "Failed to read string");
    }
    auto _ = fflush(stdin);
}
