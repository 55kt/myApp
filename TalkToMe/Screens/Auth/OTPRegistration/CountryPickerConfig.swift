import UIKit
import CountryPicker

public struct CountryPickerConfig {
    public var countryNameTextColor: UIColor
    public var countryNameTextFont: UIFont
    public var selectedCountryCodeBackgroundColor: UIColor
    public var selectedCountryCodeTextColor: UIColor
    public var selectedCountryCodeCornerRadius: CGFloat
    public var countryCodeFont: UIFont
    public var countryCodeTextColor: UIColor
    public var countryImageHeight: CGFloat
    public var countryImageSpacing: CGFloat
    @available(*, deprecated, message: "Use `closeButtonStyle` instead")
    public var closeButtonTextColor: UIColor
    @available(*, deprecated, message: "Use `closeButtonStyle` instead")
    public var closeButtonFont: UIFont
    @available(*, deprecated, message: "Use `closeButtonStyle` instead")
    public var closeButtonText: String
    public var closeButtonStyle: DismissButtonStyle
    public var titleTextColor: UIColor
    public var titleFont: UIFont
    public var titleText: String
    public var searchBarPlaceholder: String
    public var searchBarBackgroundColor: UIColor
    public var searchBarPlaceholderColor: UIColor
    public var searchBarFont: UIFont
    public var searchBarHeight: CGFloat
    public var searchBarInsets: UIEdgeInsets
    public var searchBarLeftImage: UIImage?
    public var searchIconHeight: CGFloat
    public var searchBarClearImage: UIImage?
    public var searchBarCornerRadius: CGFloat
    public var searchBarBorderColor: UIColor
    public var searchBarBorderWidth: CGFloat
    @available(*, deprecated, message: "Use `separatorAppearance` instead")
    public var separatorColor: UIColor
    public var showPhoneCodes: Bool
    public var separatorInsets: UIEdgeInsets
    public var countriesSortingComparisonResult: ComparisonResult

    public init(
        countryNameTextColor: UIColor = .black,
        countryNameTextFont: UIFont = UIFont.systemFont(ofSize: 16),
        selectedCountryCodeBackgroundColor: UIColor = .gray,
        selectedCountryCodeTextColor: UIColor = .white,
        selectedCountryCodeCornerRadius: CGFloat = 5.0,
        countryCodeFont: UIFont = UIFont.systemFont(ofSize: 16),
        countryCodeTextColor: UIColor = .black,
        countryImageHeight: CGFloat = 32.0,
        countryImageSpacing: CGFloat = 8.0,
        closeButtonTextColor: UIColor = .systemGreen,
        closeButtonFont: UIFont = UIFont.systemFont(ofSize: 16),
        closeButtonText: String = "Close",
        closeButtonStyle: DismissButtonStyle = .title(title: "Close", textColor: .systemGray,  font: .systemFont(ofSize: 1)),
        titleTextColor: UIColor = .black,
        titleFont: UIFont = UIFont.systemFont(ofSize: 16),
        titleText: String = "Country Picker",
        searchBarPlaceholder: String = "Search",
        searchBarBackgroundColor: UIColor = .white,
        searchBarPlaceholderColor: UIColor = .gray,
        searchBarFont: UIFont = UIFont.systemFont(ofSize: 16),
        searchBarHeight: CGFloat = 44.0,
        searchBarInsets: UIEdgeInsets = .zero,
        searchBarLeftImage: UIImage? = nil,
        searchIconHeight: CGFloat = 24.0,
        searchBarClearImage: UIImage? = nil,
        searchBarCornerRadius: CGFloat = 8.0,
        searchBarBorderColor: UIColor = .clear,
        searchBarBorderWidth: CGFloat = 0.0,
        separatorColor: UIColor = .clear,
        showPhoneCodes: Bool = true,
        separatorInsets: UIEdgeInsets = .zero,
        countriesSortingComparisonResult: ComparisonResult = .orderedSame
    ) {
        self.countryNameTextColor = countryNameTextColor
        self.countryNameTextFont = countryNameTextFont
        self.selectedCountryCodeBackgroundColor = selectedCountryCodeBackgroundColor
        self.selectedCountryCodeTextColor = selectedCountryCodeTextColor
        self.selectedCountryCodeCornerRadius = selectedCountryCodeCornerRadius
        self.countryCodeFont = countryCodeFont
        self.countryCodeTextColor = countryCodeTextColor
        self.countryImageHeight = countryImageHeight
        self.countryImageSpacing = countryImageSpacing
        self.closeButtonTextColor = closeButtonTextColor
        self.closeButtonFont = closeButtonFont
        self.closeButtonText = closeButtonText
        self.closeButtonStyle = closeButtonStyle
        self.titleTextColor = titleTextColor
        self.titleFont = titleFont
        self.titleText = titleText
        self.searchBarPlaceholder = searchBarPlaceholder
        self.searchBarBackgroundColor = searchBarBackgroundColor
        self.searchBarPlaceholderColor = searchBarPlaceholderColor
        self.searchBarFont = searchBarFont
        self.searchBarHeight = searchBarHeight
        self.searchBarInsets = searchBarInsets
        self.searchBarLeftImage = searchBarLeftImage
        self.searchIconHeight = searchIconHeight
        self.searchBarClearImage = searchBarClearImage
        self.searchBarCornerRadius = searchBarCornerRadius
        self.searchBarBorderColor = searchBarBorderColor
        self.searchBarBorderWidth = searchBarBorderWidth
        self.separatorColor = separatorColor
        self.showPhoneCodes = showPhoneCodes
        self.separatorInsets = separatorInsets
        self.countriesSortingComparisonResult = countriesSortingComparisonResult
    }
}
