//import SwiftUI
//import CountryPicker
//
//struct CountryPickerRepresentable: UIViewControllerRepresentable {
//    @Binding var selectedCountry: Country
//    var config: CountryPickerConfig
//
//    func makeUIViewController(context: Context) -> CountryPickerViewController {
//        let countryPicker = CountryPickerViewController()
//        countryPicker.selectedCountry = selectedCountry.isoCode
//        countryPicker.delegate = context.coordinator
//
//        // Применяем конфигурацию
//        CountryManager.shared.config.countryNameTextColor = config.countryNameTextColor
//        CountryManager.shared.config.countryNameTextFont = config.countryNameTextFont
//        CountryManager.shared.config.selectedCountryCodeBackgroundColor = config.selectedCountryCodeBackgroundColor
//        CountryManager.shared.config.selectedCountryCodeTextColor = config.selectedCountryCodeTextColor
//        CountryManager.shared.config.selectedCountryCodeCornerRadius = config.selectedCountryCodeCornerRadius
//        CountryManager.shared.config.countryCodeFont = config.countryCodeFont
//        CountryManager.shared.config.countryCodeTextColor = config.countryCodeTextColor
//        CountryManager.shared.config.countryImageHeight = config.countryImageHeight
//        CountryManager.shared.config.countryImageSpacing = config.countryImageSpacing
//        // Убираем deprecated параметры
//        // CountryManager.shared.config.closeButtonTextColor = config.closeButtonTextColor
//        // CountryManager.shared.config.closeButtonFont = config.closeButtonFont
//        // CountryManager.shared.config.closeButtonText = config.closeButtonText
//        CountryManager.shared.config.closeButtonStyle = config.closeButtonStyle
//        CountryManager.shared.config.titleTextColor = config.titleTextColor
//        CountryManager.shared.config.titleFont = config.titleFont
//        CountryManager.shared.config.titleText = config.titleText
//        CountryManager.shared.config.searchBarPlaceholder = config.searchBarPlaceholder
//        CountryManager.shared.config.searchBarBackgroundColor = config.searchBarBackgroundColor
//        CountryManager.shared.config.searchBarPlaceholderColor = config.searchBarPlaceholderColor
//        CountryManager.shared.config.searchBarFont = config.searchBarFont
//        CountryManager.shared.config.searchBarHeight = config.searchBarHeight
//        CountryManager.shared.config.searchBarInsets = config.searchBarInsets
//        CountryManager.shared.config.searchBarLeftImage = config.searchBarLeftImage
//        CountryManager.shared.config.searchIconHeight = config.searchIconHeight
//        CountryManager.shared.config.searchBarClearImage = config.searchBarClearImage
//        CountryManager.shared.config.searchBarCornerRadius = config.searchBarCornerRadius
//        CountryManager.shared.config.searchBarBorderColor = config.searchBarBorderColor
//        CountryManager.shared.config.searchBarBorderWidth = config.searchBarBorderWidth
//        // Убираем deprecated параметр
//        // CountryManager.shared.config.separatorColor = config.separatorColor
//        CountryManager.shared.config.showPhoneCodes = config.showPhoneCodes
//        CountryManager.shared.config.seperatorInsets = config.separatorInsets
//        CountryManager.shared.config.countriesSortingComparisonResult = config.countriesSortingComparisonResult
//
//        return countryPicker
//    }
//
//    func updateUIViewController(_ uiViewController: CountryPickerViewController, context: Context) {
//        // Здесь можно обновлять uiViewController, если нужно
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, CountryPickerDelegate {
//        var parent: CountryPickerRepresentable
//
//        init(_ parent: CountryPickerRepresentable) {
//            self.parent = parent
//        }
//
//        func countryPicker(didSelect country: Country) {
//            parent.selectedCountry = country
//        }
//    }
//}
//
//extension String {
//    func getFlag() -> String {
//        let base: UInt32 = 127397
//        var s = ""
//        for v in self.uppercased().unicodeScalars {
//            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
//        }
//        return String(s)
//    }
//}
