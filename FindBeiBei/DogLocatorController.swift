//
//  DogLocatorController.swift
//  FindBeiBei
//
//  Created by Sam McEwan on 9/07/14.
//  Copyright (c) 2014 Sam McEwan. All rights reserved.
//

import UIKit

class DogLocatorController: UIViewController, ESTBeaconManagerDelegate {

  let beaconManager : ESTBeaconManager = ESTBeaconManager()

  override func viewDidLoad() {
    super.viewDidLoad()

    let regionUUID = NSUUID(UUIDString:"B9407F30-F5F8-466E-AFF9-25556B57FE6D")
    let beaconRegion = ESTBeaconRegion(proximityUUID:regionUUID, identifier: "EstimoteSampleRegion");

    beaconManager.delegate = self
    beaconManager.startRangingBeaconsInRegion(beaconRegion);
  }

  func beaconManager(manager: ESTBeaconManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: ESTBeaconRegion!) {
    for beacon in beacons {
      println(beacon.distance)
    }
    println("---")
  }

  func beaconManager(manager: ESTBeaconManager!, rangingBeaconsDidFailForRegion region: ESTBeaconRegion!, withError error: NSError!) {

  }
}

