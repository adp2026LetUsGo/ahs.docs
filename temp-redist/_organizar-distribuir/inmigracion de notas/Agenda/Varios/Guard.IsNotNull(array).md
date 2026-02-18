`Guard.IsNotNull(array)` is a method call in C# that checks whether the `array` parameter is null or not. [If the parameter is null, it throws an `ArgumentNullException`](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard)[1](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard). [This method is part of the **Community Toolkits for .NET** and can be used to validate method arguments in a streamlined manner, which is also faster, less verbose, more expressive, and less error-prone than manually writing checks and throwing exceptions](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard)[1](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard).

I hope this helps!


What is the difference between Guard.IsNotNull and if(array == null)?

`Guard.IsNotNull(array)` and `if(array == null)` are both used to check whether an array is null or not in C#. However, there are some differences between the two:

- `Guard.IsNotNull(array)` is a method call in C# that checks whether the `array` parameter is null or not. [If the parameter is null, it throws an `ArgumentNullException`](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses)[1](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses). [This method is part of the **Community Toolkits for .NET** and can be used to validate method arguments in a streamlined manner, which is also faster, less verbose, more expressive, and less error-prone than manually writing checks and throwing exceptions](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses)[1](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses).
    
- `if(array == null)` is a conditional statement that checks whether the `array` is null or not. If the array is null, it executes the code block inside the if statement. [Otherwise, it skips the code block and continues with the next statement](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses)[2](https://stackoverflow.com/questions/69267179/what-is-the-difference-between-is-not-null-and-null).
    

In summary, `Guard.IsNotNull(array)` is a more concise and expressive way of checking whether an array is null or not, while `if(array == null)` is a more traditional way of doing the same thing.

I hope this helps!


Learn more

[1![](blob:https://www.bing.com/8a00b2f1-ae60-49fe-a161-b6d827e6d368)stackoverflow.com](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses)[2![](blob:https://www.bing.com/8a00b2f1-ae60-49fe-a161-b6d827e6d368)stackoverflow.com](https://stackoverflow.com/questions/69267179/what-is-the-difference-between-is-not-null-and-null)[3![](blob:https://www.bing.com/8a00b2f1-ae60-49fe-a161-b6d827e6d368)stackoverflow.com](https://stackoverflow.com/questions/10677669/when-should-i-guard-against-null)




What is the difference between Guard.IsNotNull and Guard.IsNull?

[`Guard.IsNotNull` and `Guard.IsNull` are both methods in the **Community Toolkits for .NET** that can be used to validate method arguments in a streamlined manner](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard) [1](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard). However, they have different purposes:

- `Guard.IsNotNull` is used to check whether an object is null or not. [If the object is null, it throws an `ArgumentNullException`](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard)[1](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard).
    
- `Guard.IsNull` is used to check whether an object is null or not. [If the object is not null, it throws an `ArgumentException`](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard)[1](https://learn.microsoft.com/en-us/dotnet/communitytoolkit/diagnostics/guard).
    

In summary, `Guard.IsNotNull` is used to ensure that an object is not null, while `Guard.IsNull` is used to ensure that an object is null.

I hope this helps!


Can I use Guard.IsNull for other types of variables?

[`Guard.IsNull` is a method in the **Community Toolkits for .NET** that can be used to validate method arguments in a streamlined manner](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses) [1](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses). However, it is specifically designed to check whether an object is null or not. [If the object is not null, it throws an `ArgumentException`](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses)[1](https://stackoverflow.com/questions/29184887/best-way-to-check-for-null-parameters-guard-clauses).

If you want to check whether a variable of a different type is null or not, you can use the `==` operator to compare it with `null`. For example, to check whether a string variable is null or not, you can use the following code:

```csharp
if (myString == null)
{
    // Do something
}
```

Similarly, you can use the `==` operator to check whether variables of other types are null or not.

I hope this helps!

How do I write a custom guard method in C#?

To write a custom guard method in C#, you can create a static method in a static class for your desired purpose. [You can then call it wherever needed](https://medium.com/@mwaseemzakir/ep-38-how-to-use-guard-clauses-in-c-6b46f7491e2d) [1](https://medium.com/@mwaseemzakir/ep-38-how-to-use-guard-clauses-in-c-6b46f7491e2d). Here is an example:

```csharp
public static class Guard
{
    public static void IsNotNull(object obj, string paramName)
    {
        if (obj == null)
        {
            throw new ArgumentNullException(paramName);
        }
    }

    public static void IsNull(object obj, string paramName)
    {
        if (obj != null)
        {
            throw new ArgumentException("Parameter must be null", paramName);
        }
    }
}
```

In this example, we have created a `Guard` class with two methods: `IsNotNull` and `IsNull`. The `IsNotNull` method checks whether the `obj` parameter is null or not. [If the parameter is null, it throws an `ArgumentNullException`](https://medium.com/@mwaseemzakir/ep-38-how-to-use-guard-clauses-in-c-6b46f7491e2d)[2](https://code-maze.com/csharp-guard-clauses/). The `IsNull` method checks whether the `obj` parameter is null or not. [If the parameter is not null, it throws an `ArgumentException`](https://medium.com/@mwaseemzakir/ep-38-how-to-use-guard-clauses-in-c-6b46f7491e2d)[2](https://code-maze.com/csharp-guard-clauses/).

You can use these methods in your code to validate method arguments in a streamlined manner.

I hope this helps!