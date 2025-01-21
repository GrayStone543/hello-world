//
//  MainController.swift
//  BLETool
//
//  Created by 蔡青峰 on 2025/1/21.
//

import Foundation
import CoreBluetooth


class BluetoothManager : NSObject, CBCentralManagerDelegate, ObservableObject {
    @Published var isBluetoothEnabled = false
    @Published var discoveredPeripherals = [CBPeripheral]()
    
    private var centralManager : CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isBluetoothEnabled = true
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            isBluetoothEnabled = false
        }
        
        switch(central.state)
        {
        case.unsupported:
            print("BLE is not supported")
        case.unauthorized:
            print("BLE is unauthorized")
        case.unknown:
            print("BLE is Unknown")
        case.resetting:
            print("BLE is Resetting")
        case.poweredOff:
            print("BLE service is powered off")
        case.poweredOn:
            print("BLE service is powered on")
        default:
            print("default state")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(peripheral) {
            discoveredPeripherals.append(peripheral)
        }
    }
    
    func toggleBluetooth() {
        if centralManager.state == .poweredOn {
            centralManager.stopScan()
            centralManager = nil
        }
        else {
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
    }
}

//class BLEManager {
//    var centralManager : CBCentralManager!
//    var bleHandler : BLEHandler // delegate
//    init() {
//        self.bleHandler = BLEHandler()
//        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue:nil)
//    }
//}

