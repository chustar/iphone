// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
var anotherStr = "Rob"
var thirdStr = str + anotherStr

for character in str {
    character
    println(character)
}

var newString = "Test String" as NSString
var subStr = (str as NSString).substringToIndex(6)
var endingString = newString.substringFromIndex(5)
var string = newString.substringWithRange(NSRange(location: 5, length: 4))

if newString.containsString("Test") {
    // do something
}

newString.componentsSeparatedByString(" ")

newString.uppercaseString

newString.lowercaseString