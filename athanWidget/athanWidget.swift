//
//  athanWidget.swift
//  athanWidget
//
//  Created by Affan on 11/28/21.
//

import WidgetKit
import SwiftUI
import Intents


var gradientSet = [[Color]]()
let userDefaults = UserDefaults(suiteName: "group.athanWidgetAA")



//fajr
   let gradientOne = Color(red: 0/255, green: 0/255, blue: 0/255)
   let gradientTwo = Color(red: 89/255, green: 0/255, blue: 86/255)


//sunrise

let gradientSunrise1 = Color(red: 255/255, green: 102/255, blue: 102/255)
let gradientSunrise2 = Color(red: 195/255, green: 133/255, blue: 247/255)

//let gradientSunrise1 = Color(red: 0/255, green: 0/255, blue: 0/255)
//let gradientSunrise2 = Color(red: 0/255, green: 247/255, blue: 152/255)


//dhuhr
let gradientThree = Color(red: 39/255, green: 176/255, blue: 133/255)
let gradientFourth = Color(red: 3/255, green: 169/255, blue: 244/255)


//asr
let gradientFifth = Color(red: 255/255, green: 118/255, blue: 108/255)
let gradientSixth = Color(red: 6/255, green: 112/255, blue: 160/255)
//maghrib
let gradientSeventh = Color(red: 0/255, green: 0/255, blue: 0/255)
let gradientEighth = Color(red: 206/255, green: 118/255, blue: 51/255)

//isha
let gradientEleven = Color(red: 0/255, green: 0/255, blue: 0/255)
let gradientTwelve = Color(red: 0/255, green: 62/255, blue: 117/255)


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), text: "12:00PM", prayerName: "Fajr", color_select: [.blue, .black], prayerArray: ["Empty Array"], fajrTime: "00:00", sunriseTime: "00:00", dhuhrTime: "00:00", asrTime: "00:00", maghribTime: "00:00", ishaTime: "00:00", currentLocation: "Cupertino, CA", currentDateWidget: "2021", currentPrayer: 0, colorFajr: Color.white, colorSunrise: Color.white, colorDhuhr: Color.white, colorAsr: Color.white, colorMaghrib: Color.white, colorIsha: Color.white)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, text: "12:00PM", prayerName: "Fajr", color_select: [.blue, .black], prayerArray: ["Empty Array"], fajrTime: "00:00", sunriseTime: "00:00", dhuhrTime: "00:00", asrTime: "00:00", maghribTime: "00:00", ishaTime: "00:00", currentLocation: "Cupertino, CA", currentDateWidget: Date() as? String ?? "2021", currentPrayer: 0, colorFajr: Color.white, colorSunrise: Color.white, colorDhuhr: Color.white, colorAsr: Color.white, colorMaghrib: Color.white, colorIsha: Color.white)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        
        let dateFor = DateFormatter()
        var sevenDayCount = Date()
      
        
        let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        dateFor.locale = Locale.init(identifier: "en") // or "en" as you want to show numbers
        dateFor.dateStyle = .full
        dateFor.timeStyle = .full

        dateFor.calendar = hijriCalendar

        dateFor.dateFormat = "MMMM d, yyyy"
        
        var currentDateWidget = dateFor.string(from: sevenDayCount)
        
        var prayerColorFajr: Color
        var prayerColorSunrise: Color
        var prayerColorDhuhr: Color
        var prayerColorAsr: Color
        var prayerColorMaghrib: Color
        var prayerColorIsha: Color
        
        var prayerColors: [Color]
        
        var offsetTimes:[Date] = []
        
        var prayerNames = ["Fajr", "Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"]
        var prayerTimes:[String] = []
        var prayerTimesWO12:[String] = []
        var color_value: [Color]
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.timeZone = .current
       
        formatter.dateFormat = "h:mm a"
        
        let newFormatter = DateFormatter()
        newFormatter.timeStyle = .medium
        newFormatter.timeZone = .current
        newFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        
        
        let notificationFormatter = DateFormatter()
        notificationFormatter.dateFormat = "HH:mm"
        
        
        
        
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientSunrise1, gradientSunrise2])
        gradientSet.append([gradientThree, gradientFourth])
        gradientSet.append([gradientFifth, gradientSixth])
        gradientSet.append([gradientSeventh, gradientEighth])
        gradientSet.append([gradientEleven, gradientTwelve])
        
        var currentPrayerValue = (userDefaults?.value(forKey: "currentPrayerWidget")) as? String
        
        
        //var prayerTimes2 = userDefaults?.object(forKey: "prayerTimesWidgetWO12") as? [String]
        
        var prayerTimesSimple = userDefaults?.object(forKey: "prayerTimesWidget") as? [String]
        
        var prayerTimesTimeline = userDefaults?.object(forKey: "prayerTimesWidgetTimeline") as? [Date] ?? [Date]()
        
        
        var currentLocation = userDefaults?.value(forKey: "currentLocationWidget") as? String ?? ""
        
        var prayersWO12 = userDefaults?.value(forKey: "prayerTimesWidgetWO12") as? [String]
        //prayerTimes.append("00:00")
        
        for i in prayerTimesSimple!{
            
           prayerTimes.append(i ?? "Error")
        }
        
        for i in prayersWO12!{
            
            prayerTimesWO12.append(i)
            
        }
        
     

        var counter = 0
        var counterSmall = 0
        var dayCounterIndex = 1
        var controlDayCounter = 0
        
        //var testV = newFormatter.string(from: offsetTimes[])
        for hourOffset in prayerTimesTimeline{
            //let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            
            
            
            if (counter == 7){
                counter = 0
                dayCounterIndex = dayCounterIndex + 7
                sevenDayCount = Calendar.current.date(byAdding: .day, value: 1, to: sevenDayCount)!
                
                currentDateWidget = dateFor.string(from: sevenDayCount)
                
            }
            
        
            
           if (counterSmall == 42){
                counterSmall = 0
            }
            
           
            
            switch(counter){
                
            case 0:
                prayerColorFajr = Color.white
                prayerColorSunrise = Color.white
                prayerColorDhuhr = Color.white
                prayerColorAsr = Color.white
                prayerColorMaghrib = Color.white
                prayerColorIsha = Color.white
                counterSmall = dayCounterIndex + 0
                
     
                break
            case 1:
                prayerColorFajr = Color.orange
                prayerColorSunrise = Color.white
                prayerColorDhuhr = Color.white
                prayerColorAsr = Color.white
                prayerColorMaghrib = Color.white
                prayerColorIsha = Color.white
                counterSmall = dayCounterIndex + 0
                
                break
            case 2:
                prayerColorFajr = Color.white
                prayerColorSunrise = Color.orange
                prayerColorDhuhr = Color.white
                prayerColorAsr = Color.white
                prayerColorMaghrib = Color.white
                prayerColorIsha = Color.white
                counterSmall = dayCounterIndex + 1
              
                break
            case 3:
                prayerColorFajr = Color.white
                prayerColorSunrise = Color.white
                prayerColorDhuhr = Color.orange
                prayerColorAsr = Color.white
                prayerColorMaghrib = Color.white
                prayerColorIsha = Color.white
                counterSmall = dayCounterIndex + 2
            
                break
            case 4:
                prayerColorFajr = Color.white
                prayerColorSunrise = Color.white
                prayerColorDhuhr = Color.white
                prayerColorAsr = Color.orange
                prayerColorMaghrib = Color.white
                prayerColorIsha = Color.white
                counterSmall = dayCounterIndex + 3
            
                break
            case 5:
                prayerColorFajr = Color.white
                prayerColorSunrise = Color.white
                prayerColorDhuhr = Color.white
                prayerColorAsr = Color.white
                prayerColorMaghrib = Color.orange
                prayerColorIsha = Color.white
                counterSmall = dayCounterIndex + 4
            
                break
            case 6:
                prayerColorFajr = Color.white
                prayerColorSunrise = Color.white
                prayerColorDhuhr = Color.white
                prayerColorAsr = Color.white
                prayerColorMaghrib = Color.white
                prayerColorIsha = Color.orange
                counterSmall = dayCounterIndex + 5
            
                break
            default:
                prayerColorFajr = Color.white
                prayerColorSunrise = Color.white
                prayerColorDhuhr = Color.white
                prayerColorAsr = Color.white
                prayerColorMaghrib = Color.white
                prayerColorIsha = Color.white
               
                break
   
            }
            
            switch (counter){
                
            case 0:
                color_value = gradientSet[0]
                break
            case 1:
                color_value = gradientSet[1]
                break
            case 2:
                color_value = gradientSet[2]
                break
            case 3:
                color_value = gradientSet[3]
                break
            case 4:
                color_value = gradientSet[4]
                break
            case 5:
                color_value = gradientSet[5]
                break
            case 6:
                color_value = gradientSet[5]
                break
            default:
                color_value = gradientSet[0]
                break
                
            }
            
            
            
            
            let entry = SimpleEntry(date: hourOffset, configuration: configuration, text: prayerTimes[counterSmall], prayerName: prayerNames[counter], color_select: color_value, prayerArray: prayerTimesWO12, fajrTime: prayerTimes[dayCounterIndex + 0], sunriseTime: prayerTimes[dayCounterIndex + 1], dhuhrTime: prayerTimes[dayCounterIndex + 2], asrTime: prayerTimes[dayCounterIndex + 3], maghribTime: prayerTimes[dayCounterIndex + 4], ishaTime: prayerTimes[dayCounterIndex + 5], currentLocation: currentLocation, currentDateWidget: currentDateWidget, currentPrayer: counterSmall, colorFajr: prayerColorFajr, colorSunrise: prayerColorSunrise, colorDhuhr: prayerColorDhuhr, colorAsr: prayerColorAsr, colorMaghrib: prayerColorMaghrib, colorIsha: prayerColorIsha)
            counter = counter + 1
            controlDayCounter = controlDayCounter + 1
            //counterSmall = counterSmall + 1
            entries.append(entry)
        }
       
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let text: String
    let prayerName: String
    let color_select: [Color]
    let prayerArray: [String]
    
    let fajrTime: String
    let sunriseTime: String
    let dhuhrTime: String
    let asrTime: String
    let maghribTime: String
    let ishaTime: String
    
    let currentLocation: String
    let currentDateWidget: String
    let currentPrayer: Int
    
   
    let colorFajr: Color
    let colorSunrise: Color
    let colorDhuhr: Color
    let colorAsr: Color
    let colorMaghrib: Color
    let colorIsha: Color
    
    
    
    
}

struct athanWidgetEntryView : View {
    var entry: Provider.Entry
    
   
    @Environment(\.widgetFamily) var family
    
    var body: some View{
        
        if family == .systemSmall{
            smallWidget(entry: entry)
        }
        if family == .systemMedium{
            mediumWidget(entry: entry)
            
            
        }
    }
   
}

struct mediumWidget: View{
    var entry: Provider.Entry
    
    
    var body: some View {
        ZStack{
                
        VStack{
            HStack{
                Image(systemName: "sun.haze.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "sun.max.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "sun.min.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "sunset.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "moon.fill")
                    .imageScale(.small).foregroundColor(.white)
                
            }
            Spacer()
          
            
            
            HStack{
               Spacer()
                
                VStack{
                    
                    Text(entry.currentDateWidget).font(.callout).foregroundColor(.white)
                    Text(entry.currentLocation).font(.footnote).foregroundColor(.white)
                }
                
                
                Divider().background(Color.white).frame(width:20)
                
                //Text("Fajr:").font(.footnote).foregroundColor(.white)
                //Spacer()
                //Text(entry.fajrTime).font(.footnote).foregroundColor(.white).frame(maxWidth: 50, alignment: .trailing)
                VStack(){
                    
                    
                    HStack{
                        
                        Text("Fajr:").font(.footnote).foregroundColor(entry.colorFajr).frame(width: 60, alignment: .leading)
                            
                        
                       
                        Text(entry.fajrTime).font(.footnote).foregroundColor(entry.colorFajr).frame(width: 60, alignment: .trailing)
                        //Spacer()
                    }
                    
                    HStack{
                        Text("Sunrise:").font(.footnote).foregroundColor(entry.colorSunrise).frame(width: 60, alignment: .leading)
                        Text(entry.sunriseTime).font(.footnote).foregroundColor(entry.colorSunrise).frame(width: 60, alignment: .trailing)
                    }
                    HStack{
                        Text("Dhuhr:").font(.footnote).foregroundColor(entry.colorDhuhr).frame(width: 60, alignment: .leading)
                        Text(entry.dhuhrTime).font(.footnote).foregroundColor(entry.colorDhuhr).frame(width: 60, alignment: .trailing)
                    }
                    HStack{
                        Text("Asr:").font(.footnote).foregroundColor(entry.colorAsr).frame(width: 60, alignment: .leading)
                        Text(entry.asrTime).font(.footnote).foregroundColor(entry.colorAsr).frame(width: 60, alignment: .trailing)
                    }
                    HStack{
                        Text("Maghrib:").font(.footnote).foregroundColor(entry.colorMaghrib).frame(width: 60, alignment: .leading)
                        Text(entry.maghribTime).font(.footnote).foregroundColor(entry.colorMaghrib).frame(width: 60, alignment: .trailing)
                    }
                    HStack{
                        Text("Isha:").font(.footnote).foregroundColor(entry.colorIsha).frame(width: 60, alignment: .leading)
                        Text(entry.ishaTime).font(.footnote).foregroundColor(entry.colorIsha).frame(width: 60, alignment: .trailing)
                    }
                }
                
                Spacer()
            }
          
            Spacer()
            
            //HStack{
                
               // Text(entry.prayerArray[0]).font(.footnote)
               // Divider()
               // Text(entry.prayerArray[2]).font(.footnote)
               // Divider()
               // Text(entry.prayerArray[3]).font(.footnote)
               // Divider()
               // Text(entry.prayerArray[4]).font(.footnote)
                //Divider()
               // Text(entry.prayerArray[5]).font(.footnote)
                
                
                
            //}
            
        
        }.padding()
           
            
    }.background(
        LinearGradient(gradient: Gradient(colors: entry.color_select), startPoint: .top, endPoint: .bottom)
    )
    }
    
         
   
    
}


struct smallWidget: View{
    var entry: Provider.Entry

    var body: some View {
        
        ZStack{
            
        VStack{
            HStack{
                Image(systemName: "sun.haze.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "sun.max.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "sun.min.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "sunset.fill")
                    .imageScale(.small).foregroundColor(.white)
                Image(systemName: "moon.fill")
                    .imageScale(.small).foregroundColor(.white)
                
            }
            Spacer()
            HStack{
                Spacer()
                VStack{
                    
                    Text(entry.currentDateWidget).font(.footnote).foregroundColor(.white)
                    Text(entry.currentLocation).font(.caption).foregroundColor(.white)
                    
                }
                
               Spacer()
            }
   
            Spacer()
            Divider().background(Color.white).frame(width:50)
            VStack{
                
                Text(entry.prayerName).font(.headline).fontWeight(.bold).foregroundColor(.white)
                Text(entry.text).font(.title2).fontWeight(.bold).foregroundColor(.white)
                
            }
            
        //Spacer()
        //Spacer()
        }.padding()
           
            
    }.background(
        LinearGradient(gradient: Gradient(colors: entry.color_select), startPoint: .top, endPoint: .bottom))
    }
    
    
    
}

@main
struct athanWidget: Widget {
    let kind: String = "athanWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            athanWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct athanWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            athanWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), text: "4", prayerName: "Holder", color_select: [.black, .white], prayerArray: ["Empty Array"], fajrTime: "fajr", sunriseTime: "sunrise", dhuhrTime: "dhuhr", asrTime: "asr", maghribTime: "maghrib", ishaTime: "isha", currentLocation: "Oakland, CA", currentDateWidget: "1-1-1111", currentPrayer: 0, colorFajr: Color.white, colorSunrise: Color.white, colorDhuhr: Color.white, colorAsr: Color.white, colorMaghrib: Color.white, colorIsha: Color.white))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            athanWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), text: "4", prayerName: "Holder", color_select: [.black, .white], prayerArray: ["Empty Array"], fajrTime: "fajr", sunriseTime: "sunrise", dhuhrTime: "dhuhr", asrTime: "asr", maghribTime: "maghrib", ishaTime: "isha", currentLocation: "Oakland, CA", currentDateWidget: "1-1-1111", currentPrayer: 0, colorFajr: Color.white, colorSunrise: Color.white, colorDhuhr: Color.white, colorAsr: Color.white, colorMaghrib: Color.white, colorIsha: Color.white))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
    }
}
