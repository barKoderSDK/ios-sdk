# barKoder Barcode Scanner SDK for iOS

### Add an enterprise-grade barcode scanning engine in your iOS Native app 

Integrating the [barKoder Barcode Scanner SDK](https://barkoder.com) into your Enterprise or Consumer-facing mobile apps will instantly transform your user's smarphones and tablets into rugged barcode scanning devices without the need to procure and maintain expensive and sluggish hardware devices that have a very short life span.

barKoder is a cutting-edge data capture solution built for modern enterprise use cases — delivering AI-powered computer vision, ultra-fast recognition, and industry-leading performance even in the most challenging real-world conditions.

---------------------------------------------
Why barKoder?

barKoder is a production-ready scanning engine trusted across industries such as:
 - Logistics & Supply Chain
 - Manufacturing & Direct Part Marking (DPM)
 - Retail & Self-Checkout
 - Automotive & VIN Capture
 - Identity Verification (MRZ + OCR)

Key capabilities include:

- Proprietary CV-based decoding algorithms
- Batch MultiScan (scan multiple barcodes at once)
- Advanced DPM Data Matrix & QR Code mode
- OCR-based MRZ & VIN scanning support
- Augmented Reality (AR) barcode overlays
- Offline scanning — no cloud dependency
- Cross-platform SDK family (iOS, Android, Web, React Native, Flutter, MAUI, Capacitor, Cordova and Native Script)

--------------------------------------
Supported Barcode Symbologies

barKoder supports 30+ symbologies including:

1D - [Codabar](https://barkoder.com/barcode-types/codabar), [Code 11](https://barkoder.com/barcode-types/code-11), [Code 25](https://barkoder.com/barcode-types/code-25), [Code 32](https://barkoder.com/barcode-types/code-32), [Code 39](https://barkoder.com/barcode-types/code-39), [Code 93](https://barkoder.com/barcode-types/code-93), [Code 128](https://barkoder.com/barcode-types/code-128), [DataBar](https://barkoder.com/barcode-types/databar),  [EAN-8](https://barkoder.com/barcode-types/ean-upc-code), [EAN-13](https://barkoder.com/barcode-types/ean-upc-code), [GS1 Composite](https://barkoder.com/barcode-types/gs1-composite), [Interleaved 2 of 5](https://barkoder.com/barcode-types/code-25), [ITF-14](https://barkoder.com/barcode-types/code-25), [MSI Plessey](https://barkoder.com/barcode-types/msi-plessey), [Postal Barcodes](https://barkoder.com/barcode-types/postal-barcodes), [Telepen](https://barkoder.com/barcode-types/telepen), [UPC-A](https://barkoder.com/barcode-types/ean-upc-code) & [UPC-E](https://barkoder.com/barcode-types/ean-upc-code)

2D - [Aztec Code](https://barkoder.com/barcode-types/aztec), [Aztec Compact](https://barkoder.com/barcode-types/aztec), [Data Matrix](https://barkoder.com/barcode-types/data-matrix), [PDF417](https://barkoder.com/barcode-types/pdf417), [MaxiCode](https://barkoder.com/barcode-types/maxicode), [Micro PDF417](https://barkoder.com/barcode-types/pdf417), [DotCode](https://barkoder.com/barcode-types/dotcode), [QR Code](https://barkoder.com/barcode-types/qr-code) & [Micro QR Code](https://barkoder.com/barcode-types/qr-code)

-----------------------------------------
Demo Apps

Try barKoder in action:

iOS Demo App:
https://apps.apple.com/us/app/barkoder-scanner/id6443715409

Android Demo App:
https://play.google.com/store/apps/details?id=com.barkoder.demoscanner

------------------------------------------
Official iOS Documentation

The iOS SDK is fully documented here:

Installation Guide

https://barkoder.com/docs/v1/ios/ios-sdk-installation

General example

https://barkoder.com/docs/v1/ios/ios-examples/general-example

iOS API Reference

https://barkoder.com/docs/v1/ios/ios-sdk-api-reference

iOS Examples

https://barkoder.com/docs/v1/ios/ios-examples

----------------------------------
## Trial License

If you run the barKoder Barcode Scanner SDK without a valid trial or production license, all results upon successful barcode scans will be partially masked by asterisks (*). You can get a trial license simply by [registering on the barKoder Portal](https://barkoder.com/register) and utilizing the self-service for Evaluation License Generation! Each trial license will be good for an initial duration of 30 days and can be deployed to up to 25 devices. For any custom requirements, contact our sales team via sales@barkoder.com

Note that a trial license is only supposed to be utilized in a development or staging environment. IF you decide to publish a trial license along with your app to the App Store, Play Store or any public store we won't be held accountable for any potential consequences. 

------------------------------

## Free Developer Support

Our support is completely free for integration or testing purposes and granted through the [barKoder Developer Portal](https://barkoder.com/register). After registering and logging into your account, you only need to submit a Support Issue. Alternatively, you can contact us by email via support@barkoder.com

---------------------------------------

# Installation Guide for barKoder's iOS Barcode Scanner SDK

Please follow these simple steps to integrate our SDK into your [iOS](https://developer.apple.com/) project.

## Create a new group 
Name the group “**frameworks**”. The name is optional, you can use whichever label you want
				![picture1.png](https://barkoder.com/uploads/images/original/picture1.png)
## Add **Barkoder.xcframework** and **BarkoderSDK.xcframework** 
Add these items into frameworks  (*\*Copy items if needed, Create groups and Add to desired targets*)
		![picture2.png](https://barkoder.com/uploads/images/original/picture2.png)
## Enable Bitcode (set it to NO)  
In **Build Settings** set the Enable Bitcode to **NO** like shown on the image
		![picture3.png](https://barkoder.com/uploads/images/original/picture3.png)
## Update Info.plist
Open the **Info.plist** with Source Code and add these changes:
```plaintext
<key>NSCameraUsageDescription</key>
<string>BKD Scanner requires using camera</string>
```
***Or using Property List add “Privacy - Camera Usage Description” and key "BKD Scanner requires using camera”***
		![picture4.png](https://barkoder.com/uploads/images/original/picture4.png)
    
## Add **BarkoderView** as a view

Import BarkoderSDK and delcare barkoderView as a view
```swift
import UIKit
import BarkoderSDK
class ViewController: UIViewController {
    private var barkoderView: BarkoderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    private func setupUI() {
        barkoderView = BarkoderView()
        view.addSubview(barkoderView)
    }
    private func setupConstraints() {
        barkoderView.translatesAutoresizingMaskIntoConstraints = false
        barkoderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        barkoderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        barkoderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        barkoderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
```

## Create Barkoder Config
Setup the Barkoder Config per your needs:

In order to perform scanning, config property needs to be properly set
As mentioned, if the license key is not valid you will receive results with asterisks inside.

```swift
private func createBarkoderConfig() {
	barkoderView.config = BarkoderConfig(licenseKey: "LICENSE_KEY") { licenseResult in print("Licensing SDK: \(licenseResult)") }

	// Enable QR barcode type
	guard let decoderConfig = barkoderView.config?.decoderConfig else { return }
	decoderConfig.qr.enabled = true
}
```

## Implement **BarkoderResultDelegate** protocol 

To receive the scanned results we need to implement this protocol:

```swift
extension ViewController: BarkoderResultDelegate {
	func scanningFinished(_ decoderResults: [DecoderResult], thumbnails: [UIImage]?, image: UIImage?) {
    if let textualData = decoderResults[0].textualData {
    	print("Scanned result: ", textualData)
    }
	}  
}

```

## Start the scanning process

And finally start the scanning process:
```plaintext
try? barkoderView.startScanning(self)
```