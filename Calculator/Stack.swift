//
//  Stack.swift
//  Calculator
//
//  Created by Thang H Tong on 10/31/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Stack {
    
    private var arrayOfFloats: [Float] = []
    
    func pop() -> Float {
        return arrayOfFloats.removeLast()
    }
    
    
    func push(float: Float) {
        arrayOfFloats.append(float)
    }
    
    func log() {
        print(arrayOfFloats)
    }
    
    func count() -> Int {
        return arrayOfFloats.count
    }
  
}