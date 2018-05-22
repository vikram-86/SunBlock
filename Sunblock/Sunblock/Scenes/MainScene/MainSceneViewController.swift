//
//  MainSceneViewController.swift
//  Sunblock
//
//  Created by Suthananth Arulanatham on 03.04.2018.
//  Copyright © 2018 Shortcut. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {

    // Private
    private struct SegueIdentifers{
        static let spfSegue    		= "spfSegue"
        static let mainToDisclaimer	= "mainToDisclaimer"
        static let mainToLocation	= "mainToLocation"

        private init(){}
    }

    @IBOutlet weak var segmentView	: SegmentChooserView!
    @IBOutlet weak var spfSelectionView: SPFSelectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.appColor(.perryWinkle)
        

        segmentView.delegate 				= self
        spfSelectionView.delegate 			= self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationService.current.delegate    = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let status = OnboardingStatus.load(){
            switch (status.hasCompletedOnboardin, status.locationServiceGranted){
            case (false, _):
                performSegue(withIdentifier: SegueIdentifers.mainToDisclaimer, sender: nil)
            case (true, true):
                LocationService.current.requestLocation()
            case (true, false):
                performSegue(withIdentifier: SegueIdentifers.mainToLocation, sender: nil)

            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationService.current.delegate = nil

    }


}

extension MainSceneViewController{

    @objc private func selectSunscreen(){
        performSegue(withIdentifier: SegueIdentifers.spfSegue, sender: nil)
    }
    
}

//MARK: Location Service Delegate
extension MainSceneViewController: LocationServiceDelegate{
    func locationServiceDidFinish(with location: UserLocation) {

        // Check location change and empty weather list

//        let client = WeatherClient()
//        client.getFeed(from: .getWeather(location)) { (result) in
//            switch result{
//            case .success(let weatherResponse):
//                guard let response = weatherResponse else { return }
//                CoreDataStack.current.createWeathers(from: response)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }

    func locationServiceDidFinishWithError(_ error: LocationError) {
        AlertService.presentAlert(with: error.errorDescription!)
    }

    func permissionChanged(_ permission: PermissionStatus) {
        if permission == .granted{
            LocationService.current.requestLocation()
        }
    }
}

//MARK: SPFDelegate
extension MainSceneViewController: SPFDelegate{
    func selectorSelected(spf: Int) {
        print(spf)
    }
}

//MARK: SegmentChooserDelegate
extension MainSceneViewController: SegmentChooserDelegate{

    func segmentSelected(environment: Environment) {
        // Update SSE
    }
}
