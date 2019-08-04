// Closures Chapter from From: Apple Inc. “The Swift Programming Language.” iBooks. https://itun.es/au/jEUH0.l

//  Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.
// 在函数章节中有介绍的全局和内嵌函数，实际上是特殊的闭包。闭包符合如下三种形式中的一种：
// 1.全局函数是一个有名字但不会捕获任何值的闭包；
// 2.内嵌函数是一个有名字且能从其上层函数捕获值的闭包；
// 3.闭包表达式是一个轻量级语法所写的可以捕获其上下文中常量或变量值的没有名字的闭包。

// Swift 闭包表达式拥有简洁的风格，常见的优化包括：
// 利用上下文推断形式参数和返回值的类型；
// 单表达式的闭包可以隐式返回；
// 简写实际参数名；
// 尾随闭包语法。


// 闭包表达式 Closure Expressions
// 闭包表达式是一种在简短行内就能写完闭包的语法。

// The Sort Function
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
} // backward(_:_:)
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
// sorted(by:) 方法接收一个 接收两个与数组内容相同类型的实际参数 的闭包，然后返回一个 Bool 值来说明第一个值在排序后应该出现在第二个值的前边还是后边。如果第一个值应该出现在第二个值之前，排序闭包需要返回 true ，否则返回 false

// 闭包表达式语法 Closure Expression Syntax
reversedNames = names.sorted(by: { (s1:String, s2: String) -> Bool in return s1 > s2 })
// names.sorted(by: <#T##(String, String) throws -> Bool#>)
// 注意：闭包表达式语法能够使用 常量形式参数、变量形式参数 和 输入输出形式参数，但不能提供默认值。
// 可变形式参数也能使用，但需要在形式参数列表的最后面使用。元组也可被用来作为形式参数和返回类型。

// Inferring Type from from Context
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })

// Implicit returns from Single-Expression Closures
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 })

// Shorthand Argument Names
reversedNames = names.sorted(by: { $0 > $1 })

// Operator Functions
reversedNames = names.sorted(by: >)


// 尾随闭包 Trailing Closures
func someFunctionThatTakesAClosure(closure: () -> ()) {
    //function body goes here
}
// 不使用尾随闭包的形式调用函数
someFunctionThatTakesAClosure(closure: {
  //closure's body goes here
})
// 使用尾随闭包的形式调用函数
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

reversedNames = names.sorted() { $0 > $1 }
reversedNames = names.sorted { $0 > $1 }  //如果闭包表达式被用作函数唯一的实际参数并且你把闭包表达式用作尾随闭包，那么调用这个函数的时候你就不需要在函数的名字后面写一对圆括号

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4:"Four",
    5: "Five", 6:"Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

// Swift 的 Array 类型中有一个以闭包表达式为唯一的实际参数的 map(_:) 方法。
let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
strings
//  在上面这个例子中尾随闭包语法在函数后整洁地封装了具体的闭包功能，而不再需要将整个闭包包裹在 map(_:) 方法的括号内。

// 捕获值 Capturing Values
// 一个闭包能够从上下文捕获已被定义的常量和变量。
// 即使定义这些常量和变量的原作用域已经不存在，闭包仍能够在其函数体内引用和修改这些值。
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
// incrementer() 函数是没有任何形式参数， runningTotal 和 amount 不是来自于函数体的内部，而是通过捕获主函数的 runningTotal 和 amount 把它们内嵌在自身函数内部供使用。
// 当调用 makeIncrementer  结束时通过引用捕获来确保不会消失，并确保了在下次再次调用 incrementer 时， runningTotal 将继续增加。

var incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()  //该常量指向一个每次调用会加 10 的函数。
incrementByTen()
incrementByTen()
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementByTen()  //再次调用原来增量器 ( incrementByTen )  继续增加它自己的变量 runningTotal 的值，并且不会影响 incrementBySeven 捕获的变量 runningTotal 值：

incrementByTen = makeIncrementer(forIncrement: 100)
incrementByTen()
incrementByTen()


// 闭包是引用类型 Closures are Reference Types
// 无论你什么时候赋值一个函数或者闭包给常量或者变量，你实际上都是将常量和变量设置为对函数和闭包的引用。
// 这些常量指向的闭包仍可以增加已捕获的变量 runningTotal 的值。这是因为函数和闭包都是引用类型。

let alsoIncrementByTen = incrementByTen //赋值一个闭包到两个不同的常量或变量中，这两个常量或变量都将指向相同的闭包：
alsoIncrementByTen()

// 逃逸闭包 Escaping Closures
// 当闭包作为一个实际参数传递给一个函数的时候，我们就说这个闭包逃逸了，因为它可以在函数返回之后被调用。
var completionHandlers: [() -> Void] = []
func soneFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        soneFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x) // Prints "200"

//自动闭包 : ## Autoclosures
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )

//: Even though the first element of the customersInLine array is removed as part of the closure, that operation isn't carried out until the closure is actually called. If the closure is never called, the expression inside the closure is never evaluated. Note that the type of nextCustomer is not String but () -> String - a function that takes no arguments and returns a string.

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0) )

//: The serveNextCustomer function above takes an explicit closure that returns the next customer's name. The version below performs the same operation but, instead uses an autoclosure. Now you can call the function as if it took a String argument instead of a closure.


//: ### @autoclosure(escaping)

var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}











