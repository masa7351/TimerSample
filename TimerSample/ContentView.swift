//
//  ContentView.swift
//  TimerSample
//
//  Created by Masanao Imai on 2019/10/24.
//  Copyright © 2019 Masanao Imai. All rights reserved.
//

import CombineTimer
import SwiftUI

struct ContentView: View {
    @ObservedObject private var timer: CountDownTimer
    @State private var isFirst: Bool = true
    @State private var timeSelection: Int = 3
    let selectableTimes: [Int] = [10, 20, 30, 60]
    private var setupTime: Int {
        selectableTimes[timeSelection]
    }

    init(timer: CountDownTimer = CountDownTimer(count: 60)) {
        self.timer = timer
    }

    private var canResume: Bool {
        return !isFirst && timer.hasTime
    }

    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section {
                        Text("Remaining time: \(timer.count)s")
                    }
                    if timer.isRunning {
                        Button(action: {
                            self.timer.stop()
                        }, label: { Text("Stop") })
                    } else {
                        Picker(selection: $timeSelection, label: Text("Timer")) {
                            ForEach(0 ..< selectableTimes.count) {
                                Text("\(self.selectableTimes[$0])s")
                            }
                        }
                        Section {
                            if canResume {
                                Button(action: {
                                    self.timer.resume()
                                }, label: { Text("Resume") })
                            }
                            Button(action: {
                                self.isFirst.toggle()
                                self.timer.start(self.setupTime)
                            }, label: { Text("Start") })
                        }
                    }
                }
                if self.timer.isFinish {
                    Text("Timer is finish.")
                }
            }.navigationBarTitle(Text("Cound Down"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
