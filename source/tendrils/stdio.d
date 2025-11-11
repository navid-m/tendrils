module tendrils.stdio;

import core.stdc.stdio : stderr, FILE;

extern (C) void printf(const char*, ...);
extern (C) int scanf(const char*, ...);
extern (C) int fflush(FILE*);
extern (C) __gshared FILE* stdout;
extern (C) __gshared FILE* stdin;
extern (C) __gshared FILE* fopen(const char* filename, const char* mode);
extern (C) int fclose(FILE* stream);
extern (C) size_t fread(void* ptr, size_t size, size_t count, FILE* stream);
extern (C) size_t fwrite(const void* ptr, size_t size, size_t count, FILE* stream);
extern (C) int fseek(FILE* stream, long offset, int origin);
extern (C) long ftell(FILE* stream);
extern (C) int vprintf(const char* fmt, void* arg);
extern (C) int fprintf(FILE* stream, const char* fmt, ...);
extern (C) int fgetc(FILE* stream);
extern (C) int fputc(int c, FILE* stream);
extern (C) char* fgets(char* str, int n, FILE* stream);
extern (C) int fputs(const char* str, FILE* stream);
extern (C) int getchar();
extern (C) int putchar(int c);
extern (C) int ferror(FILE* stream);
extern (C) int feof(FILE* stream);
extern (C) void clearerr(FILE* stream);

/** 
 * Flushes all streams.
 */
extern (C) void flushAll()
{
    auto _ = fflush(null);
}

/** 
 * Prints a string to stdout with no terminating newline.
 *
 * Params:
 *   str = The string to print.
 */
extern (C) void print(const char* str)
{
    printf("%s", str);
    auto _ = fflush(stdout);
}

/** 
 * Prints a string to stdout with a terminating newline.
 *
 * Params:
 *   str = The string to print.
 */
extern (C) void println(const char* str)
{
    printf("%s\n", str);
    auto _ = fflush(stdout);
}

/** 
 * Prints a string to stderr with no terminating newline.
 *
 * Params:
 *   str = The string to print.
 */
extern (C) void eprint(const char* str)
{
    if (stderr)
    {
        auto _ = fprintf(stderr, "%s", str);
        _ = fflush(stderr);
    }
}

/** 
 * Prints a string to stderr with a terminating newline.
 *
 * Params:
 *   str = The string to print.
 */
extern (C) void eprintln(const char* str)
{
    if (stderr)
    {
        auto _ = fprintf(stderr, "%s\n", str);
        _ = fflush(stderr);
    }
}

/** 
 * Prints an integer to stderr with a terminating newline.
 *
 * Params:
 *   val = The integer to print.
 */
extern (C) void eprintInt(int val)
{
    if (stderr)
    {
        auto _ = fprintf(stderr, "%d\n", val);
        _ = fflush(stderr);
    }
}

/** 
 * Tries to read an integer from stdin.
 *
 * Params:
 *   val = The integer to read.
 *
 * Returns:
 *   true if the read was successful, false otherwise.
 */
extern (C) bool tryReadInt(ref int val) => scanf("%d", &val) == 1;
extern (C) bool tryReadFloat(ref float val) => scanf("%f", &val) == 1;
extern (C) bool tryReadDouble(ref double val) => scanf("%lf", &val) == 1;
extern (C) bool tryReadLong(ref long val) => scanf("%ld", &val) == 1;
extern (C) bool tryReadString(char* buffer) => scanf("%s", buffer) == 1;

/** 
 * Reads an integer from stdin with a default value.
 *
 * Params:
 *   defaultValue = The default value to return if the read fails.
 *
 * Returns:
 *   The read integer or the default value if the read fails.
 */
extern (C) int readIntWithDefault(int defaultValue)
{
    int val;
    return tryReadInt(val) ? val : defaultValue;
}

/** 
 * Reads a float from stdin with a default value.
 *
 * Params:
 *   defaultValue = The default value to return if the read fails.
 *
 * Returns:
 *   The read float or the default value if the read fails.
 */
extern (C) float readFloatWithDefault(float defaultValue)
{
    float val;
    return tryReadFloat(val) ? val : defaultValue;
}

/** 
 * Reads an integer from stdin.
 *
 * Returns:
 *   The read integer.
 */
extern (C) int readInt()
{
    int val;
    if (!tryReadInt(val))
        assert(0, "Failed to read int");
    return val;
}

/** 
 * Reads a float from stdin.
 *
 * Returns:
 *   The read float.
 */
extern (C) float readFloat()
{
    float val;
    if (!tryReadFloat(val))
    {
        assert(0, "Failed to read float");
    }
    return val;
}

/** 
 * Reads a double from stdin.
 *
 * Returns:
 *   The read double.
 */
extern (C) double readDouble()
{
    double val;
    if (!tryReadDouble(val))
    {
        assert(0, "Failed to read double");
    }
    return val;
}

/** 
 * Reads a long from stdin.
 *
 * Returns:
 *   The read long.
 */
extern (C) long readLong()
{
    long val;
    if (!tryReadLong(val))
    {
        assert(0, "Failed to read long");
    }
    return val;
}

/** 
 * Reads a string from stdin.
 *
 * Returns:
 *   The read string.
 */
extern (C) void readString(char* buffer)
{
    if (!tryReadString(buffer))
    {
        assert(0, "Failed to read string");
    }
    auto _ = fflush(stdin);
}

/** 
 * Prints a formatted string to stdout.
 *
 * Params:
 *   fmt = The format string.
 *   ... = The arguments to the format string.
 */
extern (C) void printfmt(const char* fmt, ...)
{
    import core.vararg;

    va_list args;
    va_start(args, fmt);
    auto _ = vprintf(fmt, args);
    va_end(args);

    _ = fflush(stdout);
}

/** 
 * Prints an integer to stdout.
 *
 * Params:
 *   val = The integer to print.
 */
extern (C) void printInt(int val)
{
    printf("%d", val);
    auto _ = fflush(stdout);
}

/** 
 * Prints an integer to stdout with a newline.
 *
 * Params:
 *   val = The integer to print.
 */
extern (C) void printlnInt(int val)
{
    printf("%d\n", val);
    auto _ = fflush(stdout);
}

/** 
 * Prints a float to stdout.
 *
 * Params:
 *   val = The float to print.
 */
extern (C) void printFloat(float val)
{
    printf("%f", val);
    auto _ = fflush(stdout);
}

/** 
 * Prints a float to stdout with a newline.
 *
 * Params:
 *   val = The float to print.
 */
extern (C) void printlnFloat(float val)
{
    printf("%f\n", val);
    auto _ = fflush(stdout);
}

/** 
 * Prints a double to stdout.
 *
 * Params:
 *   val = The double to print.
 */
extern (C) void printDouble(double val)
{
    printf("%lf", val);
    auto _ = fflush(stdout);
}

/** 
 * Prints a long to stdout.
 *
 * Params:
 *   val = The long to print.
 */
extern (C) void printLong(long val)
{
    printf("%ld", val);
    auto _ = fflush(stdout);
}

/** 
 * Tries to read a line from stdin.
 *
 * Params:
 *   buffer = The buffer to store the read line.
 *   maxLen = The maximum length of the line to read.
 *
 * Returns:
 *   true if the read was successful, false otherwise.
 */
extern (C) bool tryReadLine(char* buffer, int maxLen)
{
    if (fgets(buffer, maxLen, stdin) !is null)
    {
        int len = 0;
        while (buffer[len] != '\0')
            len++;
        if (len > 0 && buffer[len - 1] == '\n')
            buffer[len - 1] = '\0';
        return true;
    }
    return false;
}

/** 
 * Reads a line from stdin.
 *
 * Params:
 *   buffer = The buffer to store the read line.
 *   maxLen = The maximum length of the line to read.
 */
extern (C) void readLine(char* buffer, int maxLen)
{
    if (!tryReadLine(buffer, maxLen))
        assert(0, "Failed to read line");
}

/** 
 * Reads a single character from stdin.
 *
 * Returns:
 *   The character read, or -1 on error/EOF.
 */
extern (C) int readChar() => getchar();

/** 
 * Writes a single character to stdout.
 *
 * Params:
 *   c = The character to write.
 */
extern (C) void writeChar(int c)
{
    auto _ = putchar(c);
    _ = fflush(stdout);
}

/** 
 * Checks if end-of-file has been reached for a stream.
 *
 * Params:
 *   file = The file stream to check.
 *
 * Returns:
 *   true if EOF has been reached, false otherwise.
 */
extern (C) bool isEof(FILE* file) => feof(file) != 0;

/** 
 * Checks if an error has occurred on a stream.
 *
 * Params:
 *   file = The file stream to check.
 *
 * Returns:
 *   true if an error has occurred, false otherwise.
 */
extern (C) bool hasError(FILE* file) => ferror(file) != 0;

/** 
 * Clears the error and EOF indicators for a stream.
 *
 * Params:
 *   file = The file stream to clear.
 */
extern (C) void clearError(FILE* file)
{
    clearerr(file);
}

/** 
 * Checks if a file exists.
 *
 * Params:
 *   filename = The name of the file to check.
 *
 * Returns:
 *   true if the file exists, false otherwise.
 */
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

/** 
 * Gets the size of a file.
 *
 * Params:
 *   file = The file to get the size of.
 *
 * Returns:
 *   The size of the file.
 */
extern (C) long fileSize(FILE* file)
{
    auto pos = ftell(file);
    auto _ = fseek(file, 0, 2);
    auto size = ftell(file);
    _ = fseek(file, pos, 0);
    return size;
}

/** 
 * Reads a file.
 *
 * Params:
 *   file = The file to read.
 *   buffer = The buffer to store the read file.
 *   size = The size of the file to read.
 *
 * Returns:
 *   The number of bytes read.
 */
extern (C) size_t readFile(FILE* file, void* buffer, size_t size) => fread(buffer, 1, size, file);

/** 
 * Writes a file.
 *
 * Params:
 *   file = The file to write.
 *   buffer = The buffer to write the file from.
 *   size = The size of the file to write.
 *
 * Returns:
 *   The number of bytes written.
 */
extern (C) size_t writeFile(FILE* file, const void* buffer, size_t size) => fwrite(
    buffer, 1, size, file
);

/** 
 * Formats a string into a provided buffer without D runtime dependencies.
 * Supports standard printf format specifiers.
 *
 * Params:
 *   buffer = The buffer to write the formatted string to.
 *   bufferSize = The size of the buffer.
 *   fmt = The format string.
 *   ... = The arguments to format.
 *
 * Returns:
 *   The number of characters written (excluding null terminator), or -1 on error.
 */
extern (C) int formatToBuffer(char* buffer, size_t bufferSize, const char* fmt, ...)
{
    import core.vararg;
    import core.stdc.stdio : vsnprintf;

    va_list args;
    va_start(args, fmt);
    scope (exit)
        va_end(args);

    int result = vsnprintf(buffer, bufferSize, fmt, args);
    return result;
}
