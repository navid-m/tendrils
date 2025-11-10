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

extern (C) int readInt()
{
    int val;
    auto _ = scanf("%d", &val);
    return val;
}

extern (C) float readFloat()
{
    float val;
    auto _ = scanf("%f", &val);
    return val;
}

extern (C) void readString(char* buffer, int maxLen)
{
    auto _ = scanf("%s", buffer);
    _ = fflush(stdin);
}
