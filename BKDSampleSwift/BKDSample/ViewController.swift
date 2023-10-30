//
//  ViewController.swift
//  BKDSample
//

import UIKit
import BarkoderSDK

final class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var barkoderView: BarkoderView!
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet private weak var introLabel: UILabel!
    @IBOutlet private weak var typeHolderView: UIView!
    @IBOutlet private weak var resultHolderView: UIView!
    @IBOutlet private weak var extrasHolderView: UIView!
    @IBOutlet private weak var scanButton: UIButton!
    
    @IBOutlet private weak var typeResultLabel: UILabel!
    @IBOutlet private weak var resultValueLabel: UILabel!
    @IBOutlet private weak var extrasResultLabel: UILabel!
    
    // MARK: - Constants
    
    private let holderViewBackgroundColor: UIColor = .white
    private let barkoderBackgroundColor: UIColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
    private let resultsMaximumLines = 2
    private let holderViewCornerRadius = 16.0
    
    private var scanningInProcess: Bool = false {
        didSet {
            scanButton?.configuration?.baseBackgroundColor = scanningInProcess
                ? UIColor(red: 1.00, green: 0.00, blue: 0.13, alpha: 1.00)
                : UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
        }
    }
    private var resultFromScanning: String?
        
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        createBarkoderConfig()
        setActiveBarcodeTypes()
        setBarkoderSettings()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Barkoder Sample (v\(iBarkoder.GetVersion()))"

        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        
        barkoderView.backgroundColor = barkoderBackgroundColor
        
        typeHolderView.backgroundColor = holderViewBackgroundColor
        typeHolderView.layer.cornerRadius = holderViewCornerRadius
        
        resultHolderView.backgroundColor = holderViewBackgroundColor
        resultHolderView.layer.cornerRadius = holderViewCornerRadius
        resultHolderView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapViewAllResult)))
        
        extrasHolderView.backgroundColor = holderViewBackgroundColor
        extrasHolderView.layer.cornerRadius = holderViewCornerRadius
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(named: "btn_ffa")
        configuration.baseBackgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
        configuration.cornerStyle = .capsule
        scanButton.configuration = configuration
        scanButton.layer.shadowColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00).cgColor
        scanButton.layer.shadowOpacity = 0.05
        scanButton.layer.shadowOffset = .zero
        scanButton.layer.shadowRadius = 10

        typeResultLabel.numberOfLines = resultsMaximumLines
        resultValueLabel.numberOfLines = resultsMaximumLines
        extrasResultLabel.numberOfLines = resultsMaximumLines
    }
        
    private func createBarkoderConfig() {
        // In order to perform scanning, config property need to be set before
        // If license key is not valid you will receive results with asterisks inside
        barkoderView.config = BarkoderConfig(licenseKey: "LICENSE_KEY") { licenseResult in
            print("Licensing SDK: \(licenseResult)")
        }
    }
    
    private func setActiveBarcodeTypes() {
        guard let decoderConfig = barkoderView.config?.decoderConfig else { return }
        decoderConfig.ean13.enabled = true
        decoderConfig.upcA.enabled = true
        decoderConfig.qr.enabled = true
    }
    
    private func setBarkoderSettings() {
        guard let config = barkoderView.config else { return }
            
        // These are optional settings, otherwise default values will be used
        config.imageResultEnabled = true
        config.locationInImageResultEnabled = true
        config.regionOfInterestVisible = true
        config.pinchToZoomEnabled = true
        try? config.setRegionOfInterest(CGRect(x: 5, y: 5, width: 90, height: 90))
    }
        
    // MARK: - IBActions
    
    @IBAction private func didTapScanButton(_ sender: Any) {
        startScanning()
    }
    
    @objc private func didTapViewAllResult() {
        guard (resultFromScanning != nil) else { return }
        
        let alert = UIAlertController(title: "Result", message: resultFromScanning, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(continueAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}

extension ViewController: BarkoderResultDelegate {

    func scanningFinished(_ decoderResults: [DecoderResult], thumbnails: [UIImage]?, image: UIImage?) {
        if let decoderResult = decoderResults.first {
            showResult(decoderResult, image: image)
        }
        
        scanningInProcess = false
    }



}

private extension ViewController {
    
    private func showResult(_ decoderResult: DecoderResult, image: UIImage?) {
        resultImageView.image = image

        typeResultLabel.text = decoderResult.barcodeTypeName
        
        resultValueLabel.text = decoderResult.textualData
        resultFromScanning = decoderResult.textualData
        
        let extras: [String] = decoderResult.extra.map {
            return "\($0): \($1)"
        }
        
        extrasResultLabel.text = extras.joined(separator: "\n")
    }

    func startScanning() {
        if !scanningInProcess {
            try? barkoderView.startScanning(self)
        } else {
            barkoderView.stopScanning()
        }
        
        resetResult()
        scanningInProcess.toggle()
    }

    func resetResult() {
        resultImageView.image = nil
        introLabel.isHidden = !scanningInProcess
        
        typeResultLabel.text = nil
        resultValueLabel.text = nil
        resultFromScanning = nil
        extrasResultLabel.text = nil
    }
    
}
