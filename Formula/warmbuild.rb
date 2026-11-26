# Written by scripts/publish-action.sh for each release (1.13.1 and a7f54c5c2e568f6aa3b6d7e5da1ec60c214f7ce659289d68e330aa565af7c876 filled in).
class Warmbuild < Formula
  desc "Xcode compilation cache: local builds reuse what CI already compiled"
  homepage "https://github.com/warmbuild/action"
  url "https://github.com/warmbuild/action/releases/download/v1.13.1/warmbuild.mjs"
  version "1.13.1"
  sha256 "a7f54c5c2e568f6aa3b6d7e5da1ec60c214f7ce659289d68e330aa565af7c876"
  license "MIT"

  depends_on :macos
  depends_on "node"

  def install
    libexec.install "warmbuild.mjs"
    # The cache keeps its own copy in ~/.warmbuild and updates it daily; `brew upgrade` updates this
    # one. Whichever was installed last runs, so neither downgrades the other.
    (bin/"warmbuild").write <<~SH
      #!/bin/sh
      own="${WARMBUILD_HOME:-$HOME/.warmbuild}/bin/warmbuild.mjs"
      bundle="#{libexec}/warmbuild.mjs"
      if [ -f "$own" ] && [ "$own" -nt "$bundle" ]; then bundle="$own"; fi
      exec "#{Formula["node"].opt_bin}/node" "$bundle" "$@"
    SH
  end

  def caveats
    <<~EOS
      Once, in your checkout of the repository:
        warmbuild login && warmbuild start
      warmbuild status shows the cache's hits and misses.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/warmbuild --version")
  end
end
