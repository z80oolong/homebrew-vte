def ENV.replace_rpath(**replace_list)
  replace_list = replace_list.each_with_object({}) do |(old, new), result|
    old_f = Formula[old]
    new_f = Formula[new]
    result[old_f.opt_lib.to_s] = new_f.opt_lib.to_s
    result[old_f.lib.to_s] = new_f.lib.to_s
  end

  if (rpaths = fetch("HOMEBREW_RPATH_PATHS", false))
    self["HOMEBREW_RPATH_PATHS"] = (rpaths.split(":").map do |rpath|
      replace_list.fetch(rpath, rpath)
    end).join(":")
  end
end

class Roxterm < Formula
  desc "Highly configurable terminal emulator based on VTE"
  homepage "https://roxterm.sourceforge.io/"
  license ["GPL-2.0", "LGPL-3.0"]

  stable do
    url "https://github.com/realh/roxterm/archive/refs/tags/3.17.2.tar.gz"
    sha256 "3da0ac499773002ccf0df9fd57918b3856cd5c5257f874715725ff3ef1266657"

    patch :p1, Formula["z80oolong/vte/roxterm@3.17.2"].diff_data
  end

  head do
    url "https://github.com/realh/roxterm.git"

    patch :p1, Formula["z80oolong/vte/roxterm@3.18.99-dev"].diff_data
  end

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "pkg-config" => :build
  depends_on "dbus-glib"
  depends_on "glib"
  depends_on "z80oolong/vte/gtk+3@3.24.43"
  depends_on "z80oolong/vte/libvte@2.91"

  resource("roxterm-ja-po") do
    url "https://gist.github.com/731fd4e4d0adb4178ce69885bf061523.git",
        branch:   "main",
        revision: "72cd4d52211814ac3a8cecd2fc197447c3914c47"
  end

  def install
    ENV.replace_rpath "gtk+3" => "z80oolong/vte/gtk+3@3.24.43"
    ENV.append "CFLAGS", "-D_GNU_SOURCE"
    ENV.append "CFLAGS", "-DENABLE_NLS=1"

    inreplace "./src/config.h.in" do |s|
      s.gsub!(/^#cmakedefine ENABLE_NLS/, "#define ENABLE_NLS 1")
    end

    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    resource("roxterm-ja-po").stage do
      (share/"locale/ja/LC_MESSAGES").mkpath
      (share/"locale/en_US/LC_MESSAGES").mkpath

      system Formula["gettext"].opt_bin/"msgfmt", "-o", share/"locale/ja/LC_MESSAGES/roxterm.mo", "./ja.po"
      system Formula["gettext"].opt_bin/"msgfmt", "-o", share/"locale/en_US/LC_MESSAGES/roxterm.mo", "./en_US.po"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roxterm --version")
  end
end
