// Enumerations

//  An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.

enum CompassPoint {
  case north
  case south
  case east
  case west
}

enum Planet {
  case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west

directionToHead = .east


// Matching Enumeration Values with a Switch Statement
directionToHead = .south
switch directionToHead {
case .north:
  print("Lots of planets have a north")
case .south:
  print("Watch out for penguins")
case .east:
  print("Where the sun rises")
case .west:
  print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
  print("Mostly Harmless")
default:
  print("Not a safe place for humans")
}

// 遍历枚举情况（case）
// 包含对应枚举类型所有情况的集合名为 allCases
enum Beverage: CaseIterable {
  case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"

for beverage in Beverage.allCases {
  print(beverage)
} // 标记枚举遵循 CaseIterable 协议

// 关联值 Associated Values
// 定义一个叫做 Barcode的枚举类型，
enum Barcode {
  case upc(Int, Int, Int, Int)  //要么用 (Int, Int, Int, Int)类型的关联值获取 upc 值
  case qrCode(String) //要么用 String 类型的关联值获取一个 qrCode的值
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//Barcode类型的常量和变量可以存储一个 .upc或一个 .qrCode（和它们的相关值一起存储）中的任意一个，但是它们只可以在给定的时间内存储它们它们其中之一。

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
  print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
  print("QR code: \(productCode).")
}

productBarcode = Barcode.upc(8, 85909, 51226, 3)
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
  print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
  print("QR code: \(productCode).")
}


// 原始值 Raw Values
// 枚举成员可以用相同类型的默认值预先填充（称为原始值）。
enum ASCIIControlCharacter: Character {
  case tab = "\t"
  case lineFeed = "\n"
  case carriageReturn = "\r"
}

// 隐式指定的原始值 Implicitly Assigned Raw Values
enum PlanetRaw: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
} //当整数值被用于作为原始值时，每成员的隐式值都比前一个大一。如果第一个成员没有值，那么它的值是 0 。

let earthsOrder = PlanetRaw.earth.rawValue
// earthsOrder is 3

enum CompassPointRaw: String {
  case north, south, east, west
} //当字符串被用于原始值，那么每一个成员的隐式原始值则是那个成员的名称

// 可以用 rawValue属性来访问一个枚举成员的原始值
let sunsetDirection = CompassPointRaw.west.rawValue
// sunsetDirection is "West"


// Initializing from a Raw Value
let possiblePlanet = PlanetRaw(rawValue: 7)

let positionToFind = 11
if let somePlanet = PlanetRaw(rawValue: positionToFind) {
  switch somePlanet {
  case .mars:
    print("Mars era")
  case .earth:
    print("Mostly harmless")
  default:
    print("Not a safe place for humans")
  }
} else {
  print("There isn't a planet at position \(positionToFind)")
}


// Recursive Enumerations
enum ArithmeticExpression {
  case number(Int)
  indirect case addition(ArithmeticExpression, ArithmeticExpression)
  indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression2 {
  case number(Int)
  case addition(ArithmeticExpression2, ArithmeticExpression2)
  case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
  switch expression {
  case .number(let value):
    return value
  case let .addition(lhs, rhs):
    return evaluate(lhs) + evaluate(rhs)
  case let .multiplication(lhs, rhs):
    return evaluate(lhs) * evaluate(rhs)
  }
}

print(evaluate(product))



