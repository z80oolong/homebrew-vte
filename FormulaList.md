# z80oolong/vte に含まれる Formula 一覧

## 概要

本書では、[Homebrew for Linux][BREW] 向け Tap リポジトリ ```z80oolong/vte``` に含まれる Formula を紹介します。各 Formula の詳細は、```brew info <formula>``` コマンドで確認してください。

## Formula 一覧

### z80oolong/vte/libvte@2.91

[GTK][DGTK] の端末エミュレータウィジェットを提供するライブラリ [libvte][LVTE] を導入する Formula です。このライブラリは、以下で紹介する [libvte][LVTE] ベースの端末エミュレータアプリケーションに依存します。

**本 Formula は versioned formula のため、[libvte][LVTE] は keg-only でインストールされることに留意してください。**

### z80oolong/vte/sakura

[GTK][DGTK] および [libvte][LVTE] ベースの端末エミュレータ [sakura][SAKU] の最新安定版および HEAD 版を導入する Formula です。

本 Formula で導入された [sakura][SAKU] は、Unicode の [East_Asian_Width 特性が A (Ambiguous)][EAWA] である文字（以下、EAA 文字）の日本語環境での表示乱れ問題（以下、EAA 問題）を修正します。

**また、環境変数 ```VTE_CJK_WIDTH``` を拡張します。EAA 文字を全角幅で表示するには、以下のように設定して起動します：**

```
  export VTE_CJK_WIDTH=1
  sakura
  # または
  env VTE_CJK_WIDTH=1 sakura
```

### z80oolong/vte/roxterm

[libvte][LVTE] ベースのタブ式端末エミュレータ [roxterm][ROXT] の最新安定版および HEAD 版を導入する Formula です。

本 Formula で導入された [roxterm][ROXT] は、EAA 問題を修正し、一部のメニューおよび設定画面を除き、機械翻訳による簡易な日本語化を行っています。

**また、環境変数 ```VTE_CJK_WIDTH``` を拡張します。EAA 文字を全角幅で表示するには、```VTE_CJK_WIDTH=1``` に設定してください。**

### z80oolong/vte/tilda

[libvte][LVTE] ベースのドロップダウン端末エミュレータ [tilda][TILD] の最新安定版および HEAD 版を導入する Formula です。

本 Formula で導入された [tilda][TILD] は、EAA 問題を修正し、設定画面等の日本語化を行っています。

**また、環境変数 ```VTE_CJK_WIDTH``` を拡張します。EAA 文字を全角幅で表示するには、```VTE_CJK_WIDTH=1``` に設定してください。**

### z80oolong/vte/lxterminal

[libvte][LVTE] ベースの [LXDE][LXDE] 用端末エミュレータ [lxterminal][LXTM] の最新安定版および HEAD 版を導入する Formula です。

本 Formula で導入された [lxterminal][LXTM] は、EAA 問題を修正します。

**また、環境変数 ```VTE_CJK_WIDTH``` を拡張します。EAA 文字を全角幅で表示するには、```VTE_CJK_WIDTH=1``` に設定してください。**

### z80oolong/vte/geany

[libvte][LVTE] ベースの軽量 IDE [geany][GEAN] の最新安定版および HEAD 版を導入する Formula です。

本 Formula で導入された [geany][GEAN] は、EAA 問題を修正します。

**また、環境変数 ```VTE_CJK_WIDTH``` を拡張します。EAA 文字を全角幅で表示するには、```VTE_CJK_WIDTH=1``` に設定してください。**

### z80oolong/vte/sakura@{version}

（注: ```{version}``` は [sakura][SAKU] のバージョン番号を表します。）

[sakura][SAKU] の安定版を導入する Formula です。本 Formula で導入された [sakura][SAKU] は、EAA 問題を修正します。

使用法は ```z80oolong/vte/sakura``` の記述を参照してください。

**本 Formula は versioned formula のため、keg-only でインストールされることに留意してください。使用するには ```brew link --force z80oolong/vte/sakura@{version}``` を実行してください。**

### z80oolong/vte/sakura@9999-dev

本 Formula に同梱された EAA 問題を修正する差分ファイルを、対応する [sakura][SAKU] の HEAD 版のコミットに適用したものを導入する Formula です。**たとえば、本 Formula に同梱された差分ファイルが [sakura][SAKU] の HEAD 版のコミット ```xxxxxxxx``` に対応している場合、コミット ID ```xxxxxxxx``` のバージョンが導入されます。導入される具体的な commit ID は ```brew info z80oolong/vte/sakura@9999-dev``` で確認してください。**

使用法は ```z80oolong/vte/sakura``` の記述を参照してください。

**本 Formula は versioned formula のため、keg-only でインストールされることに留意してください。使用するには ```brew link --force z80oolong/vte/sakura@9999-dev``` を実行してください。**

**また、本 Formula は ```z80oolong/vte/sakura``` の HEAD 版でパッチ適用に問題が生じた場合の暫定用です。通常は ```z80oolong/vte/sakura``` を使用してください。**

### z80oolong/vte/roxterm@{version}

（注: ```{version}``` は [roxterm][ROXT] のバージョン番号を表します。）

[roxterm][ROXT] の安定版を導入する Formula です。本 Formula で導入された [roxterm][ROXT] は、EAA 問題を修正し、設定画面等の日本語化を行っています。

使用法は ```z80oolong/vte/roxterm``` の記述を参照してください。

**本 Formula は versioned formula のため、keg-only でインストールされることに留意してください。使用するには ```brew link --force z80oolong/vte/roxterm@{version}``` を実行してください。**

### z80oolong/vte/roxterm@9999-dev

本 Formula に同梱された EAA 問題を修正する差分ファイルを、対応する [roxterm][ROXT] の HEAD 版のコミットに適用したものを導入する Formula です。**たとえば、本 Formula に同梱された差分ファイルが [roxterm][ROXT] の HEAD 版のコミット ```xxxxxxxx``` に対応している場合、コミット ID ```xxxxxxxx``` のバージョンが導入されます。導入される具体的な commit ID は ```brew info z80oolong/vte/roxterm@9999-dev``` で確認してください。**

使用法は ```z80oolong/vte/roxterm``` の記述を参照してください。

**本 Formula は versioned formula のため、keg-only でインストールされることに留意してください。使用するには ```brew link --force z80oolong/vte/roxterm@9999-dev``` を実行してください。**

**また、本 Formula は ```z80oolong/vte/roxterm``` の HEAD 版でパッチ適用に問題が生じた場合の暫定用です。通常は ```z80oolong/vte/roxterm``` を使用してください。**

### z80oolong/vte/tilda@{version}

（注: ```{version}``` は [tilda][TILD] のバージョン番号を表します。）

[tilda][TILD] の安定版を導入する Formula です。本 Formula で導入された [tilda][TILD] は、EAA 問題を修正し、設定画面等の日本語化を行っています。

使用法は ```z80oolong/vte/tilda``` の記述を参照してください。

**本 Formula は versioned formula のため、keg-only でインストールされることに留意してください。使用するには ```brew link --force z80oolong/vte/tilda@{version}``` を実行してください。**

### z80oolong/vte/tilda@9999-dev

本 Formula に同梱された EAA 問題を修正する差分ファイルを、対応する [tilda][TILD] の HEAD 版のコミットに適用したものを導入する Formula です。**たとえば、本 Formula に同梱された差分ファイルが [tilda][TILD] の HEAD 版のコミット ```xxxxxxxx``` に対応している場合、コミット ID ```xxxxxxxx``` のバージョンが導入されます。導入される具体的な commit ID は ```brew info z80oolong/vte/tilda@9999-dev``` で確認してください。**

使用法は ```z80oolong/vte/tilda``` の記述を参照してください。

**本 Formula は versioned formula のため、keg-only でインストールされることに留意してください。使用するには ```brew link --force z80oolong/vte/tilda@9999-dev``` を実行してください。**

**また、本 Formula は ```z80oolong/vte/tilda``` の HEAD 版でパッチ適用に問題が生じた場合の暫定用です。通常は ```z80oolong/vte/tilda``` を使用してください。**

### z80oolong/vte/lxterminal@{version}

（注: ```{version}``` は [lxterminal][LXTM] のバージョン番号を表します。）

[lxterminal][LXTM] の安定版を導入する Formula です。本 Formula で導入された [lxterminal][LXTM] は、EAA 問題を修正します。

使用法は ```z80oolong/vte/lxterminal``` の記述を参照してください。

**注: 本 Formula は versioned formula のため、keg-only でインストールされます。使用するには ```brew link --force z80oolong/vte/lxterminal@{version}``` を実行してください。**

### z80oolong/vte/lxterminal@9999-dev

本 Formula に同梱された EAA 問題を修正する差分ファイルを、対応する [lxterminal][LXTM] の HEAD 版のコミットに適用したものを導入する Formula です。**たとえば、本 Formula に同梱された差分ファイルが [lxterminal][LXTM] の HEAD 版のコミット ```xxxxxxxx``` に対応している場合、コミット ID ```xxxxxxxx``` のバージョンが導入されます。導入される具体的な commit ID は ```brew info z80oolong/vte/lxterminal@9999-dev``` で確認してください。**

使用法は ```z80oolong/vte/lxterminal``` の記述を参照してください。

**注: 本 Formula は versioned formula のため、keg-only でインストールされます。使用するには ```brew link --force z80oolong/vte/lxterminal@9999-dev``` を実行してください。**

**本 Formula は、```z80oolong/vte/lxterminal``` の HEAD 版でパッチ適用に問題が生じた場合の暫定用です。通常は ```z80oolong/vte/lxterminal``` を使用してください。**

### z80oolong/vte/geany@{version}

（注: ```{version}``` は [geany][GEAN] のバージョン番号を表します。）

[geany][GEAN] の安定版を導入する Formula です。本 Formula で導入された [geany][GEAN] は、EAA 問題を修正します。

使用法は ```z80oolong/vte/geany``` の記述を参照してください。

**注: 本 Formula は versioned formula のため、keg-only でインストールされます。使用するには ```brew link --force z80oolong/vte/geany@{version}``` を実行してください。**

### z80oolong/vte/geany@9999-dev

本 Formula に同梱された EAA 問題を修正する差分ファイルを、対応する [geany][GEAN] の HEAD 版のコミットに適用したものを導入する Formula です。**たとえば、本 Formula に同梱された差分ファイルが [geany][GEAN] の HEAD 版のコミット ```xxxxxxxx``` に対応している場合、コミット ID ```xxxxxxxx``` のバージョンが導入されます。導入される具体的な commit ID は ```brew info z80oolong/vte/geany@9999-dev``` で確認してください。**

使用法は ```z80oolong/vte/geany``` の記述を参照してください。

**注: 本 Formula は versioned formula のため、keg-only でインストールされます。使用するには ```brew link --force z80oolong/vte/geany@9999-dev``` を実行してください。**

**本 Formula は、```z80oolong/vte/geany``` の HEAD 版でパッチ適用に問題が生じた場合の暫定用です。通常は ```z80oolong/vte/geany``` を使用してください。**

### z80oolong/vte/lua@5.1

```z80oolong/vte/geany```, ```z80oolong/vte/geany@{version}```, ```z80oolong/vte/geany@9999-dev``` のプラグインに依存する Lua 5.1 処理系を導入する Formula です。

<!-- 外部リンク一覧 -->

[BREW]:https://linuxbrew.sh/
[TMUX]:https://tmux.github.io/
[EAWA]:http://www.unicode.org/reports/tr11/#Ambiguous
[GNME]:https://www.gnome.org/
[GTRM]:https://github.com/GNOME/gnome-terminal
[LXDE]:http://www.lxde.org/
[LXTM]:https://github.com/lxde/lxterminal
[MATE]:https://mate-desktop.org/ja/
[MTTM]:https://wiki.mate-desktop.org/mate-desktop/applications/mate-terminal/
[XFCE]:https://www.xfce.org/
[XFTM]:https://github.com/xfce-mirror/xfce4-terminal
[DGTK]:https://gtk.org/
[LVTE]:https://github.com/GNOME/vte
[SAKU]:https://github.com/dabisu/sakura
[ROXT]:https://github.com/realh/roxterm
[TILD]:https://github.com/lanoxx/tilda/
[GEAN]:https://www.geany.org/
