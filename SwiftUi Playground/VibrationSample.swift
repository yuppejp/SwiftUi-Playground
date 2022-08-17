//
//  NotificationFeedbackSample.swift
//  SwiftUi Playground
//  
//  Created on 2022/08/17
//  
//

import SwiftUI
import AudioToolbox

struct VibrationSample: View {
    
    let generator = UINotificationFeedbackGenerator()
    @State var isVibrationOn = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 10.0) {
                // UINotificationFeedbackGenerator
                Group{
                    Button(action: {
                        self.generator.notificationOccurred(.success)
                    }) {
                        Text("Notification - Success")
                    }
                    
                    Button(action: {
                        self.generator.notificationOccurred(.error)
                    }) {
                        Text("Notification - Error")
                    }
                    
                    Button(action: {
                        self.generator.notificationOccurred(.warning)
                    }) {
                        Text("Notification - Warning")
                    }
                    
                    Button(action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                    }) {
                        Text("Impact - Light")
                    }
                    
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }) {
                        Text("Impact - Medium")
                    }
                    
                    Button(action: {
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                    }) {
                        Text("Impact - Heavy")
                    }
                    
                    Button(action: {
                        let selectionFeedback = UISelectionFeedbackGenerator()
                        selectionFeedback.selectionChanged()
                    }) {
                        Text("Selection Feedback - Changed")
                    }
                }
                
                // AudioToolbox
                Group{
                    //
                    Button(action: {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                    }) {
                        Text("kSystemSoundID_Vibrate")
                    }
                    
                    Button(action: {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1102)) {}
                    }) {
                        Text("1102")
                    }
                    
                    Button(action: {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1519)) {}
                    }) {
                        Text("1519")
                    }
                    
                    Button(action: {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1520)) {}
                    }) {
                        Text("1520")
                    }
                    
                    Button(action: {
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(1521)) {}
                    }) {
                        Text("1521")
                    }
                }
                
                Group{
                    
                    Button(action: {
                        for _ in 0...2{
                            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                            sleep(1)
                        }
                    }) {
                        Text("kSystemSoundID_Vibrate * 3 / every 1sec")
                    }
                    
                    Button(action: {
                        for _ in 0...2{
                            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                            Thread.sleep(forTimeInterval: 1.5)
                        }
                    }) {
                        Text("kSystemSoundID_Vibrate * 3 / every 1.5sec")
                    }
                    
                    Text("VibrationNoLimit")
                    HStack{
                        Button(action: {
                            isVibrationOn = true
                            makeVibrationNoLimit()
                        }) {
                            Text("ON")
                        }
                        
                        Button(action: {
                            isVibrationOn = false
                        }) {
                            Text("OFF")
                        }
                    }
                }
            }
            .padding(.all, 30.0)
        }
    }
    
    func makeVibrationNoLimit() {
        if !isVibrationOn {
            return
        }
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {
            makeVibrationNoLimit()
            sleep(1)
        }
    }
    
}

struct NotificationFeedbackSample_Previews: PreviewProvider {
    static var previews: some View {
        VibrationSample()
    }
}
