import Foundation
import SwiftUI

extension Animation {
    /// Joyful and familiar.
    static let blobby: Animation = .spring(response: 0.55, dampingFraction: 0.2)

    /// Begins quickly and then slow down as it progresses.
    static func softly(_ duration: Double = 0.25) -> Animation { .easeOut(duration: duration) }

    /// Begins slowly and then speed up as it progresses.
    static func quickly(_ duration: Double = 0.25) -> Animation { .easeIn(duration: duration) }

    static let flat: Animation = .linear(duration: 0.5)
}
