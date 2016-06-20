//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

func greedyActivitySelector(starts: [Int], finishes: [Int]) -> [Int] {
    let n = starts.count - 1
    var activities: [Int] = [1]
    
    var k = 1
    
    for var m = 2; m <= n; m++ {
        if starts[m] > finishes[k] {
            activities.append(m)
            k = m
        }
    }
    
    return activities
}

// TEST CASE

var s: [Int] = [0, 1, 3, 0, 5, 3, 5, 6, 8, 8, 2, 12]
var f: [Int] = [0, 4, 5, 6, 7, 9, 9, 10, 11, 12, 14, 16]

var a: [Int] = greedyActivitySelector(s, finishes: f)

for item in a {
    print("\(item)\t")
}
