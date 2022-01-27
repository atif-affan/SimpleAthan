//
//  ViewController.swift
//  AthanTool
//
//  Created by Affan on 10/25/21.
//

import UIKit
import Adhan
import CoreLocation
import DropDown
import SpriteKit
import SceneKit
import WidgetKit
import SwiftLocation



let locationManager = CLLocationManager()
let geoCoder = CLGeocoder()
let defaults = UserDefaults.standard

var settingsController: tableView?

let emitterNode = SKEmitterNode(fileNamed: "Starfield")!
let imageSunName = "Sun"
var imageSun = UIImage(named: "spark")
var imageView = UIImageView(image: imageSun)

var currentTemp: Int = 0
var currentTempUNIT = ""

var packagePrayerTimes:[String] = []
var packagePrayerTimesString:[String] = []
var packagePrayerTimesStringWO12:[String] = []
var packagePrayerTimesDate:[Date] = []
var sevenDayPrayerNotifications:[String] = []
var sevenDayPrayerReminders:[String] = []



var updateCounterProtect = 0

var currentCity = "Nil"
var currentState = "Nil"
var currentFinalLocation = ""

var prayerTimesList:[String] = []

var params = CalculationMethod.moonsightingCommittee.params

var pointX: CGFloat = 0.0
var pointY: CGFloat = 0.0

var point2X: CGFloat = 21.4225
var point2Y: CGFloat = 39.8262

var directionsG: CGFloat = 0

var FajrFloat = ""
var SunriseFloat = ""
var DhuhrFloat = ""
var AsrFloat = ""
var MaghribFloat = ""
var IshaFloat = ""

let userDefaults = UserDefaults(suiteName: "group.athanWidgetAA")



class ViewController: UIViewController, CLLocationManagerDelegate {

    
    let gradient = CAGradientLayer()
       var gradientSet = [[CGColor]]()
       var currentGradient: Int = 0
    
    let initialOne = UIColor(red: 99/255, green: 0/255, blue: 132/255, alpha: 1).cgColor
    let initialTwo = UIColor(red: 0/255, green: 179/255, blue: 188/255, alpha: 1).cgColor
 
    
    
    //fajr
       let gradientOne = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
       let gradientTwo = UIColor(red: 89/255, green: 0/255, blue: 86/255, alpha: 1).cgColor
    
    
    //sunrise
    
    let gradientSunrise1 = UIColor(red: 255/255, green: 148/255, blue: 0/255, alpha: 1).cgColor
    let gradientSunrise2 = UIColor(red: 0/255, green: 187/255, blue: 244/255, alpha: 1).cgColor
 
    
    //dhuhr
       let gradientThree = UIColor(red: 255/255, green: 148/255, blue: 0/255, alpha: 1).cgColor
    let gradientFourth = UIColor(red: 0/255, green: 187/255, blue: 244/255, alpha: 1).cgColor
    
    
    //asr
    let gradientFifth = UIColor(red: 0/255, green: 104/255, blue: 160/255, alpha: 1).cgColor
    let gradientSixth = UIColor(red: 0/255, green: 203/255, blue: 255/255, alpha: 1).cgColor
    
    //maghrib
    let gradientSeventh = UIColor(red: 249/255, green: 159/255, blue: 62/255, alpha: 1).cgColor
    let gradientEighth = UIColor(red: 37/255, green: 90/255, blue: 150/255, alpha: 1).cgColor
    
    
    //cool combo can be used as backup
   // let gradientNinth = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
   // let gradientTenth = UIColor(red: 0/255, green: 179/255, blue: 188/255, alpha: 1).cgColor
    
    
    //isha
    let gradientEleven = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
    let gradientTwelve = UIColor(red: 0/255, green: 62/255, blue: 117/255, alpha: 1).cgColor
    
    
    var newAngle:CGFloat = 0
    
    @IBOutlet weak var dateGreg: UILabel!
    
    @IBOutlet weak var myNewCompass: UIImageView!
    
    
    @IBOutlet weak var myCompassNew: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var fajrTime: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var dhuhrTime: UILabel!
    @IBOutlet weak var asrTime: UILabel!
    @IBOutlet weak var maghribTime: UILabel!
    @IBOutlet weak var ishaTime: UILabel!
    
    @IBOutlet weak var fajrName: UILabel!
    @IBOutlet weak var sunriseName: UILabel!
    @IBOutlet weak var dhuhrName: UILabel!
    @IBOutlet weak var asrName: UILabel!
    @IBOutlet weak var maghribName: UILabel!
    @IBOutlet weak var ishaName: UILabel!
    
    @IBOutlet weak var FajrBox: UILabel!
    
    @IBOutlet weak var IshaBox: UILabel!
    @IBOutlet weak var MaghribBox: UILabel!
    @IBOutlet weak var AsrBox: UILabel!
    @IBOutlet weak var DhuhrBox: UILabel!
    @IBOutlet weak var SunriseBox: UILabel!
    
    
    @IBOutlet weak var ishaView: UIView!
    
    @IBOutlet weak var maghribView: UIView!
    @IBOutlet weak var asrView: UIView!
    
    @IBOutlet weak var dhuhrView: UIView!
    @IBOutlet weak var sunriseView: UIView!
    @IBOutlet weak var fajrView: UIView!
    
    
    @IBOutlet weak var fajrImage: UIImageView!
    
    @IBOutlet weak var ishaImage: UIImageView!
    @IBOutlet weak var maghribImage: UIImageView!
    @IBOutlet weak var asrImage: UIImageView!
    @IBOutlet weak var dhuhrImage: UIImageView!
    @IBOutlet weak var sunriseImage: UIImageView!
    
    //@IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var islamicDate: UILabel!
    
    @IBOutlet weak var divider: UILabel!
    
    @IBOutlet weak var sunImage: UIImageView!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBAction func madhabButton(_ sender: Any) {
    
    print("u pressed")
    }
    
    
    @objc private func animateGradient(prayer: Int) {
           
           let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
           gradientChangeAnimation.duration = 0.5
           
           if (prayer == 1){
               gradient.colors = gradientSet[3]
               gradientChangeAnimation.toValue = gradientSet[3]
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
       
    
    
    func compassSetup(){
       
        myCompassNew.image = UIImage(named: "alternateCompass2.png")
        AthanTool.locationManager.delegate = self

                // Start location services to get the true heading.
        AthanTool.locationManager.distanceFilter = 1000
        AthanTool.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        AthanTool.locationManager.startUpdatingLocation()

                //Start heading updating.
                if CLLocationManager.headingAvailable() {
                    AthanTool.locationManager.headingFilter = 5
                    AthanTool.locationManager.startUpdatingHeading()
                    print("moving compass")
                }
        
        
    }
    
    private func addRain() {
               let skView = SKView(frame: view.frame)
               skView.backgroundColor = .clear
               let scene = SKScene(size: view.frame.size)
               scene.backgroundColor = .clear
               skView.presentScene(scene)
               skView.isUserInteractionEnabled = false
               scene.anchorPoint = CGPoint(x: 1, y: 1)
               scene.addChild(emitterNode)
               emitterNode.position.y = scene.frame.maxY
               emitterNode.particlePositionRange.dx = scene.frame.width
               view.addSubview(skView)
           }
    
    func highlightPrayer(prayer: Int){
        
        switch(prayer){
            
        case 1:
            fajrTime.textColor = UIColor.orange
            fajrName.textColor = UIColor.orange
            sunriseTime.textColor = UIColor.white
            sunriseName.textColor = UIColor.white
            dhuhrTime.textColor = UIColor.white
            dhuhrName.textColor = UIColor.white
            asrTime.textColor = UIColor.white
            asrName.textColor = UIColor.white
            maghribTime.textColor = UIColor.white
            maghribName.textColor = UIColor.white
            ishaTime.textColor = UIColor.white
            ishaName.textColor = UIColor.white
            break
        case 2:
            fajrTime.textColor = UIColor.gray
            fajrName.textColor = UIColor.gray
            sunriseTime.textColor = UIColor.orange
            sunriseName.textColor = UIColor.orange
            dhuhrTime.textColor = UIColor.white
            dhuhrName.textColor = UIColor.white
            asrTime.textColor = UIColor.white
            asrName.textColor = UIColor.white
            maghribTime.textColor = UIColor.white
            maghribName.textColor = UIColor.white
            ishaTime.textColor = UIColor.white
            ishaName.textColor = UIColor.white
            break
        case 3:
            fajrTime.textColor = UIColor.gray
            fajrName.textColor = UIColor.gray
            sunriseTime.textColor = UIColor.gray
            sunriseName.textColor = UIColor.gray
            dhuhrTime.textColor = UIColor.orange
            dhuhrName.textColor = UIColor.orange
            asrTime.textColor = UIColor.white
            asrName.textColor = UIColor.white
            maghribTime.textColor = UIColor.white
            maghribName.textColor = UIColor.white
            ishaTime.textColor = UIColor.white
            ishaName.textColor = UIColor.white
            break
        case 4:
            fajrTime.textColor = UIColor.gray
            fajrName.textColor = UIColor.gray
            sunriseTime.textColor = UIColor.gray
            sunriseName.textColor = UIColor.gray
            dhuhrTime.textColor = UIColor.gray
            dhuhrName.textColor = UIColor.gray
            asrTime.textColor = UIColor.orange
            asrName.textColor = UIColor.orange
            maghribTime.textColor = UIColor.white
            maghribName.textColor = UIColor.white
            ishaTime.textColor = UIColor.white
            ishaName.textColor = UIColor.white
            break
        case 5:
            fajrTime.textColor = UIColor.gray
            fajrName.textColor = UIColor.gray
            sunriseTime.textColor = UIColor.gray
            sunriseName.textColor = UIColor.gray
            dhuhrTime.textColor = UIColor.gray
            dhuhrName.textColor = UIColor.gray
            asrTime.textColor = UIColor.gray
            asrName.textColor = UIColor.gray
            maghribTime.textColor = UIColor.orange
            maghribName.textColor = UIColor.orange
            ishaTime.textColor = UIColor.white
            ishaName.textColor = UIColor.white
            break
        case 6:
            fajrTime.textColor = UIColor.gray
            fajrName.textColor = UIColor.gray
            sunriseTime.textColor = UIColor.gray
            sunriseName.textColor = UIColor.gray
            dhuhrTime.textColor = UIColor.gray
            dhuhrName.textColor = UIColor.gray
            asrTime.textColor = UIColor.gray
            asrName.textColor = UIColor.gray
            maghribTime.textColor = UIColor.gray
            maghribName.textColor = UIColor.gray
            ishaTime.textColor = UIColor.orange
            ishaName.textColor = UIColor.orange
            break
        default:
            print("Unable to highlight prayer time")
            break
            
            
        }
        
    }
    
    func setupPrayerParam(){
        
        if (defaults.object(forKey:"ishaAngle") == nil){
            
            defaults.set(15, forKey: "fajrAngle")
            defaults.set(0, forKey: "maghribAngle")
            defaults.set(15, forKey: "ishaAngle")
            
        }
        
        
        switch(defaults.string(forKey:"Calculation")){
            
        case "0":
            params = CalculationMethod.northAmerica.params
            break
        case "1":
            params = CalculationMethod.muslimWorldLeague.params
            break
        case "2":
            params = CalculationMethod.ummAlQura.params
            break
        case "3":
            params = CalculationMethod.egyptian.params
            break
        case "4":
            params = CalculationMethod.tehran.params
            break
        case "5":
            params = CalculationMethod.karachi.params
            break
        case "6":
            params = CalculationMethod.kuwait.params
            break
        case "7":
            params = CalculationMethod.qatar.params
            break
        case "8":
            params = CalculationMethod.singapore.params
            break
        case "9":
            params = CalculationMethod.turkey.params
            break
        case "10":
            params = CalculationMethod.moonsightingCommittee.params
            break
        case "11":
            params = CalculationMethod.dubai.params
            break
        default:
            params = CalculationMethod.northAmerica.params
            break
            
            
        }
        
        switch defaults.integer(forKey:"Madhab"){
            
        case 0:
            params.madhab = .hanafi
            break
        case 1:
            params.madhab = .shafi
            break
        default:
            params.madhab = .hanafi
            break

        }
        print("here is the madhab", params.madhab)
        
        
        params.fajrAngle = Double(defaults.integer(forKey:"fajrAngle"))
        params.maghribAngle = Double(defaults.integer(forKey:"maghribAngle"))
        params.ishaAngle = Double(defaults.integer(forKey:"ishaAngle"))
        
        params.adjustments.fajr = defaults.integer(forKey:"fajrAdjust")
        params.adjustments.dhuhr = defaults.integer(forKey:"dhuhrAdjust")
        params.adjustments.asr = defaults.integer(forKey:"asrAdjust")
        params.adjustments.maghrib = defaults.integer(forKey:"maghribAdjust")
        params.adjustments.isha = defaults.integer(forKey:"ishaAdjust")
       
    
        
    }
    
   
    
    
    func setupNotifications(){
        
        
        if (defaults.integer(forKey:"prayerNotif") == 0){
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in }
                     let content = UNMutableNotificationContent()
            center.removeAllPendingNotificationRequests()
            print("notifs currently off")
            
        }else{
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in }
                 let content = UNMutableNotificationContent()
        center.removeAllPendingNotificationRequests()
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        
        let newTimeFormatter = DateFormatter()
        newTimeFormatter.dateFormat = "hh:mm a"
        
        
        var prayerNames = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Magrhib", "Isha"]
       
        
        var prayerCount = 0
        print("currentLocation", currentFinalLocation)
        var reminderCheck = false
            
        for prayer in sevenDayPrayerNotifications{
            
            let date = timeFormatter.date(from: prayer)
            let date2 = newTimeFormatter.date(from: prayer)
            //print("here is the date ", date)
            
            var dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: date ?? Date())
            
            if prayerCount == 6{
                prayerCount = 0
                
            }
            
            if (currentFinalLocation == ""){
                
                content.body = "[" + newTimeFormatter.string(from: date ?? Date()) + "] " + prayerNames[prayerCount]
                
            }else{
                content.body = "[" + newTimeFormatter.string(from: date ?? Date()) + "] " + prayerNames[prayerCount] + " in " + currentFinalLocation
                
            }
            
            var fileName = defaults.string(forKey: "athanSound") ?? "default" + ".mp3"
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: fileName))

            let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
            
            let uuidString = UUID().uuidString
            
            let request = UNNotificationRequest.init(identifier: uuidString, content: content, trigger: trigger)
            
            center.add(request) { (error) in
                //print("Successfully added to Notifications", content.body)
                                       }
            
            prayerCount = prayerCount + 1
            //print("athan sound", fileName)
           
        }
     
        
            
           
        
        
        print("notifs currently on")
        }
    
    }
    

    
    
    
    
    @objc func updateLocation(){
        
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = AthanTool.locationManager.location
           print(currentLoc.coordinate.latitude)
           print(currentLoc.coordinate.longitude)
        
        
        
        let coordinates = Coordinates(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
        
            
        let location = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
               
                geoCoder.reverseGeocodeLocation(location, completionHandler:
                                                    { [self]
                        placemarks, error -> Void in

                        // Place details
                        guard let placeMark = placemarks?.first else { return }

                        // Location name
                        if let state = placeMark.administrativeArea {
                            print(state)
                            currentState = state
                        }
                        // Street address
    
                        // City
                        if let city = placeMark.subAdministrativeArea {
                            print(city)
                            currentCity = city
                        }
                    
                    if let city2 = placeMark.locality {
                        print(city2)
                        currentCity = city2
                    }
                        
                        locationLabel.text = currentCity + ", " + currentState
                        // Zip code
                    currentFinalLocation = currentCity + ", " + currentState
                    userDefaults?.setValue(currentFinalLocation, forKey: "currentLocationWidget")
                   
                })
        }
        
    }
    
    @objc func updatePrayerTimes(){
       

        setupPrayerParam()
        var currentLocation = AthanTool.locationManager.location
        compassSetup()
        AthanTool.locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = AthanTool.locationManager.location
            

           //print(currentLoc.coordinate.latitude)
           //print(currentLoc.coordinate.longitude)
        
            if (currentLoc.coordinate.latitude < 90 && currentLoc.coordinate.latitude > -90 && currentLoc.coordinate.longitude < 180 && currentLoc.coordinate.longitude > -180){
            pointX = currentLoc.coordinate.latitude
            pointY = currentLoc.coordinate.longitude
        
        //getWeather(Latitude: String(currentLoc.coordinate.latitude), Longitude: String(currentLoc.coordinate.longitude))
        
//        tempLabel.fadeTransition(1)
                //self.tempLabel.text = String(currentTemp) + currentTempUNIT + "°"
           
        
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: pointX, longitude: pointY)
        
            
          
           
            
            
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            
            //all code for prayers go here
            
            let formatter = DateFormatter()
            let calendar = Calendar.current
            formatter.timeStyle = .medium
            formatter.timeZone = .current
            print("timezone", formatter.timeZone)
            formatter.dateFormat = "h:mm a"
            
            let newFormatter = DateFormatter()
            newFormatter.timeStyle = .medium
            newFormatter.timeZone = .current
            newFormatter.dateFormat = "HH:mm"
            
            
            let notificationFormatter = DateFormatter()
            notificationFormatter.dateFormat = "MM/dd/yyyy HH:mm"
            
            let widgetFormatter = DateFormatter()
            widgetFormatter.timeStyle = .medium
            widgetFormatter.timeZone = .current
            widgetFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
           
            //self.tempLabel.text = formatter.string(from: Date())

            print("fajr \(formatter.string(from: prayers.fajr))")
            print("sunrise \(formatter.string(from: prayers.sunrise))")
            print("dhuhr \(formatter.string(from: prayers.dhuhr))")
            print("asr \(formatter.string(from: prayers.asr))")
            print("maghrib \(formatter.string(from: prayers.maghrib))")
            print("isha \(formatter.string(from: prayers.isha))")
            
            fajrTime.text = formatter.string(from: prayers.fajr)
            sunriseTime.text = formatter.string(from: prayers.sunrise)
            dhuhrTime.text = formatter.string(from: prayers.dhuhr)
            asrTime.text = formatter.string(from: prayers.asr)
            maghribTime.text = formatter.string(from: prayers.maghrib)
            ishaTime.text = formatter.string(from: prayers.isha)
            
            prayerTimesList = []
            prayerTimesList.append(notificationFormatter.string(from: prayers.fajr))
            prayerTimesList.append(notificationFormatter.string(from: prayers.sunrise))
            prayerTimesList.append(notificationFormatter.string(from: prayers.dhuhr))
            prayerTimesList.append(notificationFormatter.string(from: prayers.asr))
            prayerTimesList.append(notificationFormatter.string(from: prayers.maghrib))
            prayerTimesList.append(notificationFormatter.string(from: prayers.isha))
            
            //packagePrayerTimes.append(notificationFormatter.string(from: prayers.fajr))
            //packagePrayerTimes.append(notificationFormatter.string(from: prayers.sunrise))
            //packagePrayerTimes.append(notificationFormatter.string(from: prayers.dhuhr))
            //packagePrayerTimes.append(notificationFormatter.string(from: prayers.asr))
            //packagePrayerTimes.append(notificationFormatter.string(from: prayers.maghrib))
            //packagePrayerTimes.append(notificationFormatter.string(from: prayers.isha))
            
            packagePrayerTimes = []
            sevenDayPrayerNotifications = []
            packagePrayerTimesDate = []
            packagePrayerTimesString = []
            sevenDayPrayerReminders = []
            packagePrayerTimesStringWO12 = []
            
           
            
            var sevenDayCount = Date()
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            for i in 0...6{
                
                let startTime = calendar.startOfDay(for: sevenDayCount)
                var dateSevenCountComponent = cal.dateComponents([.year, .month, .day], from: sevenDayCount)
                
                if let prayersSevenDay = PrayerTimes(coordinates: coordinates, date: dateSevenCountComponent, calculationParameters: params){
                    
                    var tempReminder: Int = defaults.integer(forKey:"countdownValue")
                    
                    var fajrHolder: Date
                    var sunriseHolder: Date
                    var dhuhrHolder: Date
                    var asrHolder: Date
                    var maghribHolder: Date
                    var ishaHolder: Date
                
                   
                sevenDayPrayerNotifications.append(notificationFormatter.string(from: prayersSevenDay.fajr))
               fajrHolder = Calendar.current.date(byAdding: .minute, value: -tempReminder, to: prayersSevenDay.fajr)!
                sevenDayPrayerReminders.append(notificationFormatter.string(from: fajrHolder))
                 
                sevenDayPrayerNotifications.append(notificationFormatter.string(from: prayersSevenDay.sunrise))
                sunriseHolder = Calendar.current.date(byAdding: .minute, value: -tempReminder, to: prayersSevenDay.sunrise)!
                sevenDayPrayerReminders.append(notificationFormatter.string(from: sunriseHolder))
                    
                
                sevenDayPrayerNotifications.append(notificationFormatter.string(from: prayersSevenDay.dhuhr))
                dhuhrHolder = Calendar.current.date(byAdding: .minute, value: -tempReminder, to: prayersSevenDay.dhuhr)!
                sevenDayPrayerReminders.append(notificationFormatter.string(from: dhuhrHolder))
                    
                    
                sevenDayPrayerNotifications.append(notificationFormatter.string(from: prayersSevenDay.asr))
                asrHolder = Calendar.current.date(byAdding: .minute, value: -tempReminder, to: prayersSevenDay.asr)!
                sevenDayPrayerReminders.append(notificationFormatter.string(from: asrHolder))
                    
                    
                sevenDayPrayerNotifications.append(notificationFormatter.string(from: prayersSevenDay.maghrib))
                maghribHolder = Calendar.current.date(byAdding: .minute, value: -tempReminder, to: prayersSevenDay.maghrib)!
                sevenDayPrayerReminders.append(notificationFormatter.string(from: maghribHolder))
                
                    
                sevenDayPrayerNotifications.append(notificationFormatter.string(from: prayersSevenDay.isha))
                ishaHolder = Calendar.current.date(byAdding: .minute, value: -tempReminder, to: prayersSevenDay.isha)!
                sevenDayPrayerReminders.append(notificationFormatter.string(from: ishaHolder))
                    //let modifiedDate = Calendar.current.date(byAdding: .minute, value: -2, to: today)!
                    
                
                    
                packagePrayerTimesDate.append(startTime)
                packagePrayerTimesDate.append(prayersSevenDay.fajr)
                packagePrayerTimesDate.append(prayersSevenDay.sunrise)
                packagePrayerTimesDate.append(prayersSevenDay.dhuhr)
                packagePrayerTimesDate.append(prayersSevenDay.asr)
                packagePrayerTimesDate.append(prayersSevenDay.maghrib)
                packagePrayerTimesDate.append(prayersSevenDay.isha)
                
                    packagePrayerTimesString.append(formatter.string(from: startTime))
                    packagePrayerTimesString.append(formatter.string(from: prayersSevenDay.fajr))
                    packagePrayerTimesString.append(formatter.string(from: prayersSevenDay.sunrise))
                    packagePrayerTimesString.append(formatter.string(from: prayersSevenDay.dhuhr))
                    packagePrayerTimesString.append(formatter.string(from: prayersSevenDay.asr))
                    packagePrayerTimesString.append(formatter.string(from: prayersSevenDay.maghrib))
                    packagePrayerTimesString.append(formatter.string(from: prayersSevenDay.isha))
                    
                    //packagePrayerTimesStringWO12.append(formatter.string(from: startTime))
                    packagePrayerTimesStringWO12.append(formatter.string(from: prayersSevenDay.fajr))
                    packagePrayerTimesStringWO12.append(formatter.string(from: prayersSevenDay.sunrise))
                    packagePrayerTimesStringWO12.append(formatter.string(from: prayersSevenDay.dhuhr))
                    packagePrayerTimesStringWO12.append(formatter.string(from: prayersSevenDay.asr))
                    packagePrayerTimesStringWO12.append(formatter.string(from: prayersSevenDay.maghrib))
                    packagePrayerTimesStringWO12.append(formatter.string(from: prayersSevenDay.isha))
                
                   // print("wow ", formatter.string(from: prayersSevenDay.dhuhr), formatter.date(from: formatter.string(from: prayersSevenDay.dhuhr)))
                    print("wow", notificationFormatter.string(from: startTime))
                sevenDayCount = Calendar.current.date(byAdding: .day, value: 1, to: sevenDayCount)!
            }
            }
            
           
            print("Seven day list:", sevenDayPrayerReminders)
            //print("seven day date", packagePrayerTimesDate)
            print(prayerTimesList)
            
            FajrFloat = newFormatter.string(from: prayers.fajr)
            SunriseFloat = newFormatter.string(from: prayers.sunrise)
            DhuhrFloat = newFormatter.string(from: prayers.dhuhr)
            AsrFloat = newFormatter.string(from: prayers.asr)
            MaghribFloat = newFormatter.string(from: prayers.maghrib)
            IshaFloat = newFormatter.string(from: prayers.isha)
            
        
           
                // your code here
            
            userDefaults?.setValue(packagePrayerTimesString, forKey: "prayerTimesWidget")
            userDefaults?.setValue(packagePrayerTimesStringWO12, forKey: "prayerTimesWidgetWO12")
            userDefaults?.setValue(packagePrayerTimesDate, forKey: "prayerTimesWidgetTimeline")
            userDefaults?.setValue(widgetFormatter.string(from: Date()), forKey: "dateTest")
            
            print("packageprayertimesWO12", packagePrayerTimesDate)
            print(widgetFormatter.string(from: prayers.isha), "ishaWidget")
            
           
            
            print("Fajr Float", FajrFloat)
            print("Maghrib Float", MaghribFloat)
        
            let prayerTimes = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params)
            
            var current = prayerTimes!.currentPrayer()
            let next = prayerTimes!.nextPrayer()
            //let countdown = prayerTimes!.time(for: next!) ??
            
            print("Current Prayer: ", current ?? Adhan.Prayer.fajr)
            print("Next Prayer:", next)
            //print(String(current))
            var currentPrayer = String(describing: current ?? Adhan.Prayer.fajr)
            defaults.set(currentPrayer, forKey: "currentPrayer")
            userDefaults?.setValue(currentPrayer, forKey: "currentPrayerWidget")
            switch(currentPrayer){
                
            case "fajr":
                animateGradient(prayer: 1)
                highlightPrayer(prayer: 1)
                print("Fajr Gradient Selected")
            case "sunrise":
               animateGradient(prayer: 2)
               highlightPrayer(prayer: 2)
               print("Sunrise Gradient Selected")
            case "dhuhr":
                animateGradient(prayer: 3)
                highlightPrayer(prayer: 3)
                print("Dhuhr Gradient Selected")
            case "asr":
                animateGradient(prayer: 4)
                highlightPrayer(prayer: 4)
                print("Asr Gradient Selected")
            case "maghrib":
                animateGradient(prayer: 5)
                highlightPrayer(prayer: 5)
                print("Maghrib Gradient Selected")
            case "isha":
                animateGradient(prayer: 6)
                highlightPrayer(prayer: 6)
                print("Isha Gradient Selected")
            default:
                print("cannot find")
            }
   
        }
        
        
        setupNotifications()
            WidgetCenter.shared.reloadAllTimelines()
        }
        }
    }
    
   
    
    private func getBearing(pointLatitudeX: CGFloat, pointLongitudeY: CGFloat, point2LatitudeX: CGFloat, point2LongitudeY: CGFloat) -> Double {

        let lat1 = (pointLatitudeX * .pi) / 180
        let lon1 = (pointLongitudeY * .pi) / 180

        let lat2 = (point2LatitudeX * .pi) / 180
        let lon2 = (point2LongitudeY * .pi) / 180

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)

        var radiansBearing = atan2(y, x)
        if radiansBearing < 0 {
            radiansBearing += 2 * Double.pi
        }

        return radiansBearing
    }
    
   
    private func doComputeAngleBetweenMapPoints(
        fromHeading: CLLocationDirection,
        pointLatitudeX: CGFloat, pointLongitudeY: CGFloat, point2LatitudeX: CGFloat, point2LongitudeY: CGFloat
    ) -> CLLocationDirection {
        let bearing = getBearing(pointLatitudeX: pointLatitudeX, pointLongitudeY: pointLongitudeY, point2LatitudeX: point2LatitudeX, point2LongitudeY: point2LongitudeY)
        var theta = bearing - fromHeading
        if theta < 0 {
            theta += 360
        }
        return theta
    }
  
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {

            if newHeading.headingAccuracy < 0 {
                return
            }
        
        let angle2U = getBearing(pointLatitudeX: pointX, pointLongitudeY: pointY, point2LatitudeX: point2X, point2LongitudeY: point2Y)
        
            directionsG = CGFloat(newHeading.magneticHeading * Double.pi/180)
        
        let direction2GN = CGFloat(angle2U) - directionsG
        let tr2 = CGAffineTransform.identity.rotated(by: direction2GN)
        
            // Get the heading(direction)
            let heading: CLLocationDirection = ((newHeading.trueHeading > 0) ?
                newHeading.trueHeading : newHeading.magneticHeading);
            UIView.animate(withDuration: 1) {
                //let angle = ((CGFloat(heading) * .pi)/180) // convert from degrees to radians
    
                let angle = ((CGFloat(newHeading.magneticHeading) * .pi) / 180)
                self.newAngle = angle
                //print("angle", self.doComputeAngleBetweenMapPoints(fromHeading: newHeading.trueHeading, pointLatitudeX: pointX, pointLongitudeY: pointY, point2LatitudeX: point2X, point2LongitudeY: point2Y))
                self.myCompassNew.transform = tr2 // rotate the picture
                
                //self.tempLabel.text = String(describing: direction2GN)
            
            }
    
        }
    
    @objc func animationSun(){
        
        let date = Date()
        var calendar = Calendar.current
        
        var currentTimeFraction = 0.0
        var percentageDay = 0.0
        var minute = calendar.component(.minute, from: date)
        
        var minutesInADay = 1440.0
        
        var hour = calendar.component(.hour, from: date)
        
        var Hour = Double(hour)
        var Minute = Double(minute)
        Hour = Hour * 60.0
       
        currentTimeFraction = Hour + Minute
        percentageDay = currentTimeFraction / minutesInADay
        print("This is the percentage of day passed", percentageDay)
    
            
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            
            self.view.addSubview(imageView)
            imageView.startRotating()
            let centerX = UIScreen.main.bounds.maxX / 2
            let centerY = UIScreen.main.bounds.maxY / 3
            
           imageView.layer.shadowOffset = .zero
           imageView.layer.shadowColor = UIColor.yellow.cgColor
           imageView.layer.shadowRadius = 25
           imageView.layer.shadowOpacity = 1
           imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
           
            print("Center", centerX, centerY)
            let path = UIBezierPath()
           
            path.move(to: CGPoint(x: 0, y: centerY/2))
           
            path.addQuadCurve(to: CGPoint(x: UIScreen.main.bounds.maxX, y: centerY/2),
                              controlPoint: CGPoint(x: centerX, y: 0))
           
    
           
            //Shape part
            let shape = CAShapeLayer()
            shape.path = path.cgPath
            shape.lineWidth = 4.0
            shape.fillColor = UIColor.clear.cgColor
            shape.strokeColor = UIColor.lightGray.cgColor
        shape.opacity = 0.5
            shape.lineDashPattern = [12, 1]
           
           
            view.layer.addSublayer(shape)
            // Do any additional setup after loading the view.
            
            let animation = CAKeyframeAnimation(keyPath: "position")
            
            animation.path = path.cgPath
            animation.repeatCount = Float.infinity
            animation.duration = 86400
            animation.timeOffset = (percentageDay * 86400.0)
        
            imageView.layer.add(animation, forKey: "animate along path")
           
            
            imageView.center = CGPoint(x: 0, y: centerY/2)
        
            
      
       
   }
    
    func setupLocationManager() {
        AthanTool.locationManager.delegate = self
        AthanTool.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                 }
                 
                 
             
             func checkLocationServices() {
                     if CLLocationManager.locationServicesEnabled() {
                         setupLocationManager()
                         checkLocationAuthorization()
                     } else {
                         // Show alert letting the user know they have to turn this on.
                     }
                 }
    
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {

        let animationDuration = 0.25

        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 0
            
            }) { (Bool) -> Void in

                // After the animation completes, fade out the view after a delay

                UIView.animate(withDuration: animationDuration, delay: delay, animations: { () -> Void in
                    view.alpha = 1
                    },
                    completion: nil)
        }
    }
    
    func checkLocationAuthorization() {
                      switch CLLocationManager.authorizationStatus() {
                      case .authorizedWhenInUse:
                          AthanTool.locationManager.startUpdatingLocation()
                          break
                      case .denied:
                          // Show alert instructing them how to turn on permissions
                          break
                      case .notDetermined:
                          AthanTool.locationManager.requestWhenInUseAuthorization()
                      case .restricted:
                          // Show an alert letting them know what's up
                          break
                      case .authorizedAlways:
                          break
                      }
                  }
    
    func setupPrimary(){
        
        
        //FajrBox.layer.cornerRadius = 6
        //FajrBox.layer.masksToBounds = true
        //fadeViewInThenOut(view: FajrBox, delay: 0.5)
        
        //SunriseBox.layer.cornerRadius = 6
        //SunriseBox.layer.masksToBounds = true
        //fadeViewInThenOut(view: SunriseBox, delay: 0.5)
        
        //DhuhrBox.layer.cornerRadius = 6
        //DhuhrBox.layer.masksToBounds = true
        //fadeViewInThenOut(view: DhuhrBox, delay: 0.5)
        
        //AsrBox.layer.cornerRadius = 6
        //AsrBox.layer.masksToBounds = true
        //fadeViewInThenOut(view: AsrBox, delay: 0.5)
        
        //MaghribBox.layer.cornerRadius = 6
        //MaghribBox.layer.masksToBounds = true
        //fadeViewInThenOut(view: MaghribBox, delay: 0.5)
        
        
        
        //IshaBox.layer.cornerRadius = 6
        //IshaBox.layer.masksToBounds = true
        
        fajrView.layer.cornerRadius = 6
        ishaView.layer.cornerRadius = 6
        sunriseView.layer.cornerRadius = 6
        dhuhrView.layer.cornerRadius = 6
        asrView.layer.cornerRadius = 6
        maghribView.layer.cornerRadius = 6
        //fadeViewInThenOut(view: IshaBox, delay: 0.5)
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in }
        
        let centerX = UIScreen.main.bounds.maxX
        let centerY = UIScreen.main.bounds.maxY
        
        checkLocationServices()
        
        //divider.fadeTransition2(2)
        var currentLoc: CLLocation!
        //addRain()
        setupPrayerParam()
        gradientSet.append([initialOne, initialTwo])
            gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientSunrise1, gradientSunrise2])
        gradientSet.append([gradientThree, gradientFourth])
        gradientSet.append([gradientFifth, gradientSixth])
        gradientSet.append([gradientSeventh, gradientEighth])
        //gradientSet.append([gradientNinth, gradientTenth])
        gradientSet.append([gradientEleven, gradientTwelve])
        //gradientSet.append([gradientFourth, gradientThree])
        updatePrayerTimes()
        //gradientSet.append([gradientFourth, gradientFifth])
            //gradientSet.append([gradientTwo, gradientOne])
            //gradientSet.append([gradientThree, gradientOne])
        
        //let currentDate = Date()
        
        //var dateComponent = DateComponents()
        //dateComponent.day = 1
        //let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        //print(currentDate)
        //print(futureDate!)
        
        let dateFor = DateFormatter()

        let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        dateFor.locale = Locale.init(identifier: "en") // or "en" as you want to show numbers
        dateFor.dateStyle = .full
        dateFor.timeStyle = .full

        dateFor.calendar = hijriCalendar

        dateFor.dateFormat = "MMMM d, yyyy"
        
        islamicDate.text = dateFor.string(from: Date())
        
        
       
        
        
            gradient.frame = self.view.bounds
            gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:1, y:1)
        gradient.endPoint = CGPoint(x:1, y:0)
            gradient.drawsAsynchronously = true
            self.view.layer.addSublayer(gradient)
        self.view.layer.insertSublayer(gradient, at: 1)
          
        
        
    }
    
    
    @objc func callRequest(){
        
        AthanTool.locationManager.requestWhenInUseAuthorization()
        
        
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UITabBar.appearance().backgroundColor = UIColor(red:1, green:0, blue:0, alpha:0)

        var longitudeNew: Double = 0.0
        var latitudeNew: Double = 0.0
        
        settingsButton.layer.cornerRadius = 6
        
        
        //settingsButton.font = UIFont.boldSystemFont(ofSize: 20.0)
    
       
       
     
        setupPrimary()
   

        AthanTool.locationManager.requestWhenInUseAuthorization()
        print("here is authorization", CLLocationManager.authorizationStatus())
        
            if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
                var currentLoc: CLLocation!
                currentLoc = AthanTool.locationManager.location
                print("authorization granted")
         
                if (currentLoc.coordinate.latitude < 90 && currentLoc.coordinate.latitude > -90 && currentLoc.coordinate.longitude < 180 && currentLoc.coordinate.longitude > -180){
              
            
            let coordinates = Coordinates(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
                
                
                
            
            let location = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
                   
                    geoCoder.reverseGeocodeLocation(location, completionHandler:
                                                        { [self]
                            placemarks, error -> Void in

                            print("placemarks", placemarks)
                            // Place details
                            guard let placeMark = placemarks?.first else { return }

                            // Location name
                            if let state = placeMark.administrativeArea {
                                print(state)
                                currentState = state
                            }
                            // Street address
        
                            // City
                            if let city = placeMark.subAdministrativeArea {
                                print(city)
                                currentCity = city
                            }
                        
                        if let city2 = placeMark.locality {
                            print(city2)
                            currentCity = city2
                        }
                            
                            locationLabel.text = currentCity + ", " + currentState
                        currentFinalLocation = currentCity + ", " + currentState
                            // Zip code
                    })
          
        
                
        
    
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updatePrayerTimes), userInfo: nil, repeats: true)
        
        var timer2 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)

                }
            }else{
                
                var timer3 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(callRequest), userInfo: nil, repeats: true)
                
                var timer4 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updatePrayerTimes), userInfo: nil, repeats: true)
                
                var timer5 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
                print("no permission given")
                
                
            }
            
        
    
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        //animationSun()
       
        //var timer3 = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(animationSun), userInfo: nil, repeats: true)
        
    }
    
 
  

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension UIView {
    func startRotating(duration: Double = 10) {
        let kAnimationKey = "rotation"
         
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(M_PI * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    func startFading(duration: Double = 10){
        let kAnimationKey = "rotation"
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            self.alpha = 0.0
            animate.toValue = Float(M_PI * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
        
        
    }
    
    
    
    func stopRotating() {
        let kAnimationKey = "rotation"
         
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name:
                CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
            animation.duration = duration
            layer.add(animation, forKey: CATransitionType.fade.rawValue)
        }
    
    func fadeTransition2(_ duration:CFTimeInterval) {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name:
                CAMediaTimingFunctionName.easeInEaseOut)
        animation.subtype = .fromTop
        animation.type = CATransitionType.reveal
            animation.duration = duration
            layer.add(animation, forKey: CATransitionType.fade.rawValue)
        }
    
    
}


