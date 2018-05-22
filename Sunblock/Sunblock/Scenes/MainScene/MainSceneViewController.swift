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

    private var currentEnvironment: Environment {
        return Environment.load()
    }

    private var currentSkinType: SkinType {
        return SkinType.load()
    }

    private var weathers: [Weather] = []{
        didSet{
            // Update SSE..
        }
    }

    private var currentSPF: Int = 0{
        didSet{
            // Update SSE..
        }
    }

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

//MARK: - SSE
extension MainSceneViewController{
    private func updateSSE(){
        
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
        if let lastLocation = UserLocation.load(){
            if lastLocation != location{
                // Clear Persistance
                location.save()
                CoreDataStack.current.clearStorage()
                // Load new weather data from Net
                loadWeathersFromNet(for: location)
            }else{
                // Get list of weather for current location,
                if let weathers = Weather.loadWeathersFromPersistance(),
                    !weathers.isEmpty{
                    // Take the first weather and Update SSE
                }else{
                    CoreDataStack.current.clearStorage()
                    loadWeathersFromNet(for: location)
                }
            }
        }else{
            location.save()
            loadWeathersFromNet(for: location)
        }
    }

    private func loadWeathersFromNet(for location: UserLocation){
        let client = WeatherClient()
        client.getFeed(from: .getWeather(location)) { (result) in
            switch result{
            case .success(let response):
                guard let response = response else {
                    AlertService.presentAlert(with: "Could not download new weather data, please try again later")
                    return
                }
                let currentWeathers = CoreDataStack.current.createWeathers(from: response)
                self.weathers = currentWeathers
            case .failure(let error):
                AlertService.presentAlert(with: error.localizedDescription)
            }
        }
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
        environment.save()
    }
}
