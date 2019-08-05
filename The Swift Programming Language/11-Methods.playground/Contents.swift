// Methods Chapter

// 实例方法 Instance Methods
class Counter {
  var count = 0
  func increment() {
    count += 1
    // self.count += 1
  }
  func increment(by amount: Int) {
    count += amount
  }
  func reset() {
    count = 0
  }
}
let counter = Counter()
counter.increment()
counter.increment(by:5)
counter.reset()


// The self Property
// 每一个类的实例都隐含一个叫做 self的属性
//  Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use this implicit self property to refer to the current instance within its own instance methods.
struct Point {
  var x = 0.0, y = 0.0
  func isToTheRightOf(x: Double) -> Bool {
    return self.x > x
  }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
  print("This point is to the right of the line where x == 1.0")
}


// 在实例方法中修改值类型 Modifying Value Types from Within
// Instance Methods
//  if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method.
struct Point2 {
  var x = 0.0, y = 0.0
  mutating func moveBy(x deltaX: Double, y deltaY:Double) {
    x += deltaX
    y += deltaY
  } // 异变方法
}
var somePoint2 = Point2(x: 1.0, y: 1.0)
somePoint2.moveBy(x:2.0, y:3.0)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")

let fixedPoint = Point2(x: 3.0, y: 3.0)
//fixedPoint.moveBy(2.0, y: 3.0)
// this will report an error because fixedPoint is a constant
// 不能在常量结构体类型里调用异变方法，因为自身属性不能被改变

// 在异变方法里指定自身 Assigning to self Within a Mutating Method
struct Point3 {
  var x = 0.0, y = 0.0
  mutating func moveByX(deltaX: Double, y deltaY: Double) {
    self = Point3(x: x + deltaX, y: y + deltaY)
  }
}

//  Mutating methods for enumerations can set the implicit self parameter to be a different member from the same enumeration:
// 枚举 的异变方法可以设置隐含的 self 属性为相同枚举里的不同成员
enum TriStateSwitch {
  case off, low, high
  mutating func next() {
    switch self {
    case .off:
      self = .low
    case .low:
      self = .high
    case .high:
      self = .off
    }
  }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()


// 类型方法 Type Methods
class SomeClass {
  class func someTypeMethod() {
    // type method implementation goes here
  } // 在 func 关键字之前使用 static 关键字来明确一个类型方法
    // 类同样可以使用 class 关键字来允许子类重写父类对类型方法的实现。
}
SomeClass.someTypeMethod()
// 在类型方法的函数体中，隐含的 self属性指向了类本身而不是这个类的实例

struct LevelTracker {
  static var highestUnlockedLevel = 1
  var currentLevel = 1
  
  static func unlock(_ level: Int) {
    if level > highestUnlockedLevel { highestUnlockedLevel = level }
  } // 类型函数
  
  static func isUnlocked(_ level: Int) -> Bool {
    return level <= highestUnlockedLevel
  } // 便捷类型方法
  
  @discardableResult  // @discardableResult 特性
  mutating func advance(to level: Int) -> Bool {
    if LevelTracker.isUnlocked(level) {
      currentLevel = level
      return true
    } else {
      return false
    }
  }
}

class Player {
  var tracker = LevelTracker()
  let playerName: String
  func complete(level: Int) {
    LevelTracker.unlock(level + 1)
    tracker.advance(to: level + 1)
  }
  init(name: String) {
    playerName = name
  }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
  print("player is now on level 6")
} else {
  print("level 6 has not yet been unlocked")
}



