//
//  LemonadeStandBrain.swift
//  LemonadeStandApp
//
//  Created by Israel Anifowose on 3/10/15.
//  Copyright (c) 2015 Div-Spark Inc. All rights reserved.
//

import Foundation

class LemonadeStandBrain {
    
    class func howManyCustomers(theWeather: String) -> Int {
        var numberOfCustomers = Int(arc4random_uniform(UInt32(10))) + 1
        switch theWeather {
        case "Cold":
            numberOfCustomers = numberOfCustomers - 3
        case "Warm":
            numberOfCustomers = numberOfCustomers + 4
        default:
            break
        }
        if numberOfCustomers <= 0 {
            println("**** Sorry, there are no customers today ****")
            return 0
        }
        else {
            return numberOfCustomers
        }
    }
    
    class func whatIsTheLemonadeRatio(lemons: Int, iceCubes:Int) -> Float {
        return Float(lemons) / Float(iceCubes)
    }
    
    class func  createRandomTastePreference(noOfCustomers: Int) -> [Float] {
        var randomTastePreference: [Float] = []
        
        for var index = 0; index < noOfCustomers; index++ {
            randomTastePreference.append((Float(Int(arc4random_uniform(UInt32(100))) + 1) / 100))
        }
        return randomTastePreference
    }
    
    class func revenueFromLemonadeSales (customerPreferences: [Float], lemonadeRatio: Float) -> Int {
        var revenue:Int = 0
        for var index = 0; index < customerPreferences.count; index++ {
            if (customerPreferences[index] >= 0 && customerPreferences[index] < 0.4) && lemonadeRatio > 1 {
                println("Customer \(index+1):  Taste Preference - \(customerPreferences[index])")
                println("             Paid!")
                revenue++
            }
            else if (customerPreferences[index] >= 0.4 && customerPreferences[index] < 0.6) && lemonadeRatio == 1 {
                println("Customer \(index+1):  Taste Preference - \(customerPreferences[index])")
                println("             Paid!")
                revenue++
            }
            else if (customerPreferences[index] >= 0.6 && customerPreferences[index] <= 1) && lemonadeRatio < 1 {
                println("Customer \(index+1):  Taste Preference - \(customerPreferences[index])")
                println("             Paid!")
                revenue++
            }
            else {
                println("Customer \(index+1): Taste Preference - \(customerPreferences[index])")
                println("            No match, No Revenue")
            }
        }
        if revenue > 0 {
            println("Congrats! You made $\(revenue) today!")
        }
        else {
            println("Sorry you made no money today")
        }
        return revenue
    }
    
    class func whatIsTheWeatherToday (weatherConditions: [String]) -> String {
        return weatherConditions[Int(arc4random_uniform(UInt32(weatherConditions.count)))]
    }
}