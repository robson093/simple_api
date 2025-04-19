using SimpleApi;

namespace SimpleApi.Tests;

public class UnitTest1
{
    [Fact]
    public void SumOK()
    {
        Calculator calc = new Calculator();
        int result = calc.Sum(1,2);
        Assert.Equal(result, 3);
    }

    [Fact]
    public void SumError()
    {
        Calculator calc = new Calculator();
        int result = calc.Sum(1,2);
        Assert.Equal(result, 4);
    }
}
