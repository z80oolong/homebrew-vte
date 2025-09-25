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

class RoxtermAT31899Dev < Formula
  desc "Highly configurable terminal emulator based on VTE"
  homepage "https://roxterm.sourceforge.io/"

  current_commit = "c5a983c570323a6e8d1f7c5767de67013a2f610e"
  url "https://github.com/realh/roxterm.git",
    branch:   "master",
    revision: current_commit
  version "git-#{current_commit[0..7]}"
  license "LGPL-3.0"

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "pkgconf" => :build
  depends_on "dbus-glib"
  depends_on "glib"
  depends_on "z80oolong/vte/gtk+3@3.24.43"
  depends_on "z80oolong/vte/libvte@2.91"

  resource("roxterm-ja-po") do
    url "https://gist.github.com/731fd4e4d0adb4178ce69885bf061523.git",
        branch:   "main",
        revision: "72cd4d52211814ac3a8cecd2fc197447c3914c47"
  end

  patch :p1, :DATA

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

  def diff_data
    path.readlines(nil).first.gsub(/^.*\n__END__\n/m, "")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/roxterm --version")
  end
end

__END__
diff --git a/src/roxterm.c b/src/roxterm.c
index 7d608d8..1b5fdca 100644
--- a/src/roxterm.c
+++ b/src/roxterm.c
@@ -3459,6 +3459,9 @@ static GtkWidget *roxterm_multi_tab_filler(MultiWin * win, MultiTab * tab,
     gboolean custom_tab_name = FALSE;
     MultiWin *template_win = roxterm_get_win(roxterm_template);
     GtkWidget *viewport = NULL;
+#ifndef NO_UTF8_CJK
+    char *vte_cjk_width = NULL;
+#endif
 
     roxterm_terms = g_list_append(roxterm_terms, roxterm);
 
@@ -3485,6 +3488,14 @@ static GtkWidget *roxterm_multi_tab_filler(MultiWin * win, MultiTab * tab,
             roxterm->columns, roxterm->rows);
     gtk_widget_grab_focus(roxterm->widget);
     vte = VTE_TERMINAL(roxterm->widget);
+#ifndef NO_UTF8_CJK
+    vte_cjk_width = g_getenv("VTE_CJK_WIDTH");
+    if ((vte_cjk_width != NULL) && (strncmp((const char *)vte_cjk_width, "1", (size_t)1) == 0)) {
+        if (vte_terminal_get_cjk_ambiguous_width(vte) != 2) {
+            vte_terminal_set_cjk_ambiguous_width(vte, 2);
+        }
+    }
+#endif
     if (vte_widget)
         *vte_widget = roxterm->widget;
     if (adjustment)
