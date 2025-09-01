class << ENV
  def replace_rpath(**replace_list)
    replace_list = replace_list.each_with_object({}) do |(old, new), result|
      result[Formula[old].opt_lib.to_s] = Formula[new].opt_lib.to_s
      result[Formula[old].lib.to_s] = Formula[new].lib.to_s
    end
    rpaths = self["HOMEBREW_RPATH_PATHS"].split(":")
    rpaths = rpaths.each_with_object([]) {|rpath, result| result << (replace_list.key?(rpath) ? replace_list[rpath] : rpath) }
    self["HOMEBREW_RPATH_PATHS"] = rpaths.join(":")
  end
end

class SakuraAT389 < Formula
  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"
  url "https://github.com/dabisu/sakura/archive/refs/tags/SAKURA_3_8_9.tar.gz"
  sha256 "46b792098a82ba4affc87a174ae96f32e730396e4f5ba9b699e8071253b085a2"
  license "GPL-2.0"

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "systemd"
  depends_on "z80oolong/vte/gtk+3@3.24.43" => :optional
  unless build.with? "z80oolong/vte/gtk+3@3.24.43"
    depends_on "gtk+3"
  end
  depends_on "z80oolong/vte/libvte@2.91"

  patch :p1, :DATA

  def install
    if build.with? "z80oolong/vte/gtk+3@3.24.43"
      ENV.replace_rpath "gtk+3" => "z80oolong/vte/gtk+3@3.24.43"
    end

    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def diff_data
    lines = path.each_line.with_object([]) do |line, result|
      result.push(line) if /^__END__/.match?(line) || result.first
    end
    lines.shift
    lines.join
  end

  test do
    system bin/"sakura", "--version"
  end
end

__END__
diff --git a/src/sakura.c b/src/sakura.c
index f137879..2c4d1a5 100644
--- a/src/sakura.c
+++ b/src/sakura.c
@@ -3040,6 +3040,9 @@ sakura_add_tab()
 	GtkWidget *event_box;
 	gint index, page, npages;
 	gchar *cwd = NULL; gchar *default_label_text = NULL;
+#ifndef NO_UTF8_CJK
+	gchar *vte_cjk_width = NULL;
+#endif
 
 	sk_tab = g_new0(struct sakura_tab, 1);
 
@@ -3317,6 +3320,14 @@ sakura_add_tab()
 	vte_terminal_set_audible_bell (VTE_TERMINAL(sk_tab->vte), sakura.audible_bell ? TRUE : FALSE);
 	vte_terminal_set_cursor_blink_mode (VTE_TERMINAL(sk_tab->vte), sakura.blinking_cursor ? VTE_CURSOR_BLINK_ON : VTE_CURSOR_BLINK_OFF);
 	vte_terminal_set_cursor_shape (VTE_TERMINAL(sk_tab->vte), sakura.cursor_type);
+#ifndef NO_UTF8_CJK
+	vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+	if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+		if (vte_terminal_get_cjk_ambiguous_width(VTE_TERMINAL(sk_tab->vte)) != 2) {
+			vte_terminal_set_cjk_ambiguous_width(VTE_TERMINAL(sk_tab->vte), 2);
+		}
+	}
+#endif
 
 }
 
