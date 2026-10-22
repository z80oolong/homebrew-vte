require "#{Tap.fetch("z80oolong/vte").path}/lib/extend.rb"

class SakuraAT9999Dev < Formula
  include DiffDataMixin

  desc "GTK/VTE based terminal emulator"
  homepage "https://launchpad.net/sakura"

  CURRENT_COMMIT = "2db313dc2155f03155d84e09e4dda43e049eb9e9".freeze
  url "https://github.com/dabisu/sakura.git",
    branch:   "master",
    revision: CURRENT_COMMIT
  version "git-#{CURRENT_COMMIT[0..7]}"
  license "GPL-2.0-or-later"
  revision 1

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "pod2man" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "systemd"
  depends_on "vte3"

  patch :p1, :DATA

  def install
    args  = std_cmake_args
    args << "CMAKE_BUILD_TYPE=Debug"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      #{full_name} is a Formula for installing the development version of
      `sakura` based on the HEAD version (commit #{CURRENT_COMMIT[0..7]}) from its git repository.
    EOS
  end

  test do
    ENV["LC_ALL"] = "C"
    output = shell_output("#{bin}/sakura --version 2>&1 || true").strip
    assert_equal "sakura version is 3.8.9", output
  end
end

__END__
diff --git a/src/sakura.c b/src/sakura.c
index 83c513f..0e484ea 100644
--- a/src/sakura.c
+++ b/src/sakura.c
@@ -3033,6 +3033,9 @@ sakura_add_tab()
 	GtkWidget *event_box;
 	gint index, page, npages;
 	gchar *cwd = NULL; gchar *default_label_text = NULL;
+#ifndef NO_UTF8_CJK
+	gchar *vte_cjk_width = NULL;
+#endif
 
 	sk_tab = g_new0(struct sakura_tab, 1);
 
@@ -3310,6 +3313,14 @@ sakura_add_tab()
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
 
