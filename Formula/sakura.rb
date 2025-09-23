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

class Sakura < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  license "GPL-2.0"

  stable do
    url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_9.tar.gz"
    sha256 "46b792098a82ba4affc87a174ae96f32e730396e4f5ba9b699e8071253b085a2"

    patch :p1, Formula["z80oolong/vte/sakura@3.8.9"].diff_data
  end

  head do
    url "https://github.com/dabisu/sakura.git"

    patch :p1, Formula["z80oolong/vte/sakura@3.9.99-dev"].diff_data
  end

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "systemd"
  depends_on "z80oolong/vte/gtk+3@3.24.43"
  depends_on "z80oolong/vte/libvte@2.91"

  def install
    ENV.replace_rpath "gtk+3" => "z80oolong/vte/gtk+3@3.24.43"

    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"sakura", "--version"
  end
end
