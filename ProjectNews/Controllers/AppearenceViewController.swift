//
//  AppearenceViewController.swift
//  ProjectNews
//
//  Created by edgars.vasiljevs on 23/11/2021.
//

import UIKit


class AppearenceViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func openSettingsButtonTapped(_ sender: Any) {
        openSettings()
    }
    
    func setLabeltext(){
        var text = "Uable to specify UI style"
        if self.traitCollection.userInterfaceStyle == .dark {
            text = "Dark Mode is On. \nGo to settings if you would like \nto change to Light Mode"
        }else{
            text = "Light Mode is On. \nGo to settings if you would like \nto change to Dark Mode"
        }
        textLabel.text = text
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openSettings(){
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
        if UIApplication.shared.canOpenURL(settingsURL){
            UIApplication.shared.open(settingsURL, options: [:]) { success in
                print("open: ", success)
            }
        }
    }
    
}

    extension AppearenceViewController{
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            setLabeltext()
        }
    }

