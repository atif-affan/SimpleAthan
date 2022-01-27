//
//  ContentView.swift
//  settingsmenu
//
//  Created by Affan on 1/11/22.
//

import SwiftUI
let coloredNavAppearance = UINavigationBarAppearance()
let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)


var colorRectangle = Color(red: 44/255, green: 125/255, blue: 160/255)
var textColor = Color.white
var viewColor = Color(red: 70/255, green: 143/255, blue: 175/255)
var headerColor = Color.white
var stepperColor = Color(red: 169/255, green: 214/255, blue: 229/255)

let timer = Timer.publish(every:
                            0.1, on: .main, in: .common).autoconnect()

struct ContentView: View {
    @State var showingSheet = false
  
    @State var showingManual = false
    @State var showingAdvanced = false
    @State var showingJurisprudence = false
    @State var showingStandard = false
    @State var showingSound = false
    @State private var showGreeting = true
    @State private var age = 18
    
    
    @State var notificationToggle = (defaults.integer(forKey:"prayerNotif") == 1 ? true : false)
    @State var reminderToggle = ((defaults.integer(forKey: "prayerNotif") == 1) ? true : false)
    @State var soundToggle = (defaults.integer(forKey:"soundNotif") == 1 ? true : false)
    @State private var jurisprudence = 18
    @State private var soundStyle = (defaults.object(forKey:"athanSound") != nil ? defaults.string(forKey:"athanSound") : "Default iOS")
    
    @State var calculationName: String = "Loading"
    
    @State var jurisprudenceName: Int = defaults.integer(forKey:"Madhab") ?? 5
    
    
    func setupStandard() -> String{
        
        var calculationName = defaults.string(forKey:"Calculation") ?? "Not Found"
        switch(calculationName){
            
        case "0":
            calculationName = "  North America"
            break
        case "1":
            calculationName = "  Muslim World League"
            break
        case "2":
            calculationName = "  Umm Al Qura Makkah"
            break
        case "3":
            calculationName = "  Egypt"
            break
        case "4":
            calculationName = "  University of Tehran"
            break
        case "5":
            calculationName = "  Karachi"
            break
        default:
            calculationName = "  North America"
            break
      
        }
        
        return calculationName
        
    }
    
    init() {
            coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(red: 70/255, green: 143/255, blue: 175/255, alpha: 1.0)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
                   
            UINavigationBar.appearance().standardAppearance = coloredNavAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance

        
        
        }

    var body: some View {
        
           
        NavigationView{
        ScrollView{
      
            
            VStack{
                
                
               // Text("Audio").font(.subheadline).foregroundColor(Color(red: 188/255, green: 188/255, blue: 188/255)).bold()
                //Divider().frame(height: 50).foregroundColor(<#T##color: Color?##Color?#>)
                LabelledDivider(label: "General")
               
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(colorRectangle)
                    .frame(width: 350, height: 60)
                    .overlay(
                        
                        VStack{
                        
                        HStack(spacing: 25){
                            
                            Text("Notifications").font(.body).bold().foregroundColor(textColor)
                          Spacer()
                            Toggle("", isOn: $notificationToggle).onChange(of: notificationToggle){
                                new in
                                print(new)
                                
                                if (new == true){
                                    defaults.set(1, forKey: "prayerNotif")
                                }else{
                                    defaults.set(0, forKey: "prayerNotif")
                                }
                                
                             
                            }
                            
                            
                        }.padding(.top).padding(.leading).padding(.trailing)
                            
                            
                            //REMINDERS ARE HERE
                            
                           // LabelledDivider2(label: "")
                            //HStack( spacing: 25){
                                
                               // Text("Reminders").font(.body).bold().foregroundColor(textColor)
                                
                               // Spacer()
                                
                               // Toggle("", isOn: $reminderToggle).onChange(of: reminderToggle){
                                //    new in
                                    
                                //    if (new == true){
                                //        defaults.set(1, forKey: "prayerNotif")
                                //    } else{
                                 //       defaults.set(0, forKey: "prayerNotif")
                                 //   }
                                    
                                 //   print(new)
                               // }
                                
                                
                                
                           // }.padding(.trailing).padding(.leading)
                            
                           Spacer()
                        }
                        
                        
            )

            }.padding()
        

            
            VStack{
                
                //Text("Calculation").font(.subheadline).foregroundColor(Color(red: 188/255, green: 188/255, blue: 188/255)).bold()
                LabelledDivider(label: "Calculation")
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(red: 203/255, green: 153/255, blue: 126/255))
                            .frame(width: 350, height: 60)
                            .overlay(
                                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                                .overlay(
                                            
                                HStack{
                                                       //Text("Prayer Angles").font(.body).bold()
                            Button("Jurisprudence") {
                                                showingJurisprudence.toggle()
                                impactFeedbackgenerator.prepare()
                                impactFeedbackgenerator.impactOccurred()
                                                                                              }
                            .sheet(isPresented: $showingJurisprudence, content:{ JurisprudenceSelection( showModal: $showingJurisprudence)}).foregroundColor(textColor)
                                   Spacer()
                                    
                                    Text(jurisprudenceName == 0 ? "Hanafi" : "Shafi").foregroundColor(textColor).bold().onReceive(timer){
                                        new in
                                        jurisprudenceName = defaults.integer(forKey:"Madhab") ?? 0
                                        
                                    }
                                                }.padding()
                                            
                                            )

                                )
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                            
                                HStack{
                                       //Text("Prayer Angles").font(.body).bold()
            Button("Standard") {
                                showingStandard.toggle()
                impactFeedbackgenerator.prepare()
                impactFeedbackgenerator.impactOccurred()
            }
            .sheet(isPresented: $showingStandard, content:{ StandardSelection( showModal: $showingStandard)}).foregroundColor(textColor)
                                                                      
                                                                
                                                                      
                                                                     Spacer()
                                    Text(calculationName).foregroundColor(textColor).bold().onReceive(timer){
                                        new in
                                        calculationName = defaults.string(forKey:"Calculation") ?? "Not Found"
                                        switch(calculationName){
                                            
                                        case "0":
                                            calculationName = "  North America"
                                            break
                                        case "1":
                                            calculationName = "  Muslim World League"
                                            break
                                        case "2":
                                            calculationName = "  Umm Al Qura Makkah"
                                            break
                                        case "3":
                                            calculationName = "  Egypt"
                                            break
                                        case "4":
                                            calculationName = "  University of Tehran"
                                            break
                                        case "5":
                                            calculationName = "  Karachi"
                                            break
                                        default:
                                            calculationName = "  North America"
                                            break
                                      
                                        }
                                        
                                        
                                        
                                    }
                                }.padding()
                            
                            )
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                            
                                HStack{
                               
                                                                      Button("Manual Adjustment") {
                                                                                 showingManual.toggle()
                                                                          impactFeedbackgenerator.prepare()
                                                                          impactFeedbackgenerator.impactOccurred()
                                                                              }
                                                                      .sheet(isPresented: $showingManual, content:{ ManualAdjustment( showModal: $showingManual)}).foregroundColor(textColor)
                                                                      
                                                               
                                                                     
                                                                      
                                                                  
                                                                      
                                                                     Spacer()
                                                                  }.padding()
                            
                            )
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                            
                                HStack{
                                       //Text("Prayer Angles").font(.body).bold()
                                                                      Button("Prayer Angles") {
                                                                                 showingSheet.toggle()
                                                                          impactFeedbackgenerator.prepare()
                                                                          impactFeedbackgenerator.impactOccurred()
                                                                              }
                                                                      .sheet(isPresented: $showingSheet, content:{ AngleModification( showModal: $showingSheet)}).foregroundColor(textColor)
                                                                      
                                                                
                                                                      
                                                                     Spacer()
                                }.padding()
                            
                            )
                
                //ADVANCED OPTIONS ARE HERE
                //RoundedRectangle(cornerRadius: 10, style: .continuous)
                   // .fill(colorRectangle)
                        //    .frame(width: 350, height: 60)
                           // .overlay(
                             //   HStack(spacing:10){
                                                                      
                                                                   //   Button("Advanced Options") {
                                                                      //           showingAdvanced.toggle()
                                                                       //       }
                                                                      //.sheet(isPresented: $showingAdvanced, content:{ AdvancedOptions( showModal: $showingAdvanced)}).foregroundColor(textColor)
                                                                     // Image(systemName: "arrow.right.circle.fill")
                                                                      
                                                                     // Spacer()
                                                                     
                                                                 // }.padding()

                            
                           // )
                
                
            }.padding()
            
           
            
            VStack{
               
                
               // Text("Audio").font(.subheadline).foregroundColor(Color(red: 188/255, green: 188/255, blue: 188/255)).bold()
                //Divider().frame(height: 50).foregroundColor(<#T##color: Color?##Color?#>)
                LabelledDivider(label: "Sound")
               
        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                    .frame(width: 350, height: 60)
                    .overlay(
                        
                        VStack{
                        
                        HStack(spacing: 25){
                            
                            Text("Sound").font(.body).foregroundColor(textColor)
                          Spacer()
                            Toggle("", isOn: $soundToggle).onChange(of: soundToggle){
                                new in
                                print(new)
                                
                                defaults.set(new, forKey: "soundNotif")
                            }
                            
                            
                        }.padding(.top).padding(.leading).padding(.trailing)
                            
                            //HERE IS THE ATHAN SOUND
                           // LabelledDivider2(label: "")
                            //HStack( spacing: 25){
                                
                              //  Button("Athan Sound") {
                               //     showingSound.toggle()
                                //}
                                //.sheet(isPresented: $showingSound, content:{ SoundSelection( showModal: $showingSound)}).foregroundColor(textColor)
                                
                                //Spacer()
                             
                                //Text(soundStyle ?? "No Sound").onReceive(timer){
                                //    new in
                                 //   soundStyle = defaults.string(forKey: "athanSound") ?? "Default"
                                //}
                            //}.padding().foregroundColor(textColor)
                           
                            
                           Spacer()
                        }
                        
                        
            )

            }.padding()
        
           
          
            
            
            VStack{
                LabelledDivider2(label: "")
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                                HStack{
                                
                                
                                    
                                    Button("Reset to Default") {
                                        defaults.set(0, forKey: "ishaAdjust")
                                                   

                                         defaults.set(0, forKey: "maghribAdjust")
                                                  

                                         defaults.set(0, forKey: "asrAdjust")
                                                   
                                                    
                                        defaults.set(0, forKey: "dhuhrAdjust")
                                        defaults.set(0, forKey: "sunriseAdjust")
                                                    
                                         defaults.set(0, forKey: "fajrAdjust")
                                                 
                                                    
                                        defaults.set(0, forKey: "countdownValue")
                                                  

                                          defaults.set(15, forKey: "ishaAngle")
                                               

                                         defaults.set(0, forKey: "maghribAngle")
                                              

                                         defaults.set(15, forKey: "fajrAngle")
                                               
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                        
                                        
                                        
                                    }.foregroundColor(textColor)
                                        .sheet(isPresented: $showingManual, content:{ ManualAdjustment( showModal: $showingManual)}).foregroundColor(textColor)
                                    
                             
                                   
                                    
                        
                                    
                          
                                }
                                
                                //Button("Show Sheet") {
                                       //     showingSheet.toggle()
                                        //}
                                        //.sheet(isPresented: $showingSheet) {
                                            
                                        //}
                                
                                
                                
                                
                                )
            }.padding()
            
        }.navigationTitle("Settings").background(viewColor).edgesIgnoringSafeArea(.bottom).foregroundColor(headerColor)
        }.edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AngleModification: View {
    
  
    @State var fajrAngle = (defaults.object(forKey:"fajrAngle") != nil ? defaults.integer(forKey:"fajrAngle") : 15)
    @State var maghribAngle = (defaults.object(forKey:"maghribAngle") != nil ? defaults.integer(forKey:"maghribAngle") : 0)
    @State var ishaAngle = (defaults.object(forKey:"ishaAngle") != nil ? defaults.integer(forKey:"ishaAngle") : 15)
    @Binding var showModal: Bool
   
    var body: some View {
        
        
        
        VStack{
            HStack{
                Spacer()
                
                Button("Close") {
                           self.showModal.toggle()
                }.foregroundColor(headerColor)
            }.padding(.trailing).padding(.top)
            
            HStack{
                
                Text("Angle Modification").font(.title).foregroundColor(headerColor)
                Spacer()
                
                
                
            }.padding()
            
           
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                                
                                VStack{
                                    
                                    HStack{
                            
                                        Text("Fajr Angle").foregroundColor(textColor)
                                        Spacer()
                                        Text(String(fajrAngle) + "°").foregroundColor(stepperColor).bold()
                            Stepper("", value: $fajrAngle, in: -30...30).onChange(of: fajrAngle){
                                newValue in
                                                print("Name changed to \(fajrAngle)!")
                                impactFeedbackgenerator.prepare()
                                impactFeedbackgenerator.impactOccurred()
                                defaults.set(fajrAngle, forKey: "fajrAngle")
                                
                            }.frame(width:100)
                                        
                                    }.padding()
                                    
                                    
                                    
                                }.padding()
                               
                            )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Maghrib Angle").foregroundColor(textColor)
                                    Spacer()
                                    Text(String(maghribAngle) + "°").foregroundColor(stepperColor).bold()
                        Stepper("", value: $maghribAngle, in: -30...30).onChange(of: maghribAngle){
                            newValue in
                                            print("Name changed to \(maghribAngle)!")
                            defaults.set(maghribAngle, forKey: "maghribAngle")
                            impactFeedbackgenerator.prepare()
                            impactFeedbackgenerator.impactOccurred()
                            
                        }.frame(width: 100)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Isha Angle").foregroundColor(textColor)
                                    Spacer()
                                    
                                    Text(String(ishaAngle) + "°").foregroundColor(stepperColor).bold()
                        Stepper("", value: $ishaAngle, in: -30...30).onChange(of: ishaAngle){
                            newValue in
                                            print("Name changed to \(ishaAngle)!")
                            defaults.set(ishaAngle, forKey: "ishaAngle")
                            impactFeedbackgenerator.prepare()
                            impactFeedbackgenerator.impactOccurred()
                            
                        }.frame(width:100)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            Text("Select an angle to modify the prayer time. Default values are 15, 0, and 15 respectively.").font(.subheadline).foregroundColor(headerColor).padding(.leading).padding(.trailing)
            
        
                
                
         
            
            
            Spacer()
            
        }.padding().background(viewColor).edgesIgnoringSafeArea(.bottom)
        
        

    }
}


struct SoundSelection: View {
    
    
    @State var selection: Int = 0
    @Binding var showModal: Bool
    var selectedColor = Color(red: 252/255, green: 163/255, blue: 17/255)
    
    
    var body: some View {
        
        
        
        VStack{
            HStack{
                Spacer()
                Button("Close") {
                           self.showModal.toggle()
                }.foregroundColor(headerColor)
                
            }.padding(.trailing).padding(.top)
            
            HStack{
                
                Text("Athan Sound").font(.title).foregroundColor(headerColor)
                Spacer()
                
                
                
            }.padding()
            
           
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                                
                               
                                VStack{
                                HStack(spacing: 25){
                            
                                        Button("None") {
                                                     
                                            defaults.set("None", forKey: "athanSound")
                                            impactFeedbackgenerator.prepare()
                                            impactFeedbackgenerator.impactOccurred()
                                      
                                        }.foregroundColor(defaults.string(forKey: "athanSound") == "None" ? selectedColor : textColor)

                                                  
                                    Spacer()
                                }.padding()
                                }.padding()
                            )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Default iOS") {
                                         
                                        defaults.set("Default iOS", forKey: "athanSound")
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                   
                                    }.foregroundColor(defaults.string(forKey: "Default iOS") == "None" ? selectedColor : textColor)

                                             
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Madina") {
                                         
                                        defaults.set("Madina", forKey: "athanSound")
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                   
                                    }.foregroundColor(defaults.string(forKey: "athanSound") == "Madina" ? selectedColor : textColor)

                                             
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Makkah") {
                                         
                                        defaults.set("Makkah", forKey: "athanSound")
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                   
                                    }.foregroundColor(defaults.string(forKey: "athanSound") == "Makkah" ? selectedColor : textColor)

                                             
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Abdul-Basit") {
                                         
                                        defaults.set("Abdul-Basit", forKey: "athanSound")
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                   
                                    }.foregroundColor(defaults.string(forKey: "athanSound") == "Abdul-Basit" ? selectedColor : textColor)

                                             
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Abdul-Ghaffar") {
                                         
                                        defaults.set("Abdul-Ghaffar", forKey: "athanSound")
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                   
                                    }.foregroundColor(defaults.string(forKey: "athanSound") == "Abdul-Ghaffar" ? selectedColor : textColor)

                                             
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            
            
            
            Text("Select an Athan Sound to be played for each prayer timing notification").font(.subheadline).foregroundColor(headerColor).padding(.leading).padding(.trailing)
            
        
                
                
         
            
            
            Spacer()
            
        }.padding().background(viewColor).edgesIgnoringSafeArea(.bottom)
        
        

    }
}


struct JurisprudenceSelection: View {
    
    
    @State var selection: Int = 0
    @Binding var showModal: Bool
    var selectedColor = Color(red: 252/255, green: 163/255, blue: 17/255)
    
    @State var soundSelection: Int = defaults.integer(forKey: "Madhab")
   
    var body: some View {
        
        
        
        VStack{
            HStack{
                Spacer()
                Button("Close") {
                           self.showModal.toggle()
                }.foregroundColor(headerColor)
                
            }.padding(.trailing).padding(.top)
            
            HStack{
                
                Text("Jurisprudence").font(.title).foregroundColor(headerColor)
                Spacer()
                
                
                
            }.padding()
            
           
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                                
                               
                                VStack{
                                HStack(spacing: 25){
                            
                                        Button("Hanafi") {
                                                     selection = 0
                                            defaults.set(0, forKey: "Madhab")
                                            print("selection", selection)
                                            impactFeedbackgenerator.prepare()
                                            impactFeedbackgenerator.impactOccurred()
                                        }.foregroundColor(defaults.integer(forKey: "Madhab") == 0 ? selectedColor : textColor)
                                    //firstCard == secondCard ? "Cards are the same" : "Cards are different"
                                                  
                                    Spacer()
                                }.padding()
                                }.padding()
                            )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Shaafi") {
                                                 selection = 1
                                        defaults.set(1, forKey: "Madhab")
                                        print("selection", selection)
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                    }.foregroundColor(defaults.integer(forKey: "Madhab") == 1 ? selectedColor : textColor)

                                             
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            Text("Select a jurisprudence method to determine Asr time").font(.subheadline).foregroundColor(headerColor).padding(.leading).padding(.trailing)
            
        
                
                
         
            
            
            Spacer()
            
        }.padding().background(viewColor).edgesIgnoringSafeArea(.bottom)
        
        

    }
}


struct StandardSelection: View {
    
    
    @State var selection: Int = 0
    @Binding var showModal: Bool
    var selectedColor = Color(red: 252/255, green: 163/255, blue: 17/255)
   
    var body: some View {
        
        
        
        VStack{
            HStack{
                Spacer()
                Button("Close") {
                           self.showModal.toggle()
                }.foregroundColor(headerColor)
                
            }.padding(.trailing).padding(.top)
            
            HStack{
                
                Text("Calculation Standard").font(.title).foregroundColor(headerColor)
                Spacer()
                
                
                
            }.padding()
            
           
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                                
                               
                                VStack{
                                HStack(spacing: 25){
                            
                                        Button("North America (ISNA)") {
                                                     selection = 0
                                            defaults.set(0, forKey: "Calculation")
                                            print(selection)
                                            impactFeedbackgenerator.prepare()
                                            impactFeedbackgenerator.impactOccurred()
                                        }.foregroundColor(defaults.integer(forKey: "Calculation") == 0 ? selectedColor : textColor)

                                                 
                                    Spacer()
                                }.padding()
                                }.padding()
                            )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Muslim World League") {
                                                 selection = 1
                                        defaults.set(1, forKey: "Calculation")
                                        print(selection)
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                    }.foregroundColor(defaults.integer(forKey: "Calculation") == 1 ? selectedColor : textColor)

                                              
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Umm Al Qura Makkah") {
                                                 selection = 2
                                        defaults.set(2, forKey: "Calculation")
                                        print(selection)
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                    }.foregroundColor(defaults.integer(forKey: "Calculation") == 2 ? selectedColor : textColor)

                                             
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Egyptian General Authority Survey") {
                                                 selection = 3
                                        defaults.set(3, forKey: "Calculation")
                                        print(selection)
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                    }.foregroundColor(defaults.integer(forKey: "Calculation") == 3 ? selectedColor : textColor)

                                              
                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("University of Tehran") {
                                                 selection = 4
                                        defaults.set(4, forKey: "Calculation")
                                        print(selection)
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                    }.foregroundColor(defaults.integer(forKey: "Calculation") == 4 ? selectedColor : textColor)

                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                           
                            VStack{
                            HStack(spacing: 25){
                        
                                    Button("Karachi") {
                                                 selection = 5
                                        defaults.set(5, forKey: "Calculation")
                                        print(selection)
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                    }.foregroundColor(defaults.integer(forKey: "Calculation") == 5 ? selectedColor : textColor)

                                Spacer()
                            }.padding()
                            }.padding()
                        )
            
          
            
           
            
            
        
            
            
            
            Text("Select a calculation standard to determine all prayer times").font(.subheadline).foregroundColor(headerColor).padding(.leading).padding(.trailing)
            
        
                
                
         
            
            
            Spacer()
            
        }.padding().background(viewColor).edgesIgnoringSafeArea(.bottom)
        
        
      

    }
}


struct ManualAdjustment: View {
    
    @State var age: Int = 0
    @State var fajrAdjustment = defaults.object(forKey:"fajrAdjust") != nil ? defaults.integer(forKey:"fajrAdjust") : 0
    @State var sunriseAdjustment = defaults.object(forKey:"sunriseAdjust") != nil ? defaults.integer(forKey:"sunriseAdjust") : 0
    @State  var dhuhrAdjustment = defaults.object(forKey:"dhuhrAdjust") != nil ? defaults.integer(forKey:"dhuhrAdjust") : 0
    @State var asrAdjustment = defaults.object(forKey:"asrAdjust") != nil ? defaults.integer(forKey:"asrAdjust") : 0
    @State  var maghribAdjustment = defaults.object(forKey:"maghribAdjust") != nil ? defaults.integer(forKey:"maghribAdjust") : 0
    @State var ishaAdjustment = defaults.object(forKey:"ishaAdjust") != nil ? defaults.integer(forKey:"ishaAdjust") : 0
    @Binding var showModal: Bool
    var body: some View {
        
        
        
        VStack{
            HStack{
                Spacer()
                Button("Close") {
                           self.showModal.toggle()
                }.foregroundColor(headerColor)
                
            }.padding(.trailing).padding(.top)
            
            HStack{
                
                Text("Manual Adjustment").font(.title).foregroundColor(headerColor)
                Spacer()
                
             
                
            }.padding()
            
           
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                                
                                VStack{
                                    
                                    HStack{
                            
                                        Text("Fajr").foregroundColor(textColor)
                                        Spacer()
                                        Text(String(fajrAdjustment) + " minutes").foregroundColor(stepperColor).bold()
                                        
                            Stepper("", value: $fajrAdjustment, in: -30...30).onChange(of: fajrAdjustment){
                                newValue in
                                                print("Name changed to \(fajrAdjustment)!")
                                defaults.set(fajrAdjustment, forKey: "fajrAdjust")
                                impactFeedbackgenerator.prepare()
                                impactFeedbackgenerator.impactOccurred()
                                
                            }.frame(width: 100)
                                        
                                    }.padding()
                                    
                                    
                                    
                                }.padding()
                               
                            )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Sunrise").foregroundColor(textColor)
                                    Spacer()
                                    Text(String(sunriseAdjustment) + " minutes").foregroundColor(stepperColor).bold()
                        Stepper("", value: $sunriseAdjustment, in: -30...30).onChange(of: sunriseAdjustment){
                            newValue in
                                            print("Name changed to \(sunriseAdjustment)!")
                            defaults.set(sunriseAdjustment, forKey: "sunriseAdjust")
                            impactFeedbackgenerator.prepare()
                            impactFeedbackgenerator.impactOccurred()
                            
                        }.frame(width:100)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Dhuhr").foregroundColor(textColor)
                                    Spacer()
                                    Text(String(dhuhrAdjustment) + " minutes").foregroundColor(stepperColor).bold()
                        Stepper("", value: $dhuhrAdjustment, in: -30...30).onChange(of: dhuhrAdjustment){
                            newValue in
                                            print("Name changed to \(dhuhrAdjustment)!")
                            defaults.set(dhuhrAdjustment, forKey: "dhuhrAdjust")
                            impactFeedbackgenerator.prepare()
                            impactFeedbackgenerator.impactOccurred()
                            
                        }.frame(width: 100)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Asr").foregroundColor(textColor)
                                    Spacer()
                                    Text(String(asrAdjustment) + " minutes").foregroundColor(stepperColor).bold()
                        Stepper("", value: $asrAdjustment, in: -30...30).onChange(of: asrAdjustment){
                            newValue in
                                            print("Name changed to \(asrAdjustment)!")
                            defaults.set(asrAdjustment, forKey: "asrAdjust")
                            impactFeedbackgenerator.prepare()
                            impactFeedbackgenerator.impactOccurred()
                            
                        }.frame(width: 100)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Maghrib").foregroundColor(textColor)
                                    Spacer()
                                    Text(String(maghribAdjustment) + " minutes").foregroundColor(stepperColor).bold()
                        Stepper("", value: $maghribAdjustment, in: -30...30).onChange(of: maghribAdjustment){
                            newValue in
                                            print("Name changed to \(maghribAdjustment)!")
                            defaults.set(maghribAdjustment, forKey: "maghribAdjust")
                            impactFeedbackgenerator.prepare()
                            impactFeedbackgenerator.impactOccurred()
                            
                        }.frame(width: 100)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Isha").foregroundColor(textColor)
                                    Spacer()
                                    Text(String(ishaAdjustment) + " minutes").foregroundColor(stepperColor).bold()
                                    Stepper("", value: $ishaAdjustment, in: -30...30).onChange(of: ishaAdjustment){
                                        newValue in
                                                        print("Name changed to \(ishaAdjustment)!")
                                        defaults.set(ishaAdjustment, forKey: "ishaAdjust")
                                        impactFeedbackgenerator.prepare()
                                        impactFeedbackgenerator.impactOccurred()
                                        
                                    }.frame(width: 100)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            Text("Select individual time adjustments in minutes for each prayer. Default value is 0 minutes for all prayers.").font(.subheadline).foregroundColor(headerColor).padding(.leading).padding(.trailing)
            
        
                
                
         
            
            
            Spacer()
            
        }.padding().background(viewColor).edgesIgnoringSafeArea(.bottom)
        
        

    }
}




struct AdvancedOptions: View {
    
    @State var age: Int = 0
    @Binding var showModal: Bool
   
    var body: some View {
        
        
        
        VStack{
            HStack{
                Spacer()
                Button("Close") {
                           self.showModal.toggle()
                }.foregroundColor(headerColor)
                
            }.padding(.trailing).padding(.top)
            
            HStack{
                
                Text("Advanced Calculation").font(.title).foregroundColor(headerColor)
                Spacer()
                
                
                
            }.padding()
            
           
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(colorRectangle)
                            .frame(width: 350, height: 60)
                            .overlay(
                                
                                VStack{
                                    
                                    HStack{
                            
                                        Text("High-Altitude").foregroundColor(textColor)
                                        Spacer()
                            Stepper("", value: $age, in: 0...130)
                                        
                                    }.padding()
                                    
                                    
                                    
                                }.padding()
                               
                            )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Two-Thirds").foregroundColor(textColor)
                                    Spacer()
                        Stepper("", value: $age, in: 0...130)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(colorRectangle)
                        .frame(width: 350, height: 60)
                        .overlay(
                            
                            VStack{
                                
                                HStack{
                        
                                    Text("Dhuhr").foregroundColor(textColor)
                                    Spacer()
                        Stepper("", value: $age, in: 0...130)
                                    
                                }.padding()
                                
                                
                                
                            }.padding()
                        )
        
            
           
            Text("Select individual time adjustments in minutes for each prayer. Default value is 0 minutes for all prayers.").font(.subheadline).foregroundColor(headerColor).padding(.leading).padding(.trailing)
            
        
                
                
         
            
            
            Spacer()
            
        }.padding().background(viewColor).edgesIgnoringSafeArea(.bottom)
        
        

    }
}

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            
            Text(label).foregroundColor(Color(red: 222/255, green: 226/255, blue: 230/255))
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(10)
    }
}

struct LabelledDivider2: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line.padding(.leading).padding(.trailing)
            
        
        }
    }

    var line: some View {
        VStack { Divider().background(color) }
    }
}


