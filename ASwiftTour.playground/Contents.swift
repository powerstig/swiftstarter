import UIKit

var str = "Hello, playground"

//简单值
var myVar = 42
myVar = 50
let myConst = 42
//myConst = 50  //Cannot assign to value: 'myConst' is a 'let' constant

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
// 实验 - Create a constant with an explicit type of Float and a value of 4.
let explicitFloat: Float = 4

// 值绝对不会隐式转换为其他类型 Values are never implicitly converted to another type.
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
// 实验 - Try removing the conversion to String from the last line. What error do you get?
// let widthLabel2 = label + width // Binary operation '+' cannot be applied to operands of type 'String and 'Int'

// 插值字符串：将值写在圆括号里，再在圆括号的前面加一个反斜杠
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples"
let fruitSummary = "I have \(apples + oranges) pieces of fruit"
// Experiment - Use \() to include a floating-point calculation in a string and to include someone’s name in a greeting.
let π: Float = 3.14
let name = "Peter Pie"
let piePy = "\(name) likes the number \(π)"

let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
