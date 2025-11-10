module source;

public import tendrils.minstdio;

unittest
{
	auto x = [123];
	x ~= 200;

	assert(x.length == 2);
	assert(x[0] == 123);
	assert(x[1] == 200);
	printInt(cast(int)x.length);
	println("\nHello, world");
	print("Testing ");
	println("print()");
	printInt(42);
	printFloat(3.14);
	println("");
}
