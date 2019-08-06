// Initialization

struct Fahrenheit {
  var temperature: Double
  init() {
    temperature = 32.0
  }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")


// Customizing Initialization
// Initialization Parameters
struct Celsius {
  var temperatureInCelsius: Double
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32) / 1.8
  }
  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

// Parameter names and Argument Labels
struct Color {
  let red, green, blue: Double
  init(red: Double, green: Double, blue: Double) {
    self.red   = red
    self.green = green
    self.blue  = blue
  }
  init(white: Double) {
    red     = white
    green   = white
    blue    = white
  }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
//let verGreen = Color(0.0, 1.0, 0.0)
// Compile time error because external names for parameters were omitted

// Initializer Parameters Without Argument Labels
struct Celsius2 {
  var temperatureInCelsius: Double
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32) / 1.8
  }
  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }
  init(_ celsius: Double) {
    temperatureInCelsius = celsius
  }
}
let bodyTemperature = Celsius2(37.0)


// Optional Property Types
class SurveyQuestion {
  var text: String
  var response: String?
  init(text: String) {
    self.text = text
  }
  func ask() {
    print(text)
  }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."


// Assigning Constant Properties during Initialization
class SurveyQuestion2 {
  let text: String
  var response: String?
  init(text: String) {
    self.text = text
  }
  func ask() {
    print(text)
  }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"


// Default Initializer
class ShoppingListItem {
  var name: String?
  var quantity = 1
  var purchased = false
}
var item = ShoppingListItem()


// Memberwise Initializers for Structure Types
// Because both stored properties have a default value, the Size structure automatically receives an init(width:height:) memberwise initializer, which you can use to initialize a new Size instance:
struct Size {
  var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)


// Initializer Delegation for Value Types
// 值类型的初始化器委托
//struct Size2 {
//    var width = 0.0, height = 0.0
//}
struct Point {
  var x = 0.0, y = 0.0
}
struct Rect {
  var origin = Point()
  var size = Size()
  init() {} // 默认初始化器
  init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
    //初始化器可以调用其他初始化器来执行部分实例的初始化。
  }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))


//指定初始化器和便捷初始化器语法

//用与值类型的简单初始化器相同的方式来写类的指定初始化器：
//init(parameters) {
//  statements
//}

//便捷初始化器有着相同的书写方式，但是要用 convenience 修饰符放到 init 关键字前，用空格隔开：
//convenience init(parameters) {
//  statements
//}

// Class Inheritance and Initialization
// Rule 1
//   Designated initializers must call a designated initializer from their immediate superclass
// Rule 2
//   Convenience initializers must call another initializer available in the same class
// Rule 3
//   Convenience initializers must ultimately end up calling a designated initializer
// Designated initializers must always delegate up. Convenience initializers must always delegate across

// Initialization is a 2 stage process. There are several safety checks that the compiler performs
// Safety Check 1
//   A deignated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass
// Safety Check 2
//   A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn't, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization
// Safety Check 3
//   A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn't, the new value the convenience initializer assigns will be overwritten by its own class's designated initializer.
// Safety Check 4
//   An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

// Two-Phase initialization
// Phase 1
// - A designated or convenience initializer is called on a class
// - Memory for a new instance of that class is allocated. The memory is not yet initialized.
// - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
// - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
// - This continues up the class inheritance chain until the top of the chain is reached.
// - Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance's memory is considered to be fully initialized, and phase 1 is complete.
//
// Phase 2
// - Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
// - Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.

// Initializer Inheritance and Overriding
class Vehicle {
  var numberOfWheels = 0
  var description: String {
    return "\(numberOfWheels) wheel(s)"
  }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
  override init() { // 这个指定初始化器和 Bicycle 的父类的指定初始化器相匹配，所以 Bicycle 中的指定初始化器需要带上 override 修饰符。
    super.init()  // 以调用 super.init() 开始，这个方法作用是调用父类的初始化器。
    // 这样可以确保 Bicycle 在修改属性之前它所继承的属性 numberOfWheels 能被 Vehicle 类初始化。
    numberOfWheels = 2
  }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")


// Automatic Initializers
// Rule 1
//   If your subclass doesn't define any designated initializers, it automatically inherits all of its superclass designated initializers
// Rule 2
//   If your subclass provides an implementaction of all of its superclass designated initializers- either by inheriting them as per rule 1, or by providing a custom implementation as part of its definitition- the it automatically inherits all of the superclass convenience initializers.


// Designated and Convenience Initializers in Action
class Food {
  var name: String
  init(name: String) {// 指定
    self.name = name
  }
  convenience init() {//便捷
    self.init(name: "[Unnamed]")
  }
}
let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food {
  var quantity: Int
  init(name: String, quantity: Int) {   //指定
    self.quantity = quantity
    super.init(name: name)
  }
  override convenience init(name: String) {  //便捷
    self.init(name: name, quantity: 1)
  }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

//  In this example, the superclass for RecipeIngredient is Food, which has a single convenience initializer called init(). This initializer is therefore inherited by RecipeIngredient. The inherited version of init() functions in exactly the same way as the Food version, except that it delegates to the RecipeIngredient version of init(name: String) rather than the Food version.


class ShoppingListItem2: RecipeIngredient {
  var purchased = false
  var description: String {
    var output = "\(quantity) x \(name)"
    output += purchased ? " √" : " ✘"
    return output
  }
}

//  Because ShoppingListItem2 provides a default value for all of the properties it introduces and does not define any initializers itself, ShoppingListItem automatically inherits all of the designated and convenience initializers from its superclass. ShoppingListItem2(name: "Eggs, quantity: 6),
var breakfastList = [
  ShoppingListItem2(),
  ShoppingListItem2(name: "Bacon"),
  ShoppingListItem2(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
  print(item.description)
}


// 可失败初始化器 Failable Initializers
#if swift(>=3.1)
let wholeNumber: Double = 12345.0
let pi = 3.14159

if Int(exactly: wholeNumber) != nil {
  // if let valueMaintained = Int(exactly: wholeNumber) {
  print("\(wholeNumber) conversion to int maintains value")
}

let valueChanged = Int(exactly: pi)

if valueChanged == nil {
  print("\(pi) conversion to int does not maintain value")
}
#endif

struct Animal {
  let species: String
  init?(species: String) {  //定义一个可失败初始化器，有形式参数 species
    if species.isEmpty { return nil } // 如果发现了一个空字符串，初始化失败被触发。
    self.species = species  // 否则，就设置 species 属性的值，然后初始化成功
  }
}

let someCreature = Animal(species: "Giraffe")
// is of type Animal?, not Animal
print(someCreature!)

if let giraffe = someCreature {
  print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
print(anonymousCreature as Any)
if anonymousCreature == nil {
  print("The anonymous creature could not be initialized")
}

// 枚举的可失败初始化器 Failable Initializers for Enumerations

enum TemperatureUnit {
  case Kelvin, Celsius, Fahrenheit
  init?(symbol: Character) {
    switch symbol {
    case "K":
      self = .Kelvin
    case "C":
      self = .Celsius
    case "F":
      self = .Fahrenheit
    default:
      return nil  // 当参数的值不能与任意一枚举成员相匹配时，该枚举类型初始化失败
    }
  }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}

// Failable Initializers for Enumerations with Raw Values
// 带有原始值的枚举会自动获得一个可失败初始化器 init?(rawValue:) ，该可失败初始化器接收一个名为 rawValue 的合适的原始值类型形式参数如果找到了匹配的枚举情况就选择其一，或者没有找到匹配的值就触发初始化失败。
enum TempUnit: Character {
  case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrUnit = TempUnit(rawValue:"F")
if fahrUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit2 = TempUnit(rawValue: "X")
if unknownUnit2 == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}

// Propagation of Initialization Failure
// 初始化失败的传递
// Failable initializers for value types can trigger failure at any point. For classes, however a failable initializer can trigger an initialization failure only after all stored properties introduced by that class have been set to an initial value.
// 类，结构体或枚举的可失败初始化器可以横向委托到同一个类，结构体或枚举里的另一个可失败初始化器。类似地，子类的可失败初始化器可以向上委托到父类的可失败初始化器。

class Product {
  let name: String!
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
  }
}

class CartItem: Product {
  let quantity: Int
  init?(name: String, quantity: Int) {
    if quantity < 1 { return nil }
    self.quantity = quantity
    super.init(name: name)
    // 如果你委托到另一个初始化器导致了初始化失败，那么整个初始化过程也会立即失败，并且之后任何初始化代码都不会执行。
  }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
  print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

// 如果你创建了一个 CartItem 实例， quantity 的值为 0 ， CartItem 初始化器会导致初始化失败
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
  print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
  print("Unable to initialize zero shirts")
}

// 如果你尝试创建一个 CartItem 实例，并且令 name 为空值，那么父类 Product 的初始化器就会导致初始化失败
if let oneUnnamed = CartItem(name: "", quantity: 1) {
  print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
  print("Unable to initialize one unnamed product")
}


// 重写可失败初始化器 Overriding a Failable Initializer
class Document {
  var name: String?
  // this initializer creates a document with a nil name value
  init() {}
  // this initializer creates a document with a non-empty name value
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
  }
}

class AutomaticallyNamedDocument: Document {
  override init() {
    super.init()
    self.name = "[Untitled]"
  }
  override init(name: String) {
    super.init()
    if name.isEmpty {
      self.name = "[Untitled]"
    } else {
      self.name = name
    }
  }
}

class UntitledDocument: Document {
  override init() {
    super.init(name: "[Untitled]")!
  }
}


// 可失败初始化器 init! The init! Failable Initializer
// 也可以使用可失败初始化器创建一个隐式展开具有合适类型的可选项实例。通过在 init 后面添加惊叹号( init! )是不是问号。

// Required Initializers
class SomeClass {
  required init() {
    // Initializer implementation goes here
  }
}

class SomeSubclass: SomeClass {
  required init() {
    // subclass implementation of the required initializer goes here
  }
}

// Setting a default Property Value with a Closure or Function
class SomeOtherClass {
  let someProperty: Int = {
    // create a default value for someProperty inside this closure
    // someValue must be of the same type as SomeType
    return 1234
  }() //闭包 提供默认值给属性
}
//  Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
// 如果你使用了闭包来初始化属性，请记住闭包执行的时候，实例的其他部分还没有被初始化。这就意味着你不能在闭包里读取任何其他的属性值，即使这些属性有默认值。你也不能使用隐式 self 属性，或者调用实例的方法。

struct Chessboard {
  let boardColors: [Bool] = {
    var temporaryBoard = [Bool]()
    var isBlack = false
    for i in 1...8 {
      for j in 1...8 {
        temporaryBoard.append(isBlack)
        isBlack = !isBlack
      }
      isBlack = !isBlack
    }
    return temporaryBoard
  }()
  func squareIsBlackAt(row: Int, column: Int) -> Bool {
    return boardColors[(row * 8) + column]
  }
}
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))

