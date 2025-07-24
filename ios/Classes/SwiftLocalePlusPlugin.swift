import Flutter
import UIKit

public class SwiftLocalePlusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "locale_plus", binaryMessenger: registrar.messenger())
    let instance = SwiftLocalePlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case MethodNames.getDecimalSeparator.rawValue:
          result(Locale.autoupdatingCurrent.decimalSeparator)
      case MethodNames.getGroupingSeparator.rawValue:
          result(Locale.autoupdatingCurrent.groupingSeparator)
      case MethodNames.getSecondsFromGMT.rawValue:
          result(TimeZone.autoupdatingCurrent.secondsFromGMT())
      case MethodNames.getRegionCode.rawValue:
          result(Locale.autoupdatingCurrent.regionCode)
      case MethodNames.getLanguageCode.rawValue:
          result(getPrefferedLanguageLocale().languageCode)
      case MethodNames.usesMetricSystem.rawValue:
          result(usesMetricSystem())
      case MethodNames.is24HourTime.rawValue:
          result(is24HourTime())
      case MethodNames.getAmSymbol.rawValue:
          result(getPrefferedLanguageLocale().calendar.amSymbol)
      case MethodNames.getPmSymbol.rawValue:
          result(getPrefferedLanguageLocale().calendar.pmSymbol)
      case MethodNames.getTimeZoneIdentifier.rawValue:
          result(TimeZone.autoupdatingCurrent.identifier)
      case MethodNames.getFirstDayOfWeek.rawValue:
          result(getFirstDayOfWeek())
      case MethodNames.getDateFormatPattern.rawValue:
          result(getDateFormatPattern())
      default:
          return
      }
  }
    
    private func is24HourTime() -> Bool {
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:Locale.autoupdatingCurrent)!
            if formatter.contains("a") {
                return false
            } else {
                return true
            }
    }
    
    private func usesMetricSystem() -> Bool {
        if #available(iOS 16, *) {
            return Locale.autoupdatingCurrent.measurementSystem == Locale.MeasurementSystem.metric
        } else {
            return Locale.autoupdatingCurrent.usesMetricSystem
        }
    }

    private func getFirstDayOfWeek() -> Int {
        let firstDay = Calendar.current.firstWeekday;
        if (firstDay == 1) {
            return 7;
        } else {
            return firstDay - 1;
        }
    }
    
    private func getPrefferedLanguageLocale() -> Locale {
        guard let prefferedLanguage = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: prefferedLanguage)
    }

    private func getDateFormatPattern() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(calendar: calendar, year: 2025, month: 7, day: 4)
        guard let testDate = components.date else {
            return "MM/dd/yyyy" // fallback
        }

        let formatted = formatter.string(from: testDate)
        // e.g., "7/4/25" or "04.07.2025" or "2025-07-04"

        var pattern = formatted

        // Replace known values with tokens
        pattern = pattern.replacingOccurrences(of: "2025", with: "yyyy")
        pattern = pattern.replacingOccurrences(of: "25", with: "yy") // fallback if short year is used
        pattern = pattern.replacingOccurrences(of: "07", with: "MM")
        pattern = pattern.replacingOccurrences(of: "7", with: "M")
        pattern = pattern.replacingOccurrences(of: "04", with: "dd")
        pattern = pattern.replacingOccurrences(of: "4", with: "d")

        return pattern
    }
}
