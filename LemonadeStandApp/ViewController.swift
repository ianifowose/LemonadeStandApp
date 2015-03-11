//
//  ViewController.swift
//  LemonadeStandApp
//
//  Created by Israel Anifowose on 3/9/15.
//  Copyright (c) 2015 Div-Spark Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cashToBuySuppliesLabel: UILabel!
    @IBOutlet weak var lemonsInInventoryLabel: UILabel!
    @IBOutlet weak var iceCubesInInventoryLabel: UILabel!
    @IBOutlet weak var amountOfLemonsPurchasedLabel: UILabel!
    @IBOutlet weak var amountOfIceCubesPurchasedLabel: UILabel!
    @IBOutlet weak var amountOfLemonsToMixLabel: UILabel!
    @IBOutlet weak var amountOfIceCubesToMixLabel: UILabel!
    @IBOutlet weak var weatherStatusImage: UIImageView!
    
    let kPriceOfLemons = 2
    let kPriceOfIceCubes = 1
    
    
    // Local variables to store inventory data
    var cashToBuySupplies = 10
    var lemonsInInventory = 1
    var iceCubesInInventory = 1
    
    // Local variables to store purchase supplies data
    var amountOfLemonsPurchased = 0
    var amountOfIceCubesPurchased = 0
    
    // Local variables to store lemonade mix data
    var amountOfLemonsMixedInLemonade = 0
    var amountOfIceCubesMixedInLemonade = 0
    
    //Lemonade Ratio
    var lemonadeRatio:Float = 0
    // Number of Customers
    var numberOfCustomers:Int = 0
    //Random Taste Preference
    var customerTastePreferences: [Float] = []
    // Keep track of lemons pruchased or not
    var lastLemonsPurchased = 0
    var lastIceCubesPurchased = 0
    //These are the three possible weather conditions
    var weatherConditions:[String] = ["Cold", "Mild", "Warm"]
    var todaysWeather:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todaysWeather = LemonadeStandBrain.whatIsTheWeatherToday(weatherConditions)
        weatherStatusImage.image = UIImage(named: todaysWeather)
        println("The weather is \(todaysWeather) today")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func purchaseAndUnPurchaseLemonsButton(sender: UIButton) {
        cashToBuySupplies = cashToBuySuppliesLabel.text!.toInt()!
        lemonsInInventory = lemonsInInventoryLabel.text!.toInt()!
        amountOfLemonsPurchased = amountOfLemonsPurchasedLabel.text!.toInt()!
        
        if sender.titleLabel?.text == "➕" && cashToBuySupplies >= 2 {
            amountOfLemonsPurchased++
            lemonsInInventory++
            cashToBuySupplies = cashToBuySupplies - kPriceOfLemons
        }
        else if sender.titleLabel?.text == "➕" && (cashToBuySupplies == 1) {
            showAlertWithText(header: "Not enough cash", message: "You don't have enough cash to buy lemons")
        }
        else if sender.titleLabel?.text == "➕" && cashToBuySupplies == 0 {
            showAlertWithText(header: "No Cash", message: "You're out of cash to buy lemons")
        }
        else if sender.titleLabel?.text == "➖" && amountOfLemonsPurchased > 0 {
            amountOfLemonsPurchased--
            lemonsInInventory--
            cashToBuySupplies = cashToBuySupplies + kPriceOfLemons
        }
        else {
            showAlertWithText(header: "Buy Lemons", message: "You need to buy some lemons")
        }
        
        updateMainView()
        isTheGameOver()
        
    }
    
    @IBAction func purchaseAndUnPurchaseIceCubesButton(sender: UIButton) {
        iceCubesInInventory = iceCubesInInventoryLabel.text!.toInt()!
        amountOfIceCubesPurchased = amountOfIceCubesPurchasedLabel.text!.toInt()!
        
        if sender.titleLabel?.text == "➕" && cashToBuySupplies >= 1 {
            amountOfIceCubesPurchased++
            iceCubesInInventory++
            cashToBuySupplies = cashToBuySupplies - kPriceOfIceCubes
        }
        else if sender.titleLabel?.text == "➕" && cashToBuySupplies < 1 {
            showAlertWithText(header: "No Cash", message: "You're out of cash to buy Ice cubes")
        }
        else if sender.titleLabel?.text == "➖" && amountOfIceCubesPurchased > 0 {
            amountOfIceCubesPurchased--
            iceCubesInInventory--
            cashToBuySupplies = cashToBuySupplies + kPriceOfIceCubes
        }
        else {
            showAlertWithText(header: "Buy Ice Cubes", message: "You need to buy some ice cubes")
        }
        
        updateMainView()
        isTheGameOver()
    }
    
    @IBAction func mixAndUnMixWithLemons(sender: UIButton) {
        amountOfLemonsMixedInLemonade = amountOfLemonsToMixLabel.text!.toInt()!
        
        
        if sender.titleLabel?.text == "➕" && lemonsInInventory > 0 {
            amountOfLemonsMixedInLemonade++
            lemonsInInventory--
            if amountOfLemonsPurchased > 0 {
                amountOfLemonsPurchased--
                lastLemonsPurchased = 1
            }
        }
        else if sender.titleLabel?.text == "➕" && lemonsInInventory == 0 {
            showAlertWithText(header: "Out of Lemons", message: "You're out of lemons, buy some more")
        }
        else if sender.titleLabel?.text == "➖" && amountOfLemonsMixedInLemonade > 0 {
            amountOfLemonsMixedInLemonade--
            lemonsInInventory++
            if (lastLemonsPurchased == 1) {
                amountOfLemonsPurchased++
            }
        }
        else {
            showAlertWithText(header: "Add a lemon", message: "You need to add a lemon to the mix")
        }
        
        updateMainView()
        isTheGameOver()
    }
    
    @IBAction func mixAndUnMixWithIceCubes(sender: UIButton) {
        amountOfIceCubesMixedInLemonade = amountOfIceCubesToMixLabel.text!.toInt()!
        
        if sender.titleLabel?.text == "➕" && iceCubesInInventory > 0 {
            amountOfIceCubesMixedInLemonade++
            iceCubesInInventory--
            if amountOfIceCubesPurchased > 0 {
                amountOfIceCubesPurchased--
                lastIceCubesPurchased = 1
            }
        }
        else if sender.titleLabel?.text == "➕" && iceCubesInInventory == 0 {
            showAlertWithText(header: "Out of Ice Cubes ", message: "You're out of ice cubes, buy some more")
        }
        else if sender.titleLabel?.text == "➖" && amountOfIceCubesMixedInLemonade > 0 {
            amountOfIceCubesMixedInLemonade--
            iceCubesInInventory++
            if lastIceCubesPurchased == 1 {
                amountOfIceCubesPurchased++
            }
        }
        else {
            showAlertWithText(header: "Add ice cubes", message: "You need to add ice cubes to the mix")
        }
        
        updateMainView()
        isTheGameOver()
    }
    
    @IBAction func startTheDayButton(sender: UIButton) {
        if (amountOfLemonsMixedInLemonade == 0 && amountOfIceCubesMixedInLemonade == 0) {
            showAlertWithText(header: "Add Lemons and Ice Cubes", message: "Please add some lemons and ice cubes to the mix")
        }
        else if (amountOfLemonsMixedInLemonade == 0 && amountOfIceCubesMixedInLemonade != 0) {
            showAlertWithText(header: "Add Lemons", message: "Please add some lemons to the mix")
        }
        else if (amountOfLemonsMixedInLemonade != 0 && amountOfIceCubesMixedInLemonade == 0) {
            showAlertWithText(header: "Add Ice Cubes", message: "Please add some ice cubes to the mix")
        }
        else {
            lemonadeRatio = LemonadeStandBrain.whatIsTheLemonadeRatio(amountOfLemonsMixedInLemonade, iceCubes: amountOfIceCubesMixedInLemonade)
            numberOfCustomers = LemonadeStandBrain.howManyCustomers(todaysWeather)
            customerTastePreferences = LemonadeStandBrain.createRandomTastePreference(numberOfCustomers)
            println("******* The lemondade Rato is \(lemonadeRatio) *******")
            println("If the customer preference matches the lemonade Ratio, you make $1")
            cashToBuySupplies = cashToBuySupplies + LemonadeStandBrain.revenueFromLemonadeSales(customerTastePreferences, lemonadeRatio: lemonadeRatio)
            
            //Clear out the purchased and mixed goods
            amountOfLemonsPurchased = 0
            amountOfIceCubesPurchased = 0
            amountOfLemonsMixedInLemonade = 0
            amountOfIceCubesMixedInLemonade = 0
            lastLemonsPurchased = 0
            lastIceCubesPurchased = 0
        }
        updateMainView()
        isTheGameOver()
    }
    
    func updateMainView() {
        // Update View With Inventory
        self.cashToBuySuppliesLabel.text = "\(cashToBuySupplies)"
        self.lemonsInInventoryLabel.text = "\(lemonsInInventory)"
        self.iceCubesInInventoryLabel.text = "\(iceCubesInInventory)"
        
        // Update View With Purchased Items
        self.amountOfLemonsPurchasedLabel.text = "\(amountOfLemonsPurchased)"
        self.amountOfIceCubesPurchasedLabel.text = "\(amountOfIceCubesPurchased)"
        
        // Update View with Mixed Items
        self.amountOfLemonsToMixLabel.text = "\(amountOfLemonsMixedInLemonade)"
        self.amountOfIceCubesToMixLabel.text = "\(amountOfIceCubesMixedInLemonade)"
        
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func isTheGameOver() {
        if cashToBuySupplies == 0 && lemonsInInventory == 0 && iceCubesInInventory == 0 && (amountOfIceCubesMixedInLemonade == 0 || amountOfLemonsMixedInLemonade == 0) {
            showAlertWithText(header: "Game over", message: "You out of inventory and cash to buy inventory")
        }
        else if cashToBuySupplies == 0 && lemonsInInventory > 0 && iceCubesInInventory == 0 && (amountOfIceCubesMixedInLemonade == 0 && amountOfLemonsMixedInLemonade == 0) {
            showAlertWithText(header: "Game over", message: "You are out of cash")
        }
        else if cashToBuySupplies == 0 && lemonsInInventory == 0 && iceCubesInInventory > 0 && (amountOfIceCubesMixedInLemonade == 0 && amountOfLemonsMixedInLemonade == 0) {
            showAlertWithText(header: "Game over", message: "You are out of cash")
        }
        else if cashToBuySupplies == 1 && lemonsInInventory == 0 && iceCubesInInventory > 1 && (amountOfIceCubesMixedInLemonade == 0 && amountOfLemonsMixedInLemonade == 0) {
            showAlertWithText(header: "Game over", message: "You are out of cash")
        }
        else {
            
        }
    }
    
    
}


