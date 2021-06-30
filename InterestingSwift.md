# Intresting Swift
These are notes of interesting syntax or tips I have noted while using swift; if in doubt look at the [swift book](https://docs.swift.org/swift-book/) or [Hackign with swift](https://www.hackingwithswift.com/)

- [Intresting Swift](#intresting-swift)
  * [Syntax](#syntax)
    + [Closures](#closures)
    + [Protocol Composition Type](#protocol-composition-type)
    + [Dot operator](#dot-operator)
    + [Switch cases](#switch-cases)
    + [Method signature](#method-signature)
    + [Function types](#function-types)
  * [Keywords](#keywords)
    + [typealias](#typealias)
    + [associatedtype](#associatedtype)
    + [fileprivate](#fileprivate)
    + [fileprivate(set)](#fileprivate-set-)
    + [let vs var](#let-vs-var)
    + [guard](#guard)
    + [@objc](#-objc)
    + [in (closures)](#in--closures-)
    + [weak vs unowned](#weak-vs-unowned)
  * [Operators](#operators)
    + [The as! and as? Operators](#the-as--and-as--operators)
  * [Patterns](#patterns)
    + [Box](#box)
  * [Questions](#questions)
    + [Why extend a class to implement a protocol?](#why-extend-a-class-to-implement-a-protocol-)
      - [Answer](#answer)
    + [Why have ApplicationCoordinator-Bridging-Header?](#why-have-applicationcoordinator-bridging-header-)
      - [Answer](#answer-1)

## Syntax
### Closures
```swift
{ [CAPTURE_LIST] (PARAMETERS_LIST) -> RETURN_TYPE in
    STATEMENTS
}
```

The capture list in the square brackets makes immutable copies of the parameter

[Alternative closures syntax](http://www.apeth.com/swiftBook/ch02.html#_anonymous_functions)

### Protocol Composition Type
A protocol composition type defines a type that conforms to each protocol in a list of specified protocols, or a type that’s a subclass of a given class and conforms to each protocol in a list of specified protocols.

Each item in a protocol composition list is one of the following; the list can contain at most one class:

- The name of a class
- The name of a protocol

A type alias whose underlying type is a protocol composition type, a protocol, or a class.
When a protocol composition type contains type aliases, it’s possible for the same protocol to appear more than once in the definitions—duplicates are ignored. For example, the definition of PQR in the code below is equivalent to P & Q & R.
```swift
typealias PQ = P & Q
typealias PQR = PQ & Q & R
```

### Dot operator
Swift can infer that from the context what you are assigning so this:
```swift
myTextField.textColor = UIColor.red
```
can be written like:
```swift
myTextField.textColor = .red
```

### Switch cases
Switc cases in swift can take on multiple switch propeties, e.g.,
```swift
switch (tutorialWasShown, isAutorized) {
    case (true, false), (false, false): return .auth
    case (false, true): return .onboarding
    case (true, true): return .main
}
```

### Method signature
Using a `->` to denote the return type. e.g., to return a Bool:
```swift
func NAME(ARGUMENT_LABEL | "_" PARAMETER_NAME | "_": "inout" PARAMTER_TYPE = PARAMETER_DEFAULT) -> RETURN_TYPE {

}
```

A variadic parameter accepts zero or more values of a specified type, e.g.,
```swift
func addNumbers(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total
}
```

An `inout` parameter can change the value of the parameter passed in, changing this without `inout` will cause a compile-time error, e.g.,
```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
// Note we pass in the parmaeter with a & (pointer)
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"
```

### Function types
```swift
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: (Int, Int) -> Int = addTwoInts

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 6"
```

Function Types as Parameter Types
```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
```

Function Types as Return Types

## Keywords
### typealias
```swift
typealias NAME = EXISITNG_TYPE
```

### associatedtype
Associated types are a powerful way of making protocols generic, [see here](https://www.hackingwithswift.com/example-code/language/what-is-a-protocol-associated-type)
```swift
protocol ItemStoring {
    associatedtype DataType

    var items: [DataType] { get set}
    mutating func add(item: DataType)
}

extension ItemStoring {
    mutating func add(item: DataType) {
        items.append(item)
    }
}

struct NameDatabase: ItemStoring {
    var items = [String]()
}
```

### fileprivate

Used for private access within the file itself

The only reason you would use fileprivate is when you want to access your code within the same file from different classes or structs. e.g.
```swift
fileprivate var onboardingWasShown = false
fileprivate var isAutorized = false

fileprivate enum LaunchInstructor {
  case main, auth, onboarding
  
  static func configure(
    tutorialWasShown: Bool = onboardingWasShown,
    isAutorized: Bool = isAutorized) -> LaunchInstructor {
    
    switch (tutorialWasShown, isAutorized) {
      case (true, false), (false, false): return .auth
      case (false, true): return .onboarding
      case (true, true): return .main
    }
  }
}

final class ApplicationCoordinator: BaseCoordinator {
    ...
}
```

here we can access the enum LauncherInstructor from within the Application coordinator

### fileprivate(set)
 Similar to [fileprivate](#fileprivate) but instead the getter of this property is visible to any file but the setter is only visible to the classes contained within the file.

### let vs var
You declare constants with the `let` keyword and variables with the `var` keyword

### guard
A guard statement, like an if statement, executes statements depending on the Boolean value of an expression. You use a guard statement to require that a condition must be true in order for the code after the guard statement to be executed, see [here](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#ID525)

### @objc
By default Swift generates code that is only available to other Swift code, but if you need to interact with the Objective-C runtime – all of UIKit, for example – you need to tell Swift what to do.

### in (closures)
Used to declare closure using this format:
```swift
{ (parameters) -> return type in
    statements
}
```
example:
```swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

### weak vs unowned
[Weak self and unowned self explained in Swift](https://www.avanderlee.com/swift/weak-self/)
> Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime. Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.

The only benefit of using unowned over weak is that you don’t have to deal with optionals. Therefore, using weak is always safer in those scenarios.

## Operators
### The as! and as? Operators
[reference](https://developer.apple.com/swift/blog/?id=23)
Prior to Swift 1.2, the as operator could be used to carry out two different kinds of conversion, depending on the type of expression being converted and the type it was being converted to:

Guaranteed conversion of a value of one type to another, whose success can be verified by the Swift compiler. For example, upcasting (i.e., converting from a class to one of its superclasses) or specifying the type of a literal expression, (e.g., 1 as Float).
Forced conversion of one value to another, whose safety cannot be guaranteed by the Swift compiler and which may cause a runtime trap. For example downcasting, converting from a class to one of its subclasses.
Swift 1.2 separates the notions of guaranteed conversion and forced conversion into two distinct operators. Guaranteed conversion is still performed with the as operator, but forced conversion now uses the as! operator. The ! is meant to indicate that the conversion may fail. This way, you know at a glance which conversions may cause the program to crash.

The following example illustrates the change:
```swift
class Animal {}
class Dog: Animal {}

let a: Animal = Dog()
a as Dog		// now raises the error:  "'Animal is not convertible to 'Dog';
				// ... did you mean to use 'as!' to force downcast?"

a as! Dog		// forced downcast is allowed

let d = Dog()
d as Animal		// upcast succeeds
```
Note the analogy between the expression postfix operators ! and ? and the conversion operators as! and as?:

```swift
class Animal {}

class Cat: Animal {}

class Dog: Animal {
	var name = "Spot"
}

let dog: Dog? = nil
dog?.name		// evaluates to nil
dog!.name		// triggers a runtime error

let animal: Animal = Cat()
animal as? Dog	// evaluates to nil
animal as! Dog	// triggers a runtime error
```
It may be easiest to remember the pattern for these operators in Swift as: ! implies “this might trap,” while ? indicates “this might be nil.”


## Patterns
### Box
[How to share structs using boxing](https://www.hackingwithswift.com/articles/92/how-to-share-structs-using-boxing)


## Questions
### Why extend a class to implement a protocol?
I have seen this pattern a lot where there is a protocol then an extension method in the same class... why?

#### Answer
This appears to be a pattern called "Protocol Oriented Programming" see [here for further info](https://www.hackingwithswift.com/sixty/9/5/protocol-oriented-programming). 
This pattern give a deafult implementation for the protocol.

### Why have ApplicationCoordinator-Bridging-Header?
All this file contains:
```objc
@import UIKit;
```

#### Answer
If you want to use Objective-C code in your Swift app, then you need to create a bridging header that allows your Swift code to work with your Objective-C code. 

Also, Unlike Objective-C projects (where common imports like UIKit or Foundation can be placed in the Precompiled Header file), in Swift you would normally have to include such imports in every single .swift file. A Bridging-Header file imports UIKit to all files some what like a Precompiled Header file.