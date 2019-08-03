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
// 实验 - Use \() to include a floating-point calculation in a string and to include someone’s name in a greeting.
let π: Float = 3.14
let name = "Peter Pie"
let piePy = "\(name) likes the number \(π)"

// 三个双引号，来一次输入多行内容
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""

// 数组
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
shoppingList

// 字典
var occupations = [
  "Malcom": "Captain",
  "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
occupations

// Initialising an empty array or dict
let emptyArray = [String]()
var emptyDictionary = [String: Float]()

shoppingList = []
emptyDictionary = [:]


// 控制流
// 逻辑判断 if switch
// 循环 for-in for while repeat-while
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
  if score > 50 {
    teamScore += 3
  } else {
    teamScore += 1
  }
}
teamScore

// 可选值
// 在一个值得类型后面使用问号 ？ 来把某个值标记为可选的
let nickName: String? = nil
let fullName: String = "John"
let informalGreetings: String = "hi \(nickName ?? fullName)"

// Switches
// 执行完switch语句里匹配的case之后，就从语句中退出。
let vegetable = "red pepper"
switch vegetable {
  case "celery":
    let _ = "Add some raisins and make ants on a log."
  case "cucumber", "watercress":
    let _ = "That would make a good tea sandwich."
  case let x where x.hasSuffix("pepper"):
    let _ = "Is it a spicy \(x)?"
  default:
    let _ = "Everything tastes good in soup."
}
// if default: is removed we get the error "Switch must be exhaustive". This means that every
// possible option must be included in the switch/case statement so that the result cannot be
// undefined.

// for-in 循环 (Also tuples)
let interestingNumbers = [
  "Prime": [2,3,5,7,11,13],
  "Fibonacci": [1,1,2,3,5,8],
  "Square": [1,4,9,16,25],
]
var largest = 0
var largestKind = ""
for (kind, numbers) in interestingNumbers {
  for number in numbers {
    if number > largest {
      largest = number
      largestKind = kind
    }
  }
}
largest
largestKind

// while and repeat-while loops
var n = 2
while n < 100 {
  n = n * 2
}
n

var m = 2
repeat {
  m = m * 2
} while m < 100
m

// 使用 ..< 来创造序列区间
var total = 0
for i in 0..<4 {
  total += i
}
total

// 函数 and 闭包
func greet(person: String, day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

//Experiment - Remove the day parameter. Add a parameter to include today’s lunch special in the greeting.
func greet(person: String, special: String) -> String {
  return "Hello \(person), todays lunch special is: \(special)"
}
greet(person: "Bob", special:"Chicken Parmigiana")

func greet(_ person: String, on day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")


// Use a tuple to make a compound value - for example, to return multiple values from a function. The elements of a tuple can be referred to either by name or by number
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
  var min = scores[0]
  var max = scores[0]
  var sum = 0
  
  for score in scores {
    if score > max {
      max = score
    } else if score < min {
      min = score
    }
    sum += score
  }
  return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
statistics.sum
statistics.2
