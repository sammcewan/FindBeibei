//
//  DogLocatorController.swift
//  FindBeiBei
//
//  Created by Sam McEwan on 9/07/14.
//  Copyright (c) 2014 Sam McEwan. All rights reserved.
//

import UIKit

class DogLocatorController: UIViewController, ESTBeaconManagerDelegate {

  var beaconManager : ESTBeaconManager = ESTBeaconManager()

  var distanceHistory : [Float] = []
  var averageDistance : Float = 0.0
  var dogDistance:Float {
    set(newDistance) {
      distanceHistory += newDistance
      if distanceHistory.count > 3 {
        distanceHistory.removeAtIndex(0)
      }
      averageDistance = 0.0
      for distanceValue in distanceHistory {
        averageDistance += distanceValue
      }
      averageDistance = (averageDistance/Float(distanceHistory.count))
      updateView(averageDistance)
    }
    get {
      return averageDistance
    }
  }

  func updateView(distance: Float) {
    switch distance {
      case 0.0...3.0:
        view.backgroundColor = UIColor.beicon_01()
      case 4.0...7.0:
        view.backgroundColor = UIColor.beicon_12()
      case 7.0...9.0:
        view.backgroundColor = UIColor.beicon_23()
      case 9.0...12.0:
        view.backgroundColor = UIColor.beicon_35()
      case 12.0...15.0:
        view.backgroundColor = UIColor.beicon_57()
      case 15.0...20.0:
        view.backgroundColor = UIColor.beicon_710()
      default:
        view.backgroundColor = UIColor.blackColor()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let regionUUID = NSUUID(UUIDString:"B9407F30-F5F8-466E-AFF9-25556B57FE6D")
    let beaconRegion = ESTBeaconRegion(proximityUUID:regionUUID, identifier: "EstimoteSampleRegion");

    beaconManager.delegate = self
    beaconManager.startRangingBeaconsInRegion(beaconRegion);
  }



  func beaconManager(manager: ESTBeaconManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: ESTBeaconRegion!) {
    for beacon in beacons {
      if beacon.major == 12223 && beacon.minor == 58954 {
        let distanceNumber : NSNumber = beacon.distance
        self.dogDistance = distanceNumber.floatValue;

        println(beacon.distance)
        println(self.dogDistance)      }
    }
    println("---")
  }

  func beaconManager(manager: ESTBeaconManager!, rangingBeaconsDidFailForRegion region: ESTBeaconRegion!, withError error: NSError!) {

  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
}

