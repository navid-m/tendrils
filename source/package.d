module source;

public import tendrils.stdio;

unittest
{
	auto x = [123];
	x ~= 200;
	printInt(cast(int) x.length);
	println("\nHello, world");
	print("Testing ");
	println("print()");
	printInt(42);
	printFloat(3.14);
	println("");
	auto fl = readFloat();
	printFloat(fl);
}

unittest
{
    println("\n=== Testing formatted output ===");
    printfmt("Integer: %d, Float: %.2f, String: %s\n", 42, 3.14159, cast(const char*)"test");
    
    char[100] buffer;
    auto len = formatToBuffer(buffer.ptr, buffer.length, cast(const char*)"Value: %d", 999);
    println(buffer.ptr);
    printfmt("Formatted %d characters\n", len);
}

unittest
{
	println("\n=== Testing numeric types ===");
	printlnInt(12_345);
	printlnFloat(2.71828);
	printDouble(1.4142135);
	println("");
	printLong(987_654_321_0L);
	println("");
}

unittest
{
	println("\n=== Testing stderr (should appear on stderr) ===");
	eprint("Error: ");
	eprintln("Something went wrong!");
	eprintInt(404);
}

unittest
{
	println("\n=== Testing character I/O ===");
	writeChar('A');
	writeChar('B');
	writeChar('C');
	println("");
}

unittest
{
	println("\n=== Testing file operations ===");

	auto file = fopen("test_output.txt", "w");
	if (file)
	{
		const char* testData = "Hello from file!\n";
		size_t len = 0;
		while (testData[len] != '\0')
			len++;

		auto written = writeFile(file, testData, len);
		printfmt("Wrote %zu bytes\n", written);
		fclose(file);
		println("File written successfully");
	}

	if (fileExists("test_output.txt"))
	{
		println("File exists: test_output.txt");

		auto rf = fopen("test_output.txt", "r");
		if (rf)
		{
			auto size = fileSize(rf);
			printfmt("File size: %ld bytes\n", size);

			char[256] readBuffer;
			auto bytesRead = readFile(rf, readBuffer.ptr, cast(size_t) size);
			readBuffer[bytesRead] = '\0';

			print("File contents: ");
			println(readBuffer.ptr);
			printfmt("EOF: %d, Error: %d\n", isEof(rf) ? 1 : 0, hasError(rf) ? 1 : 0);

			fclose(rf);
		}
	}
}

unittest
{
	println("\n=== Testing buffer formatting ===");
	char[50] smallBuffer;
	auto len1 = formatToBuffer(smallBuffer.ptr, smallBuffer.length, "Test %d", 123);
	printfmt("Formatted: %s (length: %d)\n", smallBuffer.ptr, len1);
	auto len2 = formatToBuffer(smallBuffer.ptr, smallBuffer.length,
		"This is a very long string with number %d that should truncate", 999);
	printfmt("Truncated: %s (attempted length: %d)\n", smallBuffer.ptr, len2);
}

unittest
{
	println("\n=== Testing multiple numeric types ===");
	int i = 42;
	float f = 3.14f;
	double d = 2.718281828;
	long l = 123_456_789_012_3L;

	printfmt("int: %d, float: %f, double: %lf, long: %ld\n", i, f, d, l);
}

unittest
{
	println("\n=== Testing flush operations ===");
	print("Buffered output 1...");
	print("Buffered output 2...");
	print("Buffered output 3...");
	flushAll();
	println("\nAll buffers flushed!");
}


unittest
{
	println("\n=== Testing error handling ===");

	auto file = fopen("nonexistent_for_error_test.txt", "r");
	if (!file)
	{
		println("Expected: File not found (this is correct)");
	}

	file = fopen("error_test.txt", "w");
	if (file)
	{
		fputs("test data\n", file);
		fflush(file);

		printfmt("Has error: %d, Is EOF: %d\n",
			hasError(file) ? 1 : 0,
			isEof(file) ? 1 : 0);

		clearError(file);
		println("Errors cleared");

		fclose(file);
	}
}

unittest
{
	println("\n=== Performance test ===");
	println("Writing 1000 integers...");

	auto file = fopen("perf_test.txt", "w");
	if (file)
	{
		for (int i = 0; i < 1000; i++)
		{
			fprintf(file, "%d\n", i);
		}
		fclose(file);
		println("Performance test completed");
	}
}
