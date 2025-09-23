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

class Tilda < Formula
  desc "Gtk-based drop down terminal for Linux and Unix"
  homepage "https://github.com/lanoxx/tilda"
  license "GPL-2.0"

  stable do
    url "https://github.com/lanoxx/tilda/archive/refs/tags/tilda-2.0.0.tar.gz"
    sha256 "ff9364244c58507cd4073ac22e580a4cded048d416c682496c1b1788ee8a30df"

    patch :p1, Formula["z80oolong/vte/tilda@2.0.0"].diff_data
  end

  head do
    url "https://github.com/lanoxx/tilda.git"

    patch :p1, Formula["z80oolong/vte/tilda@2.9.99-dev"].diff_data
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "perl" => :build
  depends_on "z80oolong/dep/libconfuse@3.3" => :build
  depends_on "gettext"
  depends_on "z80oolong/vte/gtk+3@3.24.43"
  depends_on "z80oolong/vte/libvte@2.91"

  def install
    ENV.replace_rpath "gtk+3" => "z80oolong/vte/gtk+3@3.24.43"
    ENV["LC_ALL"] = "C"
    system "./autogen.sh"

    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"tilda", "--version"
  end
end
