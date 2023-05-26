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
}
