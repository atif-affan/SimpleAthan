//
//  tableView.swift
//  AthanTool
//
//  Created by Affan on 10/31/21.
//

import Foundation
import Foundation
import UIKit
import DropDown
import IntentsUI

class tableView: UITableViewController {
    var madhabButtonText = 0
    let defaults = UserDefaults.standard
    var intMadhab = 0
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    let button = INUIAddVoiceShortcutButton(style: .black)
    
    
   
    @IBOutlet weak var fajrAngleText: UILabel!
    @IBOutlet weak var stepperFajr: UIStepper!
    
    @IBOutlet weak var asrAngleText: UILabel!
    @IBOutlet weak var stepperAsr: UIStepper!
    
    @IBOutlet weak var ishaAngleText: UILabel!
    @IBOutlet weak var stepperIsha: UIStepper!
    
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var countdownText: UILabel!
    
    
    @IBOutlet weak var fajrAdjustStepper: UIStepper!
    @IBOutlet weak var fajrAdjustLabel: UILabel!
    
    
    @IBOutlet weak var dhuhrAdjustStepper: UIStepper!
    @IBOutlet weak var dhuhrAdjustLabel: UILabel!
    
    @IBOutlet weak var asrAdjustStepper: UIStepper!
    @IBOutlet weak var asrAdjustLabel: UILabel!
    
    @IBOutlet weak var maghribAdjustStepper: UIStepper!
    @IBOutlet weak var maghribAdjustLabel: UILabel!
    
    @IBOutlet weak var ishaAdjustStepper: UIStepper!
    @IBOutlet weak var ishaAdjustLabel: UILabel!
    
    @IBOutlet weak var reset: UIButton!
    
    @IBOutlet weak var contact: UIButton!
    
    @IBOutlet weak var prayerNotificationToggle: UISwitch!
    
    @IBOutlet weak var soundToggle: UISwitch!
    @IBOutlet var tableViewSettings: TableViewController!
    let gradient = CAGradientLayer()
       var gradientSet = [[CGColor]]()
       var currentGradient: Int = 0
    
    let initialOne = UIColor(red: 99/255, green: 0/255, blue: 132/255, alpha: 1).cgColor
    let initialTwo = UIColor(red: 0/255, green: 179/255, blue: 188/255, alpha: 1).cgColor
 
    
    
    //fajr
       let gradientOne = UIColor(red: 175/255, green: 76/255, blue: 0/255, alpha: 1).cgColor
       let gradientTwo = UIColor(red: 211/255, green: 183/255, blue: 0/255, alpha: 1).cgColor
    
    
    //dhuhr
       let gradientThree = UIColor(red: 0/255, green: 38/255, blue: 255/255, alpha: 1).cgColor
    let gradientFourth = UIColor(red: 0/255, green: 187/255, blue: 244/255, alpha: 1).cgColor
    
    
    //asr
    let gradientFifth = UIColor(red: 140/255, green: 40/255, blue: 255/255, alpha: 1).cgColor
    let gradientSixth = UIColor(red: 252/255, green: 217/255, blue: 128/255, alpha: 1).cgColor
    
    //maghrib
    let gradientSeventh = UIColor(red: 249/255, green: 159/255, blue: 62/255, alpha: 1).cgColor
    let gradientEighth = UIColor(red: 37/255, green: 90/255, blue: 150/255, alpha: 1).cgColor
    
    
    //cool combo can be used as backup
    let gradientNinth = UIColor(red: 99/255, green: 0/255, blue: 132/255, alpha: 1).cgColor
    let gradientTenth = UIColor(red: 0/255, green: 179/255, blue: 188/255, alpha: 1).cgColor
    
    
    //isha
    let gradientEleven = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
    let gradientTwelve = UIColor(red: 0/255, green: 62/255, blue: 117/255, alpha: 1).cgColor
    
 
    @IBOutlet weak var about: UIButton!
    @IBOutlet weak var madhabDropDown: UIButton!
    
    @IBOutlet weak var madhabSegment: UISegmentedControl!
    
    @IBOutlet weak var athanSoundDropDown: UIButton!
    
    
    
    
    
    @IBAction func madhabSegment(_ sender: Any) {
        
        switch madhabSegment.selectedSegmentIndex{
            
        case 0:
            defaults.set(0, forKey: "Madhab")
            print("hanafi")
            break
        case 1:
            print("shafi")
            defaults.set(1, forKey: "Madhab")
        default:
            print("No Madhab Selected")
            break
            
        }
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        
        resetToDefault()
        print("reset")
    }
    
    @IBAction func contactButton(_ sender: Any) {
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        let mailtoString = "mailto:simpleathan@gmail.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let mailtoUrl = URL(string: mailtoString!)!
        if UIApplication.shared.canOpenURL(mailtoUrl) {
                UIApplication.shared.open(mailtoUrl, options: [:])
        }
    }
    
    
    
    @IBAction func madhabDropDown(_ sender: UIButton) {
      
        
        let dropDown = DropDown()
        dropDown.bottomOffset = CGPoint(x: madhabDropDown.frame.origin.x, y: sender.frame.size.height)
        dropDown.anchorView = view
        dropDown.dataSource = ["  North America", "  Muslim World League", "  Umm Al Qura Makkah", "  Egyption General Authority Survey", "  University of Tehran", "  Karachi", "  Kuwait", "  Qatar", "  Singapore", "  Turkey", "  Moon Sighting Committee", "  Dubai"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            selectionFeedbackGenerator.selectionChanged()
            switch(item){
                
            case "  North America":
                defaults.set(0, forKey: "Calculation")
                break
            case "  Muslim World League":
                defaults.set(1, forKey: "Calculation")
                break
            case "  Umm Al Qura Makkah":
                defaults.set(2, forKey: "Calculation")
                break
            case "  Egyption General Authority Survey":
                defaults.set(3, forKey: "Calculation")
                break
            case "  University of Tehran":
                defaults.set(4, forKey: "Calculation")
                break
            case "  Karachi":
                defaults.set(5, forKey: "Calculation")
                break
            case "  Kuwait":
                defaults.set(6, forKey: "Calculation")
                break
            case "  Qatar":
                defaults.set(7, forKey: "Calculation")
                break
            case "  Singapore":
                defaults.set(8, forKey: "Calculation")
                break
            case "  Turkey":
                defaults.set(9, forKey: "Calculation")
                break
            case "  Moon Sighting Committee":
                defaults.set(10, forKey: "Calculation")
                break
            case "  Dubai":
                defaults.set(11, forKey: "Calculation")
                break
            default:
                print("Calculation not found")
                defaults.set(0, forKey: "Calculation")
                break
            }
            
            madhabDropDown.setTitle(item, for: .normal)
            
            
        }
        dropDown.width = 300
        dropDown.show()
    }
    
    
    
    @IBAction func prayerNotif(_ sender: Any) {
        print("toggle swiched")
        if prayerNotificationToggle.isOn {
             
            defaults.set(1, forKey: "prayerNotif")
            
            
          } else {
              defaults.set(0, forKey: "prayerNotif")
          }
        
        
        
        
    }
    
    
    @IBAction func soundNotif(_ sender: Any) {
    
        print("toggle swiched")
        if soundToggle.isOn {
             
            defaults.set(1, forKey: "soundNotif")
            
            
          } else {
              defaults.set(0, forKey: "soundNotif")
          }
    
    
    
    }
    
    
    @IBAction func fajrAdjust(_ sender: UIStepper) {
        var counter: Int = defaults.integer(forKey:"fajrAdjust")
        
        
        selectionFeedbackGenerator.selectionChanged()

        fajrAdjustLabel.text = String(Int(sender.value) + counter) + " minutes"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "fajrAdjust")
        
        sender.value = 0
            
       
        
        
    }
    
    
    @IBAction func dhuhrAdjust(_ sender: UIStepper) {
        var counter: Int = defaults.integer(forKey:"dhuhrAdjust")
        
        
        selectionFeedbackGenerator.selectionChanged()

        dhuhrAdjustLabel.text = String(Int(sender.value) + counter) + " minutes"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "dhuhrAdjust")
        
        sender.value = 0
        
    }
    
    @IBAction func asrAdjust(_ sender: UIStepper) {
        var counter: Int = defaults.integer(forKey:"asrAdjust")
        
        
        selectionFeedbackGenerator.selectionChanged()

        asrAdjustLabel.text = String(Int(sender.value) + counter) + " minutes"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "asrAdjust")
        
        sender.value = 0
        
    }
    
    
    @IBAction func maghribAdjust(_ sender: UIStepper) {
        
        var counter: Int = defaults.integer(forKey:"maghribAdjust")
        
        
        selectionFeedbackGenerator.selectionChanged()

        maghribAdjustLabel.text = String(Int(sender.value) + counter) + " minutes"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "maghribAdjust")
        
        sender.value = 0
    }
    
    
    @IBAction func ishaAdjust(_ sender: UIStepper) {
        var counter: Int = defaults.integer(forKey:"ishaAdjust")
        
        
        selectionFeedbackGenerator.selectionChanged()

        ishaAdjustLabel.text = String(Int(sender.value) + counter) + " minutes"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "ishaAdjust")
        
        sender.value = 0
    }
    
    
    
    
    @IBAction func fajrAngle(_ sender: UIStepper) {
        
        selectionFeedbackGenerator.selectionChanged()
        var counter: Int = defaults.integer(forKey:"fajrAngle")
        
        
        if (Int(sender.value) >= -20 && Int(sender.value) <= 20){

        fajrAngleText.text = String(Int(sender.value) + counter) + "°"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "fajrAngle")
        
        sender.value = 0
            
        }else{
            
            fajrAngleText.text =  "20°"
            defaults.set(20, forKey: "fajrAngle")
        }
            
        
    }
    
    @IBAction func asrAngle(_ sender: UIStepper) {
        var counter: Int = defaults.integer(forKey:"maghribAngle")
        
        selectionFeedbackGenerator.selectionChanged()
        asrAngleText.text = String(Int(sender.value) + counter) + "°"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "maghribAngle")
        
        sender.value = 0
        
    }
    
    
    @IBAction func ishaAngle(_ sender: UIStepper) {
        
        var counter: Int = defaults.integer(forKey:"ishaAngle")
        
        selectionFeedbackGenerator.selectionChanged()
        ishaAngleText.text = String(Int(sender.value) + counter ) + "°"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "ishaAngle")
        
        sender.value = 0
    }
    
    
    @IBAction func countDownStepper(_ sender: UIStepper) {
        
        var counter: Int = defaults.integer(forKey:"countdownValue")
        
        selectionFeedbackGenerator.selectionChanged()
        countdownText.text = String(Int(sender.value) + counter ) + "m"
       
        counter = Int(sender.value) + counter
        
        defaults.set(counter, forKey: "countdownValue")
        
        sender.value = 0
        
        
        
    }
    
    
    
    
    func setupFajrAngle(){
        if (defaults.object(forKey:"fajrAngle") != nil){
            
            fajrAngleText.text = String(defaults.integer(forKey:"fajrAngle")) + "°"
        }else{
            
            defaults.set(15, forKey: "fajrAngle")
            fajrAngleText.text = "15°"
            
        }
        
        
        if (defaults.object(forKey:"maghribAngle") != nil){
            
            asrAngleText.text = String(defaults.integer(forKey:"maghribAngle")) + "°"
        }else{
            
            defaults.set(0, forKey: "maghribAngle")
            asrAngleText.text = "0°"
            
        }
        
        
        if (defaults.object(forKey:"ishaAngle") != nil){
            
            ishaAngleText.text = String(defaults.integer(forKey:"ishaAngle")) + "°"
        }else{
            
            defaults.set(15, forKey: "ishaAngle")
            ishaAngleText.text = "15°"
            
        }
        
        if (defaults.integer(forKey:"countdownValue") > 0){
            
            countdownText.text = String(defaults.integer(forKey:"countdownValue")) + "m"
        }else{
            
            defaults.set(0, forKey: "countdownValue")
            countdownText.text = "0m"
            
        }
        
        
        if (defaults.object(forKey:"fajrAdjust") != nil){
            
            fajrAdjustLabel.text = String(defaults.integer(forKey:"fajrAdjust")) + " minutes"
        }else{
            
            defaults.set(0, forKey: "fajrAdjust")
            fajrAdjustLabel.text = "0 minutes"
            
        }
        
        if (defaults.object(forKey:"dhuhrAdjust") != nil){
            
            dhuhrAdjustLabel.text = String(defaults.integer(forKey:"dhuhrAdjust")) + " minutes"
        }else{
            
            defaults.set(0, forKey: "dhuhrAdjust")
            dhuhrAdjustLabel.text = "0 minutes"
            
        }
        
        if (defaults.object(forKey:"asrAdjust") != nil){
            
            asrAdjustLabel.text = String(defaults.integer(forKey:"asrAdjust")) + " minutes"
        }else{
            
            defaults.set(0, forKey: "asrAdjust")
            asrAdjustLabel.text = "0 minutes"
            
        }
        
        if (defaults.object(forKey:"maghribAdjust") != nil){
            
            maghribAdjustLabel.text = String(defaults.integer(forKey:"maghribAdjust")) + " minutes"
        }else{
            
            defaults.set(0, forKey: "maghribAdjust")
            maghribAdjustLabel.text = "0 minutes"
            
        }
        
        if (defaults.object(forKey:"ishaAdjust") != nil){
            
            ishaAdjustLabel.text = String(defaults.integer(forKey:"ishaAdjust")) + " minutes"
        }else{
            
            defaults.set(0, forKey: "ishaAdjust")
            ishaAdjustLabel.text = "0 minutes"
            
        }
        
        
       
        
    }
    
    
    
    @IBAction func aboutButton(_ sender: Any) {
        print("button touchdown")
        
    
    }
    
    func setupPrayerNotif(){
        
        if (defaults.object(forKey: "prayerNotif") != nil){
        
        if (defaults.integer(forKey:"prayerNotif") == 1){
            
            prayerNotificationToggle.setOn(true, animated:true)
            
        } else {
                
            prayerNotificationToggle.setOn(false, animated:true)
            }
        }else{
            
            defaults.set(1, forKey: "prayerNotif")
        }
            
        
    }
    
    
   func setupSoundNotif(){
        
       if (defaults.integer(forKey:"soundNotif") == 1){
           
           soundToggle.setOn(true, animated:true)
           
       } else {
               
           soundToggle.setOn(false, animated:true)
           }
    }
    
    func setupCalculationText(){
        
        switch(defaults.string(forKey:"Calculation")){
            
        case "0":
            madhabDropDown.setTitle("  North America", for: .normal)
            break
        case "1":
            madhabDropDown.setTitle("  Muslim World League", for: .normal)
            break
        case "2":
            madhabDropDown.setTitle("  Umm Al Qura Makkah", for: .normal)
            break
        case "3":
            madhabDropDown.setTitle("  Egyption General Authority Survey", for: .normal)
            break
        case "4":
            madhabDropDown.setTitle("  University of Tehran", for: .normal)
            break
        case "5":
            madhabDropDown.setTitle("  Karachi", for: .normal)
            break
        case "6":
            madhabDropDown.setTitle("  Kuwait", for: .normal)
            break
        case "7":
            madhabDropDown.setTitle("  Qatar", for: .normal)
            break
        case "8":
            madhabDropDown.setTitle("  Singapore", for: .normal)
            break
        case "9":
            madhabDropDown.setTitle("  Turkey", for: .normal)
            break
        case "10":
            madhabDropDown.setTitle("  Moon Sighting Committee", for: .normal)
            break
        case "11":
            madhabDropDown.setTitle("  Dubai", for: .normal)
            break
        default:
            madhabDropDown.setTitle("  North America (ISNA)", for: .normal)
            break
      
        }
               
    }
    
    
    func setupAthanText(){
        
        
        switch(defaults.string(forKey:"athanSound")){
            
        case "Default iOS":
            athanSoundDropDown.setTitle("  Default iOS", for: .normal)
            break
        case "None":
            athanSoundDropDown.setTitle("  None", for: .normal)
            break
        case "Madina":
            athanSoundDropDown.setTitle("  Madina", for: .normal)
            break
        case "Makkah":
            athanSoundDropDown.setTitle("  Makkah", for: .normal)
            break
        case "Abdul-Basit":
            athanSoundDropDown.setTitle("  Abdul-Basit", for: .normal)
            break
        case "Abdul-Ghaffar":
            athanSoundDropDown.setTitle("  Abdul-Ghaffar", for: .normal)
            break
        case "Yusuf_Islam":
            athanSoundDropDown.setTitle("  Yusuf Islam", for: .normal)
            break
        default:
            print("athan not found")
            athanSoundDropDown.setTitle("  Default iOS", for: .normal)
            break
        }
            
            
            
    }
        
        
        
        
    
    
    
    @IBAction func athanDropDown(_ sender: UIButton) {
        
        let dropDown = DropDown()
        dropDown.bottomOffset = CGPoint(x: madhabDropDown.frame.origin.x, y: sender.frame.size.height)
        dropDown.anchorView = view
        dropDown.dataSource = ["  Default iOS", "  None", "  Madina", "  Makkah", "  Abdul-Basit", "  Abdul-Ghaffar", "  Yusuf Islam"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            selectionFeedbackGenerator.selectionChanged()
            switch(item){
                
            case "  Default iOS":
                defaults.set("Default iOS", forKey: "athanSound")
                break
            case "  None":
                defaults.set("None", forKey: "athanSound")
                break
            case "  Madina":
                defaults.set("Madina", forKey: "athanSound")
                break
            case "  Makkah":
                defaults.set("Makkah", forKey: "athanSound")
                break
            case "  Abdul-Basit":
                defaults.set("Abdul-Basit", forKey: "athanSound")
                break
            case "  Abdul-Ghaffar":
                defaults.set("Abdul-Ghaffar", forKey: "athanSound")
                break
            case "  Yusuf Islam":
                defaults.set("Yusuf_Islam", forKey: "athanSound")
                break
            default:
                print("athan not found")
                defaults.set("None", forKey: "athanSound")
                break
            }
            
            athanSoundDropDown.setTitle(item, for: .normal)
            
            
        }
        dropDown.width = 300
        dropDown.show()
        
    }
    
    @IBAction func athanSoundDropDown(_ sender: UIButton) {
      
        
      
    }
    
    
   
  
    
    func printHello(){
        
        print("hello the subview worked!")
    }
    
    
    @objc private func animateGradient(prayer: Int) {
           
           let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
           gradientChangeAnimation.duration = 0.5
           
           if (prayer == 1){
               gradient.colors = gradientSet[1]
               gradientChangeAnimation.toValue = gradientSet[1]
               //defaults.set(1, forKey: "Background")
           }
           
           
           if (prayer == 2){
               gradient.colors = gradientSet[2]
               gradientChangeAnimation.toValue = gradientSet[2]
               //defaults.set(2, forKey: "Background")
               
               
           }
           
           if (prayer == 3){
               gradient.colors = gradientSet[3]
               gradientChangeAnimation.toValue = gradientSet[3]
               //defaults.set(3, forKey: "Background")
               
               
           }
           if (prayer == 4){
               gradient.colors = gradientSet[4]
               gradientChangeAnimation.toValue = gradientSet[4]
               //defaults.set(4, forKey: "Background")
               
               
           }
           if (prayer == 5){
               gradient.colors = gradientSet[5]
               gradientChangeAnimation.toValue = gradientSet[5]
              // defaults.set(5, forKey: "Background")
               
               
           }
           
           if (prayer == 6){
               gradient.colors = gradientSet[6]
               gradientChangeAnimation.toValue = gradientSet[6]
               //defaults.set(6, forKey: "Background")
               
               
           }
             
            
            
           gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
             gradientChangeAnimation.isRemovedOnCompletion = false
             gradient.add(gradientChangeAnimation, forKey: "colorChange")
         }
    
    
    func resetToDefault(){
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        defaults.set(0, forKey: "ishaAdjust")
                    ishaAdjustLabel.text = "0 minutes"

         defaults.set(0, forKey: "maghribAdjust")
                    maghribAdjustLabel.text = "0 minutes"

         defaults.set(0, forKey: "asrAdjust")
                    asrAdjustLabel.text = "0 minutes"
                    
        defaults.set(0, forKey: "dhuhrAdjust")
                    dhuhrAdjustLabel.text = "0 minutes"
                    
         defaults.set(0, forKey: "fajrAdjust")
                    fajrAdjustLabel.text = "0 minutes"
                    
        defaults.set(0, forKey: "countdownValue")
                    countdownText.text = "0m"

          defaults.set(15, forKey: "ishaAngle")
                    ishaAngleText.text = "15°"

         defaults.set(0, forKey: "maghribAngle")
                    asrAngleText.text = "0°"

         defaults.set(15, forKey: "fajrAngle")
                    fajrAngleText.text = "15°"
        
        
    }
       
   @objc func currentPrayerDetermine(){
        
        var current = defaults.string(forKey:"currentPrayer")
        
        switch(current){
            
        case "fajr":
            animateGradient(prayer: 1)
            print("Fajr Gradient Selected")
        case "sunrise":
           animateGradient(prayer: 2)
           print("Sunrise Gradient Selected")
        case "dhuhr":
            animateGradient(prayer: 3)
            print("Dhuhr Gradient Selected")
        case "asr":
            animateGradient(prayer: 4)
            print("Asr Gradient Selected")
        case "maghrib":
            animateGradient(prayer: 5)
            print("Maghrib Gradient Selected")
        case "isha":
            animateGradient(prayer: 6)
            print("Isha Gradient Selected")
        default:
            print("cannot find")
        }
        
        
    }
    
    //override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


       
      // let cell = UITableViewCell()


      // cell.textLabel?.text = "test"
      // cell.textLabel?.font = UIFont(name: "Avenir", size: 12)
      // cell.textLabel?.textColor = UIColor.red
      // cell.textLabel?.backgroundColor = UIColor.clear
      //  cell.contentView.backgroundColor = UIColor.clear

       //cell.contentView.backgroundColor = UIColor.clear
       
       //cell.layer.backgroundColor = UIColor.clear.cgColor

       //return cell

   //}
    
    override func viewDidLoad() {
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
       
      
        gradientSet.append([initialOne, initialTwo])
            gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientThree, gradientFourth])
        gradientSet.append([gradientFifth, gradientSixth])
        gradientSet.append([gradientSeventh, gradientEighth])
        gradientSet.append([gradientNinth, gradientTenth])
        gradientSet.append([gradientEleven, gradientTwelve])

        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
    gradient.startPoint = CGPoint(x:1, y:1)
    gradient.endPoint = CGPoint(x:1, y:0)
        gradient.drawsAsynchronously = true
        //self.view.layer.addSublayer(gradient)
   //self.view.layer.insertSublayer(gradient, at: 0)
        
        madhabSegment.selectedSegmentIndex = defaults.integer(forKey:"Madhab")
        
        setupAthanText()
        setupCalculationText()
        setupPrayerNotif()
        setupSoundNotif()
        setupFajrAngle()
       
        //tableViewSettings.backgroundColor = UIColor.redColor
        //var timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(currentPrayerDetermine), userInfo: nil, repeats: true)
        
        //tableViewSettings.view.backgroundColor = .red
        
    }
    
    
    
    
    
}
