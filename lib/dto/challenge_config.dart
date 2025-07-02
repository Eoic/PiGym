/// Default starting digit for the challenge.
const int _kDefaultStartingDigit = 0;

/// Default number of hints allowed in the challenge.
const int _kDefaultHintsAllowed = 3;

/// Default number of mistakes allowed in the challenge.
const int _kDefaultMistakesAllowed = 3;

class ChallengeConfig {
  /// The number of hints allowed in the challenge.
  final int hintsAllowed;

  /// The starting digit for the challenge.
  final int startingDigit;

  /// The number of mistakes allowed in the challenge.
  final int mistakesAllowed;

  /// The number of digits to guess in the challenge.
  /// If null, the challenge will continue indefinitely.
  final int? digitsToGuess;

  ChallengeConfig({
    this.hintsAllowed = _kDefaultHintsAllowed,
    this.startingDigit = _kDefaultStartingDigit,
    this.mistakesAllowed = _kDefaultMistakesAllowed,
    this.digitsToGuess,
  });

  /// Creates a new [ChallengeConfig] instance with updated values.
  ///
  /// This method allows for a fluent interface to modify the configuration.
  ChallengeConfig copyWith({
    int? hintsAllowed,
    int? startingDigit,
    int? mistakesAllowed,
    int? digitsToGuess,
  }) {
    return ChallengeConfig(
      hintsAllowed: hintsAllowed ?? this.hintsAllowed,
      startingDigit: startingDigit ?? this.startingDigit,
      mistakesAllowed: mistakesAllowed ?? this.mistakesAllowed,
      digitsToGuess: digitsToGuess ?? this.digitsToGuess,
    );
  }
}