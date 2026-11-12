# Homebrew tap

```sh
brew install mikitahimpel/tap/warmbuild
```

or in a `Brewfile`:

```ruby
tap "mikitahimpel/tap"
brew "warmbuild"
```

then `brew bundle`. In your checkout of the repository, once: `warmbuild login && warmbuild start`.

Formulae here are written by Warmbuild's release script; changes made here are overwritten.
