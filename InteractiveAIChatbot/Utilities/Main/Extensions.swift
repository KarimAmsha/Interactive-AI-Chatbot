//
//  Extensions.swift
//  M4B
//
//  Created by Karim Amsha on 6/6/22.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Color {
    static
    func primary() -> Color {
        return Color(hex: "1DCD9F")
    }
   
    static
    func primary0091FF() -> Color {
        return Color(hex: "0091FF")
    }

    static
    func secondary() -> Color {
        return Color(hex: "202130")
    }
    
    static
    func green439D7D() -> Color {
        return Color(hex: "439D7D")
    }
    
    static
    func blue106BB9() -> Color {
        return Color(hex: "106BB9")
    }
    
    static
    func blue0D1F75() -> Color {
        return Color(hex: "0D1F75")
    }
    
    static
    func blue009ED2() -> Color {
        return Color(hex: "009ED2")
    }
    
    static
    func yellowFFD93F() -> Color {
        return Color(hex: "FFD93F")
    }

    static
    func black202130() -> Color {
        return Color(hex: "202130")
    }
    
    static
    func black26293B() -> Color {
        return Color(hex: "26293B")
    }
    
    static
    func black050F09() -> Color {
        return Color(hex: "050F09")
    }
    
    static
    func black6A6A6A() -> Color {
        return Color(hex: "6A6A6A")
    }

    static
    func black424343() -> Color {
        return Color(hex: "424343")
    }
    
    static
    func black121212() -> Color {
        return Color(hex: "121212")
    }
    
    static
    func yellowFFC400() -> Color {
        return Color(hex: "FFC400")
    }

    static
    func yellowFFCC00() -> Color {
        return Color(hex: "FFCC00")
    }

    static
    func gray747474() -> Color {
        return Color(hex: "747474")
    }
    
    static
    func grayE8E8E8() -> Color {
        return Color(hex: "E8E8E8")
    }
    
    static
    func gray919191() -> Color {
        return Color(hex: "919191")
    }
    
    static
    func grayE1E1E1() -> Color {
        return Color(hex: "E1E1E1")
    }
    
    static
    func gray888888() -> Color {
        return Color(hex: "888888")
    }
    
    static
    func gray878787() -> Color {
        return Color(hex: "878787")
    }
    
    static
    func grayF3F3F3() -> Color {
        return Color(hex: "F3F3F3")
    }

    static
    func gray9CB2C9() -> Color {
        return Color(hex: "9CB2C9")
    }
    
    static
    func grayF7F7F7() -> Color {
        return Color(hex: "F7F7F7")
    }
    
    static
    func gray9B9997() -> Color {
        return Color(hex: "9B9997")
    }
    
    static
    func gray737373() -> Color {
        return Color(hex: "737373")
    }
    
    static
    func gray555862() -> Color {
        return Color(hex: "555862")
    }
    
    static
    func grayA3A3A3() -> Color {
        return Color(hex: "A3A3A3")
    }

    static
    func gray959595() -> Color {
        return Color(hex: "959595")
    }
    
    static
    func gray808080() -> Color {
        return Color(hex: "808080")
    }

    static
    func grayD4D4D4() -> Color {
        return Color(hex: "D4D4D4")
    }
    
    static
    func grayEFEFEF() -> Color {
        return Color(hex: "EFEFEF")
    }
    
    static
    func grayF7F7FA() -> Color {
        return Color(hex: "F7F7FA")
    }
    
    static
    func grayDBDBDB() -> Color {
        return Color(hex: "DBDBDB")
    }
    
    static
    func gray7A7A7A() -> Color {
        return Color(hex: "7A7A7A")
    }
    
    static
    func gray636363() -> Color {
        return Color(hex: "636363")
    }
    
    static
    func grayE9E9F3() -> Color {
        return Color(hex: "E9E9F3")
    }

    static
    func grayA4A4B3() -> Color {
        return Color(hex: "A4A4B3")
    }

    static
    func gray919297() -> Color {
        return Color(hex: "919297")
    }
    
    static
    func gray222537() -> Color {
        return Color(hex: "222537")
    }
    
    static
    func grayEEEEEE() -> Color {
        return Color(hex: "EEEEEE")
    }
    
    static
    func grayDEDEDE() -> Color {
        return Color(hex: "DEDEDE")
    }
    
    static
    func grayE5E5E5() -> Color {
        return Color(hex: "E5E5E5")
    }
    
    static
    func grayB0B0B0() -> Color {
        return Color(hex: "B0B0B0")
    }
    
    static
    func grayBBBBBB() -> Color {
        return Color(hex: "BBBBBB")
    }
    
    static
    func gray26293B() -> Color {
        return Color(hex: "26293B")
    }
    
    static
    func grayF8F8F8() -> Color {
        return Color(hex: "F8F8F8")
    }
    
    static
    func gray989EAE() -> Color {
        return Color(hex: "989EAE")
    }
    
    static
    func gray6A6A6A() -> Color {
        return Color(hex: "6A6A6A")
    }

    static
    func black2C3D50() -> Color {
        return Color(hex: "2C3D50")
    }
    
    static
    func black3F3D56() -> Color {
        return Color(hex: "3F3D56")
    }
    
    static
    func black1A1C29() -> Color {
        return Color(hex: "1A1C29")
    }
    
    static
    func black200E32() -> Color {
        return Color(hex: "200E32")
    }
    
    static
    func black1F2021() -> Color {
        return Color(hex: "1F2021")
    }
    
    static
    func black3494F56() -> Color {
        return Color(hex: "494F56")
    }

    static
    func black080633() -> Color {
        return Color(hex: "080633")
    }
    
    static
    func black2C2948() -> Color {
        return Color(hex: "2C2948")
    }
    
    static
    func black062513() -> Color {
        return Color(hex: "062513")
    }
    
    static
    func grayF0F0F0() -> Color {
        return Color(hex: "F0F0F0")
    }

    static
    func grayF2F2F5() -> Color {
        return Color(hex: "F2F2F5")
    }

    static
    func grayEDEDED() -> Color {
        return Color(hex: "EDEDED")
    }
    
    static
    func gray898F9C() -> Color {
        return Color(hex: "898F9C")
    }

    static
    func grayBBBACD() -> Color {
        return Color(hex: "BBBACD")
    }
    
    static
    func grayF4F8FF() -> Color {
        return Color(hex: "F4F8FF")
    }
    
    static
    func grayE0E0E9() -> Color {
        return Color(hex: "E0E0E9")
    }

    static
    func gray707070() -> Color {
        return Color(hex: "707070")
    }
    
    static
    func grayC7C7C7() -> Color {
        return Color(hex: "C7C7C7")
    }
    
    static
    func gray979797() -> Color {
        return Color(hex: "979797")
    }
    
    static
    func grayACB0C0() -> Color {
        return Color(hex: "ACB0C0")
    }
    
    static
    func grayB8B7B7() -> Color {
        return Color(hex: "B8B7B7")
    }
    
    static
    func gray9E9E9E() -> Color {
        return Color(hex: "9E9E9E")
    }
    
    static
    func gray514F64() -> Color {
        return Color(hex: "514F64")
    }

    static
    func gray7C93AC() -> Color {
        return Color(hex: "7C93AC")
    }
    
    static
    func grayEBEBEB() -> Color {
        return Color(hex: "EBEBEB")
    }

    static
    func gray04040F() -> Color {
        return Color(hex: "04040F")
    }

    static
    func grayF1F1F1() -> Color {
        return Color(hex: "F1F1F1")
    }
    
    static
    func grayF9F9F9() -> Color {
        return Color(hex: "F9F9F9")
    }
    
    static
    func grayECEFF1() -> Color {
        return Color(hex: "ECEFF1")
    }
    
    static
    func gray8E8E93() -> Color {
        return Color(hex: "8E8E93")
    }
        
    static
    func grayB0BEC5() -> Color {
        return Color(hex: "B0BEC5")
    }
    
    static
    func grayE8F3FF() -> Color {
        return Color(hex: "E8F3FF")
    }
    
    static
    func gray2C3D50() -> Color {
        return Color(hex: "2C3D50")
    }
    
    static
    func gray6D6D6D() -> Color {
        return Color(hex: "6D6D6D")
    }

    static
    func grayD8D8D8() -> Color {
        return Color(hex: "D8D8D8")
    }
    
    static
    func grayDADAED() -> Color {
        return Color(hex: "DADAED")
    }
    
    static
    func grayEEEFF4() -> Color {
        return Color(hex: "EEEFF4")
    }
    
    static
    func gray797877() -> Color {
        return Color(hex: "797877")
    }
    
    static
    func green2ED573() -> Color {
        return Color(hex: "2ED573")
    }
    
    static
    func green00FF22() -> Color {
        return Color(hex: "00FF22")
    }

    static
    func green1DCD9F() -> Color {
        return Color(hex: "1DCD9F")
    }
    
    static
    func redFF5252() -> Color {
        return Color(hex: "FF5252")
    }
    static
    func redFF0000() -> Color {
        return Color(hex: "FF0000")
    }

    static
    func messageBackgroundOtherUser() -> Color {
        return Color(hex: "F0F0F0")
    }

    static
    func startGradient() -> Color {
        return Color(hex: "508CE5")
    }
    
    static
    func endGradient() -> Color {
        return Color(hex: "23D3DB")
    }
    
    static
    func getHomeColor() -> Color {
        return Color(UIColor(red: 0.99, green: 0.96, blue: 0.96, alpha: 1.00))
    }
    
    static
    func getColor1() -> Color {
        return Color(UIColor(red: 0.99, green: 0.46, blue: 0.42, alpha: 1.00))
    }
    
    static
    func getColor2() -> Color {
        return Color(UIColor(red: 0.00, green: 0.64, blue: 0.80, alpha: 1.00))
    }
    
    static
    func getColor3() -> Color {
        return Color(UIColor(red: 0.59, green: 0.74, blue: 0.38, alpha: 1.00))
    }
    
    static
    func GetGradientBGColor() -> LinearGradient {
        let colors = [Color.primary(), Color.primary()]
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .bottom, endPoint: .top)
    }
    
    static
    func GetGradientWhiteColor() -> LinearGradient {
        let colors = [Color.white, Color.white.opacity(0.1)]
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
    }
}

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var toImage: UIImage {
        if self == "" {
            return UIImage()
        }else{
            return UIImage(named: self)!
        }
    }
    
    var toDouble: Double {
        return Double(self) ?? 0.0
    }
}

extension Date {
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970)
    }

    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
   
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextYaers(_ year:Int = 1) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }
    
    func previousYaers(_ year:Int = -1) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }

    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    func removeYears(numberOfYears: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
        return endDate ?? Date()
    }
    
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

extension Int {
    var toString: String {
        return String(self)
    }
}

extension Int64 {
    func getDateStringFromUTC(format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func getDateString(format: String) -> String {
       let date = Date(timeIntervalSince1970: TimeInterval(self))
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = format
       return dateFormatter.string(from: date)
    }
    
    func getShortDateString() -> String {
       let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dataformatter = DateFormatter.init()
        dataformatter.timeStyle = .short
        return dataformatter.string(from: date)
   }
    
    func getDate(format: String = "MMM dd yyyy") -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
    }
    
    func toDate() -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
    }
    
    func getDayOfWeekString() -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: date)
        let weekDay = myComponents.weekday
        switch weekDay {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            print("Error fetching days")
            return "Day"
        }
    }
}

extension URL {
    func getThumbnailFrom() -> UIImage? {
        do {
            let asset = AVURLAsset(url: self , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)

            return thumbnail

        } catch let error {

            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil

        }

    }
}

extension UIImageView {
    func fetchImage(_ imgURL : String) {
        if let imgURL = URL.init(string: imgURL) {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_setImage(with: imgURL, placeholderImage: "ic_logo".toImage)
        } else {
            self.image = "ic_logo".toImage
        }
    }
}

extension UIImage {
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension String {
    
    func stringBefore(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(prefix(upTo: index))
        } else {
            return ""
        }
    }
    
    func stringAfter(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(suffix(from: index).dropFirst())
        } else {
            return ""
        }
    }
}

extension Font {
    struct Event {
        let name = Font.custom(FontWeight.medium.rawValue, size: s14)
        let message = Font.custom(FontWeight.regular.rawValue, size: s15)
        let date = Font.custom(FontWeight.regular.rawValue, size: s11)
        let nSTitle = Font.custom(FontWeight.medium.rawValue, size: s17)
        let fieldTitle = Font.custom(FontWeight.regular.rawValue, size: s13)
        let fieldText = Font.custom(FontWeight.regular.rawValue, size: s15)
    }
    static let event = Event()
}

extension UIInterfaceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeRight: return .landscapeRight
        case .landscapeLeft: return .landscapeLeft
        case .portrait: return .portrait
        default: return nil
        }
    }
}

extension Image {
    static var wifiExclamationmark: Image {
        #if os(macOS)
        return Image("wifi.exclamationmark")
        .resizable()
        #else
        return Image(systemName: "wifi.exclamationmark")
        .resizable()
        #endif
    }
}

// Placeholder when image load failed (with `.delayPlaceholder`)
#if !os(watchOS)
extension PlatformImage {
    static var wifiExclamationmark: PlatformImage {
        #if os(macOS)
        return PlatformImage(named: "wifi.exclamationmark")!
        #else
        return PlatformImage(systemName: "wifi.exclamationmark")!.withTintColor(.label, renderingMode: .alwaysOriginal)
        #endif
    }
}
#endif

public extension View {
    func fullBackground(imageName: String) -> some View {
       return background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
       )
    }
}

extension String {

    /// Handles 10 or 11 digit phone numbers
    ///
    /// - Returns: formatted phone number or original value
    public func toPhoneNumber() -> String {
        let digits = self.digitsOnly
        if digits.count == 10 {
            return digits.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1)-$2-$3", options: .regularExpression, range: nil)
        }
        else if digits.count == 11 {
            return digits.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d+)", with: "$1($2)-$3-$4", options: .regularExpression, range: nil)
        }
        else {
            return self
        }
    }
}

extension StringProtocol {

    /// Returns the string with only [0-9], all other characters are filtered out
    var digitsOnly: String {
        return String(filter(("0"..."9").contains))
    }
}

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

  func getMiles() -> Double{
   return self * 0.000621371192
  }
    
  func getMeters() -> Double {
   return self * 1609.344
  }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toString() -> String {
        return String(self)
    }
}

extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
    
    func getDayOfWeekString() -> String? {
        let todayDate = self
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        switch weekDay {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            print("Error fetching days")
            return "Day"
        }
    }
}

extension String {
    func getDayOfWeekString()->String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = DATE_FORMATTER
        if let todayDate = formatter.date(from: self) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let myComponents = myCalendar.components(.weekday, from: todayDate)
            let weekDay = myComponents.weekday
            switch weekDay {
            case 1:
                return "Sun"
            case 2:
                return "Mon"
            case 3:
                return "Tue"
            case 4:
                return "Wed"
            case 5:
                return "Thu"
            case 6:
                return "Fri"
            case 7:
                return "Sat"
            default:
                print("Error fetching days")
                return "Day"
            }
        } else {
            return nil
        }
    }
}

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

//
//extension View {
//    func snapshot() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//        let view = controller.view
//        let targetSize = controller.view.intrinsicContentSize
//        view?.bounds = CGRect(origin: .zero, size: targetSize)
//        view?.backgroundColor = .clear
//        let renderer = UIGraphicsImageRenderer(size: targetSize)
//        return renderer.image { _ in
//            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
//        }
//    }
//}
//
//extension View {
//    func asImage() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//
//        // locate far out of screen
//        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
//
//        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
//        controller.view.bounds = CGRect(origin: .zero, size: size)
//        controller.view.sizeToFit()
//        UIApplication.shared.windows.first?.rootViewController?.view.addSubview(controller.view)
//
//        let image = controller.view.asImage()
//        controller.view.removeFromSuperview()
//        return image
//    }
//}
//
//extension UIView {
//    func asImage() -> UIImage {
//        let renderer = UIGraphicsImageRenderer(bounds: bounds)
//        return renderer.image { rendererContext in
//            layer.render(in: rendererContext.cgContext)
//        }
//    }
//}
//
//extension View {
//    func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
//        let window = UIWindow(frame: CGRect(origin: origin, size: size))
//        let hosting = UIHostingController(rootView: self)
//        hosting.view.frame = window.frame
//        window.addSubview(hosting.view)
//        window.makeKeyAndVisible()
//        return hosting.view.screenShot
//  }
//}

extension UIView {
   var screenShot: UIImage {
       let rect = self.bounds
       UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
       let context: CGContext = UIGraphicsGetCurrentContext()!
       self.layer.render(in: context)
       let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
       UIGraphicsEndImageContext()
       return capturedImage
   }
}

//extension View {
//    func asImage() -> UIImage {
//        let controller = UIHostingController(rootView: self)
//
//        // locate far out of screen
//        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
//        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
//
//        let size = controller.view.intrinsicContentSize //controller.sizeThatFits(in: UIScreen.main.bounds.size)
//        controller.view.bounds = CGRect(origin: .zero, size: size)
//        controller.view.backgroundColor = UIColor.systemBackground
//        controller.view.sizeToFit()
//
//        //let image = controller.view.asImage()
//        let image = UIImage(view: controller.view)
//        controller.view.removeFromSuperview()
//        return image
//    }
//}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions((view.frame.size), false, 0.0)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}

extension View {
  func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
    let window = UIWindow(frame: CGRect(origin: origin, size: size))
    let hosting = UIHostingController(rootView: self)
     
    hosting.view.sizeToFit()
     
      window.frame.size.height = hosting.view.frame.size.height > 0 ? hosting.view.frame.size.height : window.frame.size.height
      window.frame.size.width = hosting.view.frame.size.height > 0 ? hosting.view.frame.size.height : window.frame.size.width
     
    window.rootViewController = hosting
    window.makeKeyAndVisible()
      return window.asImage()//.snapshotImage()!
  }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    static let screenOrigin = UIScreen.main.bounds.origin
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension UIView {
    func asImage() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: self.layer.frame.size, format: format).image { context in
                self.drawHierarchy(in: self.layer.bounds, afterScreenUpdates: true)
        }
    }
}

extension View {
    func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.asImage()
        return image
    }
}

extension Date
{
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension StringProtocol where Index == String.Index {
    var words: [String] {
        var result: [String] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { (substring, _, _, _) in
            result.append(substring!)
        }
        return result
    }
    func matchingWords(in string: String) -> [String] {
        return string.words.filter(words.contains)
    }
}

extension NSMutableAttributedString {
  func setCharacterColor(at location: Int) {
    let range = NSRange(location: location, length: 1)
      self.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
  }
}


extension Array where Element == Character {
  func index(of character: Character, greaterThan index: Int) -> Int? {
    for i in index...self.count where self[i] == character {
      return i
    }
    return nil
  }
}

extension NSAttributedString {
    convenience init(base: String,
                     keyWords: [String],
                     foregroundColor: UIColor,
                     font: UIFont,
                     highlightForeground: UIColor,
                     highlighBackground: UIColor) {
        let baseAttributed = NSMutableAttributedString(string: base, attributes: [NSAttributedString.Key.font: font,
                                                                                  NSAttributedString.Key.foregroundColor: foregroundColor])
        let range = NSRange(location: 0, length: base.utf16.count)
        for word in keyWords {
            guard let regex = try? NSRegularExpression(pattern: word, options: .caseInsensitive) else {
                continue
            }

            regex
                .matches(in: base, options: .withTransparentBounds, range: range)
                .forEach { baseAttributed
                    .addAttributes([NSAttributedString.Key.backgroundColor: highlighBackground,
                                    NSAttributedString.Key.foregroundColor: highlightForeground],
                                   range: $0.range) }
        }
        self.init(attributedString: baseAttributed)
    }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}

extension URL {
    func generateThumbnail() -> UIImage? {
        do {
            let asset = AVURLAsset(url: self)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            // Swift 5.3
            let cgImage = try imageGenerator.copyCGImage(at: .zero,
                                                         actualTime: nil)

            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)

            return nil
        }
    }
}

extension Sequence {
    /// Returns an array containing, in order, the first instances of
    /// elements of the sequence that compare equally for the keyPath.
    func unique<T: Hashable>(for keyPath: KeyPath<Element, T>) -> [Element] {
        var unique = Set<T>()
        return filter { unique.insert($0[keyPath: keyPath]).inserted }
    }
}

extension Sequence where Iterator.Element: Hashable {
  func unique() -> [Iterator.Element] {
    return Array(Set<Iterator.Element>(self))
  }

  func uniqueOrdered() -> [Iterator.Element] {
    return reduce([Iterator.Element]()) { $0.contains($1) ? $0 : $0 + [$1] }
  }
}

extension NSMutableData {
    func appendString(_ string: String) {
        guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            return
        }
        append(data)
    }
}
