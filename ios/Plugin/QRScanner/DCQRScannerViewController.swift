//
//  DCQRScannerViewController.swift
//  DiningCity
//
//  Created by JinJin Lee on 6/25/21.
//  Copyright © 2021 Development. All rights reserved.
//

import UIKit
import MercariQRScanner

protocol DCQRScannerViewControllerDelegate {
    func viewController(_ viewController: DCQRScannerViewController, didScanCode code: String)
}

class DCQRScannerViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var qrScannerView: QRScannerView!
    
    var delegate: DCQRScannerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize buttons
        closeButton.setImage(UIImage(named: "QRScanner.bundle/ic_close"), for: .normal)
        
        flashButton.setImage(UIImage(named: "QRScanner.bundle/ic_flash_off"), for: .normal)
        flashButton.setImage(UIImage(named: "QRScanner.bundle/ic_flash_on"), for: .selected)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        qrScannerView.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        qrScannerView.stopRunning()
    }

    
    // MARK: - Event Handlers
    @IBAction func onClickClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickFlash(_ sender: Any) {
        qrScannerView.setTorchActive(isOn: !flashButton.isSelected)
    }
}

// MARK: - QRScannerViewDelegate
extension DCQRScannerViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        dismiss(animated: true) {
            self.delegate?.viewController(self, didScanCode: code)
        }
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didChangeTorchActive isOn: Bool) {
        flashButton.isSelected = isOn
    }
}
