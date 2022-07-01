//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `DetailViewController`.
    static let detailViewController = _R.nib._DetailViewController()
    /// Nib `NewsCollectionViewCell`.
    static let newsCollectionViewCell = _R.nib._NewsCollectionViewCell()
    /// Nib `NewsViewController`.
    static let newsViewController = _R.nib._NewsViewController()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DetailViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.detailViewController) instead")
    static func detailViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.detailViewController)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "NewsCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.newsCollectionViewCell) instead")
    static func newsCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.newsCollectionViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "NewsViewController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.newsViewController) instead")
    static func newsViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.newsViewController)
    }
    #endif

    static func detailViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.detailViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func newsCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsCollectionViewCell? {
      return R.nib.newsCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsCollectionViewCell
    }

    static func newsViewController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.newsViewController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `NewsCollectionViewCell`.
    static let newsCollectionViewCell: Rswift.ReuseIdentifier<NewsCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "NewsCollectionViewCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      fileprivate init() {}
    }

    /// This `R.string.localizable` struct is generated, and contains static references to 9 localization keys.
    struct localizable {
      /// en translation: Emailed
      ///
      /// Locales: en, uk
      static let emailed = Rswift.StringResource(key: "emailed", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Favorites
      ///
      /// Locales: en, uk
      static let favorites = Rswift.StringResource(key: "favorites", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Most Emailed
      ///
      /// Locales: en, uk
      static let mostEmailed = Rswift.StringResource(key: "most Emailed", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Most Shared
      ///
      /// Locales: en, uk
      static let mostShared = Rswift.StringResource(key: "most Shared", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Most Viewed
      ///
      /// Locales: en, uk
      static let mostViewed = Rswift.StringResource(key: "most Viewed", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Shared
      ///
      /// Locales: en, uk
      static let shared = Rswift.StringResource(key: "shared", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: Viewed
      ///
      /// Locales: en, uk
      static let viewed = Rswift.StringResource(key: "viewed", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: delete
      ///
      /// Locales: en, uk
      static let delete = Rswift.StringResource(key: "delete", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)
      /// en translation: save
      ///
      /// Locales: en, uk
      static let save = Rswift.StringResource(key: "save", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "uk"], comment: nil)

      /// en translation: Emailed
      ///
      /// Locales: en, uk
      static func emailed(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("emailed", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "emailed"
        }

        return NSLocalizedString("emailed", bundle: bundle, comment: "")
      }

      /// en translation: Favorites
      ///
      /// Locales: en, uk
      static func favorites(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("favorites", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "favorites"
        }

        return NSLocalizedString("favorites", bundle: bundle, comment: "")
      }

      /// en translation: Most Emailed
      ///
      /// Locales: en, uk
      static func mostEmailed(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("most Emailed", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "most Emailed"
        }

        return NSLocalizedString("most Emailed", bundle: bundle, comment: "")
      }

      /// en translation: Most Shared
      ///
      /// Locales: en, uk
      static func mostShared(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("most Shared", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "most Shared"
        }

        return NSLocalizedString("most Shared", bundle: bundle, comment: "")
      }

      /// en translation: Most Viewed
      ///
      /// Locales: en, uk
      static func mostViewed(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("most Viewed", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "most Viewed"
        }

        return NSLocalizedString("most Viewed", bundle: bundle, comment: "")
      }

      /// en translation: Shared
      ///
      /// Locales: en, uk
      static func shared(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("shared", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "shared"
        }

        return NSLocalizedString("shared", bundle: bundle, comment: "")
      }

      /// en translation: Viewed
      ///
      /// Locales: en, uk
      static func viewed(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("viewed", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "viewed"
        }

        return NSLocalizedString("viewed", bundle: bundle, comment: "")
      }

      /// en translation: delete
      ///
      /// Locales: en, uk
      static func delete(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("delete", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "delete"
        }

        return NSLocalizedString("delete", bundle: bundle, comment: "")
      }

      /// en translation: save
      ///
      /// Locales: en, uk
      static func save(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("save", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "save"
        }

        return NSLocalizedString("save", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _DetailViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "DetailViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    struct _NewsCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = NewsCollectionViewCell

      let bundle = R.hostingBundle
      let identifier = "NewsCollectionViewCell"
      let name = "NewsCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsCollectionViewCell
      }

      fileprivate init() {}
    }

    struct _NewsViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "NewsViewController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
