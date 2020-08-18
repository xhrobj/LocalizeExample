//
//  ViewController.swift
//  LocalizeExample
//
//

import UIKit

class ViewController: UIViewController {

    private enum Segment: String {
        case English
        case Russian
        case French
        
        var locale: Locale {
            switch self {
            case .English:
                return Locale(identifier: "en_US")
            case .Russian:
                return Locale(identifier: "ru_RU")
            case .French:
                return Locale(identifier: "fr_FR")
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private let segments: [Segment] = [.English, .Russian, .French]
    
    private var currentLocale: Locale? {
        let segment = segments[safe: segmentControl.selectedSegmentIndex]
        return segment?.locale
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    private lazy var measureFormatter = MeasurementFormatter()
    
    private let MOSCOW_SOCHI_DISTANCE: Double = 1361
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        adjustSegmentControl()
        setupLabelText()
    }

    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        setupLabelText()
    }
}

private extension ViewController {
    func adjustSegmentControl() {
        (0..<segmentControl.numberOfSegments).forEach {
            let segment = segments[safe: $0]
            segmentControl.setTitle(segment?.rawValue, forSegmentAt: $0)
        }
    }
    
    func setupLabelText() {
        dateFormatter.locale = currentLocale
        measureFormatter.locale = currentLocale
        
        let prefixText = "\("GREETING_TEXT".localized(currentLocale))! \("TODAY_TEXT".localized(currentLocale))"
        let distanceText = "DISTANCE_TEXT".localized(currentLocale)
        
        let dateLocalizedValue = dateFormatter.string(from: Date())
        let distance = Measurement<UnitLength>(value: MOSCOW_SOCHI_DISTANCE, unit: .kilometers)
        let distanceLocalizedValue = measureFormatter.string(from: distance)
        
        label.text = "\(prefixText) \(dateLocalizedValue). \(distanceText) \(distanceLocalizedValue)."
    }
}
