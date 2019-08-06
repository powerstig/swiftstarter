// 可选链 Optional Chaining

class Person {
  var residence: Residence?
}

class Residence {
  var numberOfRooms = 1
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms
// This triggers a runtime error

// 你可以赋值一个 Residence 实例给 john.residence ，这样它就不会再有 nil 值
// john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retreive the number of rooms.")
}

// Defining Model Classes for Optional Chaining
class Person2 {
  var residence: Residence2?
}

class Residence2 {
  var rooms = [Room]()
  var numberOfRooms: Int { // numberOfRooms 属性使用计算属性来实现
    return rooms.count
  }
  subscript(i: Int) -> Room { //下标来访问 rooms 数组的索引位置。
    return rooms[i]
  }
  func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
  }
  var address: Address?
}

class Room {
  let name: String
  init(name: String) { self.name = name }
}

class Address {
  var buildingName: String?
  var buildingNumber: String?
  var street: String?
  func buildingIdentifier() -> String? {
    if (buildingName != nil) {
      return buildingName
    } else if (buildingNumber != nil) {
      return buildingNumber
    } else {
      return nil
    }
  }
}


// 通过可选链访问属性 Accessing Properties Through Optional Chaining
let jack = Person2()
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retreive the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
jack.residence?.address = someAddress
// 给 john.residence 的 address 属性赋值会失败，因为 john.residence 目前是 nil 。
//赋值是可选链的一部分，也就是说 = 运算符右手侧的代码都不会被评判。

func createAddress() -> Address {
  print("Function was called.")
  
  let someAddress = Address()
  someAddress.buildingNumber = "29"
  someAddress.street = "Acacia Road"
  
  return someAddress
}
jack.residence?.address = createAddress()
// 用函数做同样的赋值，函数会在返回值之前打印“函数被调用了”，这可以让你看到 = 运算符右手侧是否被评判。

// 通过可选链调用方法 Calling Methods through Optional Chaining
// 你用可选链在可选项里调用printNumberOfRooms()这个方法，方法的返回类型将会是 Void? ，而不是 Void ，因为当你通过可选链调用的时候返回值一定会是一个可选类型。
if jack.residence?.printNumberOfRooms() != nil {
  print("It was possible to print the number of rooms.")
} else {
  print("It was not possible to print the number of rooms.")
}
// printNumberOfRooms returns Void? if called on an optional parent value

if (jack.residence?.address = someAddress) != nil {
  print("It was possible to set the address.")
} else {
  print("It was not possible to set the address.")
}
// Prints "It was not possible to set the address."


// Accessing Subscripts Through Optional Chaining
if let firstRoomName = jack.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}

//jack.residence?[0] = Room(name: "Bathroom")
//This subscript setting attempt also fails, because residence is currently nil.


let jacksHouse = Residence2()
jacksHouse.rooms.append(Room(name: "Living Room"))
jacksHouse.rooms.append(Room(name: "Kitchen"))
jack.residence = jacksHouse

if let firstRoomName = jack.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}

// Accessing Subscripts of Optional Type
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
//testScores["Brian"] = [60]
testScores["Brian"]?[0] = 72 // Fails as no Brian
testScores


// 链的多层连接 Linking Multiple levels of Chaining
if let jacksStreet = jack.residence?.address?.street {
  print("Jack's street name is \(jacksStreet).")
} else {
  print("Unable to retrieve the address.")
}

let jacksAddress = Address()
jacksAddress.buildingName = "The Larches"
jacksAddress.street = "Laurel Street"
jack.residence!.address = jacksAddress

if let jacksStreet = jack.residence?.address?.street {
  print("Jack's street name is \(jacksStreet).")
} else {
  print("Unable to retrieve the address.")
}


// 用可选返回值链接方法 Chaining on Methods With Optional Return Values
if let buildingIdentifier = jack.residence?.address?.buildingIdentifier() {
  print("Jack's building identifier is \(buildingIdentifier).")
}

//jack.residence?.address?.buildingIdentifier()

if let beginsWithThe = jack.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
  if beginsWithThe {
    print("Jack's building identifier begins with \"The\".")
  } else {
    print("Jack's building identifier does not begin with \"The\".")
  }
}






