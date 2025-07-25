//
//  Spacing.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import SwiftUI

enum Spacing: CGFloat {
    case extraSmall = 4
    case small = 8
    case regular = 16
    case medium = 24
    case large = 32
    
    static let `default` = Spacing.regular.rawValue
}

extension View {
    func paddingHorizontal(_ spacing: Spacing) -> some View {
        self.padding(.horizontal, spacing.value)
    }
    
    func paddingVertical(_ spacing: Spacing) -> some View {
        self.padding(.vertical, spacing.value)
    }
}

extension Spacing: ExpressibleByFloatLiteral {
    init(floatLiteral value: Double) {
        switch value {
        case Spacing.extraSmall.rawValue: self = .extraSmall
        case Spacing.small.rawValue: self = .small
        case Spacing.regular.rawValue: self = .regular
        case Spacing.medium.rawValue: self = .medium
        case Spacing.large.rawValue: self = .large
        default: self = .regular
        }
    }
}

// MARK: - Add implicit conversion to CGFloat
extension Spacing {
    var value: CGFloat {
        return self.rawValue
    }
}

// MARK: - Make Spacing implicitly convertible to CGFloat
extension VStack {
    init(alignment: HorizontalAlignment = .center, spacing: Spacing, @ViewBuilder content: @escaping () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension HStack {
    init(alignment: VerticalAlignment = .center, spacing: Spacing, @ViewBuilder content: @escaping () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension LazyVStack {
    init(alignment: HorizontalAlignment = .center, spacing: Spacing, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: @escaping () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, pinnedViews: pinnedViews, content: content)
    }
}

extension LazyHStack {
    init(alignment: VerticalAlignment = .center, spacing: Spacing, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: @escaping () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, pinnedViews: pinnedViews, content: content)
    }
}

// MARK: - SwiftUI Extensions for Padding
extension View {
    func padding(_ spacing: Spacing) -> some View {
        self.padding(EdgeInsets(
            top: spacing.rawValue,
            leading: spacing.rawValue,
            bottom: spacing.rawValue,
            trailing: spacing.rawValue
        ))
    }
    
    func padding(_ edge: Edge, _ spacing: Spacing) -> some View {
        switch edge {
        case .top:
            return self.padding(.top, spacing.rawValue)
        case .leading:
            return self.padding(.leading, spacing.rawValue)
        case .bottom:
            return self.padding(.bottom, spacing.rawValue)
        case .trailing:
            return self.padding(.trailing, spacing.rawValue)
        }
    }
    
    func padding(_ edges: Edge.Set, _ spacing: Spacing) -> some View {
        var edgeInsets = EdgeInsets()
        
        if edges.contains(.top) {
            edgeInsets.top = spacing.rawValue
        }
        if edges.contains(.leading) {
            edgeInsets.leading = spacing.rawValue
        }
        if edges.contains(.bottom) {
            edgeInsets.bottom = spacing.rawValue
        }
        if edges.contains(.trailing) {
            edgeInsets.trailing = spacing.rawValue
        }
        
        return self.padding(edgeInsets)
    }
}
