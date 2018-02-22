//
//  ViewController.swift
//  Bluetooth
//
//  Created by Rahul Avale on 2/21/18.
//  Copyright © 2018 Rahul Avale. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate {
    
    var centralManager : CBCentralManager?
    var peripheralArray : [peripheralInfo] = []
    var timer : Timer?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let peripheralData = peripheralInfo()
        
        if let newName = peripheral.name {
            print("Peripheral Name: \(newName)")
            for names in peripheralArray {
                if names.name != newName {
                    peripheralData.name = newName
                }
            }
            
        } else {
            peripheralData.name = peripheral.identifier.uuidString
        }
        peripheralData.rssiNum = RSSI
        
        peripheralArray.append(peripheralData)
        
        tableView.reloadData()
        
//        print("Peripheral UUID: \(peripheral.identifier.uuidString)")
//        print("Peripheral RSSI: \(RSSI)")
//        print("Advertisement data: \(advertisementData)")
//        print("*****************************************************")
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScan()
            startTimer()
        } else {
            let alert = UIAlertController(title: "Bluetooth isn't working", message: "Make sure your bluetooth is switched on", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func startScan() {
        peripheralArray = []
        tableView.reloadData()
        centralManager?.stopScan()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { (timer) in
            self.startScan()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheralArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "blueCell", for: indexPath) as? bluetoothTableViewCell {
            cell.peripheralNameLabel.text = peripheralArray[indexPath.row].name
            cell.rssiLabel.text = "RSSI : \(peripheralArray[indexPath.row].rssiNum)"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    
    @IBAction func refreshButton(_ sender: Any) {
        startScan()
        startTimer()
    }
    

}

