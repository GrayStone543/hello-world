//
//  ContentView.swift
//  BLETool
//
//  Created by 蔡青峰 on 2025/1/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bluetoothManager = BluetoothManager() // this is Bluetooth manager
            
    var body: some View {
        VStack {
            Button(action: {
                bluetoothManager.toggleBluetooth()
            }) {
                Text(bluetoothManager.isBluetoothEnabled ? "Turn Off Bluetooth" : "Turn On Bluetooth").padding()
            }
            Text("Bluetooth is \(bluetoothManager.isBluetoothEnabled ? "enabled" : "disabled")").padding()
            List(bluetoothManager.discoveredPeripherals, id: \.identifier) {
                peripheral in Text(peripheral.name ?? "Unknown")
            }
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!").padding()
        }
    }
}

#Preview {
    ContentView()
}
