module source;

public import tendrils.stdio;

unittest
{
	auto x = [123];
	x ~= 200;

	printInt(cast(int)x.length);
	println("\nHello, world");
	print("Testing ");
	println("print()");
	printInt(42);
	printFloat(3.14);
	println("");

	auto fl = readFloat();
	printFloat(fl);
}
