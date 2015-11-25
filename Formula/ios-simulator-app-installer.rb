class IosSimulatorAppInstaller < Formula
  homepage "https://github.com/stepanhruda/ios-simulator-app-installer"
  url "https://github.com/stepanhruda/ios-simulator-app-installer.git",
    :revision => "532a8ed86388e5080fcadf176ba55a0f9fc2d237"
  version "0.2.0"

  depends_on :xcode => "7"
  depends_on :macos => :yosemite

  def install
    system "make"
    bin.install "ios-simulator-app-installer"
    share.install "app-package-launcher"
  end

  test do
    system "make"
  end
end
