# z80oolong/vte に含まれる Formula 一覧

## 概要

本文書では、 [Homebrew for Linux][BREW] 向け Tap リポジトリ z80oolong/vte に含まれる Formula 一覧を示します。各 Formula の詳細等については ```brew info <formula>``` コマンドも参照して下さい。

## Formula 一覧

### z80oolong/vte/sakura

[GTK][DGTK] と [libvte][LVTE] ベースの端末エミュレータである [sakura][SAKU] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [sakura][SAKU] では、**Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）が修正されます。**

また、この Formula によって導入された [sakura][SAKU] では、以下の環境変数が拡張されます。

- ```VTE_CJK_WIDTH``` … **[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 とします。** [sakura][SAKU] において、[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、以下のようにして ```sakura``` を起動します。

  ```
  ...
   $ export VTE_CJK_WIDTH=1
   $ sakura
   (若しくは)
   $ env VTE_CJK_WIDTH=1 sakura
  ...
  ```

### z80oolong/vte/roxterm

[libvte][LVTE] ベースであり、場所をとらないタブ式端末エミュレータである [roxterm][ROXT] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [roxterm][ROXT] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

また、この Formula によって導入された [roxterm][ROXT] では**一部のメニュー及び設定画面の表示を除き、メニュー及び設定画面等の表示について機械翻訳による簡易な日本語翻訳に基づく日本語化を行っています。**

そして、この Formula によって導入された [roxterm][ROXT] では、前述の ```z80oolong/vte/sakura``` と同様に、**環境変数 ```VTE_CJK_WIDTH``` が拡張されます。[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。**

### z80oolong/vte/tilda

[libvte][LVTE] ベースであり、設定可能なドロップダウン端末エミュレータである [tilda][TILD] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [tilda][TILD] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

また、この Formula によって導入された [tilda][TILD] では**一部のメニュー及び設定画面の表示を除き、メニュー及び設定画面等の表示について機械翻訳による簡易な日本語翻訳に基づく日本語化を行っています。**

そして、この Formula によって導入された [tilda][TILD] では、前述の ```z80oolong/vte/sakura``` と同様に、**環境変数 ```VTE_CJK_WIDTH``` が拡張されます。[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。**

### z80oolong/vte/lxterminal

[libvte][LVTE] ベースの [LXDE][LXDE] 用端末エミュレータである [lxterminal][LXTM] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [lxterminal][LXTM] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

また、この Formula によって導入された [lxterminal][LXTM] では、前述の ```z80oolong/vte/sakura``` と同様に、**環境変数 ```VTE_CJK_WIDTH``` が拡張されます。[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。**

### z80oolong/vte/mate-terminal

[libvte][LVTE] ベースの [MATE][MATE] 用端末エミュレータである [mate-terminal][MTTM] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [mate-terminal][MTTM] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

また、この Formula によって導入された [mate-terminal][MTTM] では、前述の ```z80oolong/vte/sakura``` と同様に、**環境変数 ```VTE_CJK_WIDTH``` が拡張されます。[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。**

**なお、この Formula によって導入された mate-terminal を正常に起動させるには、以下のように環境変数 ```GSETTINGS_SCHEMA_DIR, XDG_DATA_DIRS``` を適切に設定する必要があることに留意して下さい。**

```
  export GSETTINGS_SCHEMA_DIR="/home/linuxbrew/.linuxbrew/opt/mate-terminal/share/glib-2.0/schemas:/home/linuxbrew/.linuxbrew/share/glib-2.0/schemas:${GSETTINGS_SCHEMA_DIR}"
  export XDG_DATA_DIRS="/home/linuxbrew/.linuxbrew/opt/mate-terminal/share:/home/linuxbrew/.linuxbrew/share:${XDG_DATA_DIRS}"
```

### z80oolong/vte/xfce4-terminal

[libvte][LVTE] ベースの [xfce4][MATE] 用端末エミュレータである [xfce4-terminal][XFTM] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [xfce4-terminal][XFTM] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

なお、 Formula によって導入された [xfce4-terminal][XFTM] において、**[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、 [xfce4-terminal][XFTM] の設定画面より設定を行う必要があることに留意して下さい。**

### z80oolong/vte/geany

[libvte][LVTE] ベースの軽量 IDE である [geany][GEAN] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [geany][GEAN] では、**前述の [East Asian Ambiguous Character][EAWA] 問題が修正されます。**

また、この Formula によって導入された [geany][GEAN] では、前述の ```z80oolong/vte/sakura``` と同様に、**環境変数 ```VTE_CJK_WIDTH``` が拡張されます。 [geany][GEAN] の端末機能において、 [East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。**

### z80oolong/vte/libvte@2.91

[GTK][DGTK] の端末エミュレータウィジェットである [libvte][LVTE] を提供する為のライブラリを導入するための Formula です。上述した [libvte][LVTE] ベースの端末エミュレータを持つアプリケーションがこのライブラリに依存します。

**この Formula は、 versioned formula であるため、この Formula によって導入される libvte は、 keg only で導入されることに留意して下さい。**

### z80oolong/vte/sakura@{version}

(注：上記 ```{version}``` には、 [sakura][SAKU] の各バージョン番号が入ります。以下同様。)

この Formula は、 ```z80oolong/vte/sakura``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータである [sakura][SAKU] の安定版 [sakura {version}][SAKU] を導入します。

この Formula で導入した [sakura][SAKU] の使用法については、前述の ```z80oolong/vte/sakura``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [sakura][SAKU] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [sakura][SAKU] を使用するには、 ```brew link --force z80oolong/vte/sakura@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/roxterm@{version}

(注：上記 ```{version}``` には、 [roxterm][ROXT] の各バージョン番号が入ります。以下同様。)

この Formula は、 ```z80oolong/vte/roxterm``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータである [roxterm][ROXT] の安定版 [roxterm {version}][ROXT] を導入します。

この Formula で導入した [roxterm][ROXT] の使用法については、前述の ```z80oolong/vte/roxterm``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [roxterm][ROXT] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [roxterm][ROXT] を使用するには、 ```brew link --force z80oolong/vte/roxterm@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/tilda@{version}

(注：上記 ```{version}``` には、 [tilda][TILD] の各バージョン番号が入ります。以下同様。)

この Formula は、 ```z80oolong/vte/tilda``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータである [tilda][TILD] の安定版 [tilda {version}][ROXT] を導入します。

なお、この Formula で導入した [tilda][TILD] の使用法については、前述の ```z80oolong/vte/tilda``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [tilda][TILD] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [tilda][TILD] を使用するには、 ```brew link --force z80oolong/vte/tilda@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/lxterminal@{version}

(注：上記 ```{version}``` には、 [lxterminal][LXTM] の各バージョン番号が入ります。以下同様。)

この Formula は、 ```z80oolong/vte/lxterminal``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータの安定版 [lxterminal {version}][LXTM] を導入します。

なお、この Formula で導入した [lxterminal][LXTM] の使用法については、前述の ```z80oolong/vte/lxterminal``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [lxterminal][LXTM] は、 keg only で導入されることに留意して下さい。**

### z80oolong/vte/mate-terminal@{version}

(注：上記 ```{version}``` には、 [mate-terminal][MTTM] の各バージョン番号が入ります。以下同様。)

この Formula は、 ```z80oolong/vte/mate-terminal``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータの安定版 [mate-terminal {version}][MTTM] を導入するための Formula です。

なお、この Formula で導入した [mate-terminal][MTTM] の使用法については、前述の ```z80oolong/vte/mate-terminal``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [mate-terminal][MTTM] は、 keg only で導入されることに留意して下さい。**

### z80oolong/vte/xfce4-terminal@{version}

(注：上記 ```{version}``` には、 [xfce4-terminal][XFTM] の各バージョン番号が入ります。以下同様。)

この Formula は、 ```z80oolong/vte/xfce4-terminal``` において述べた問題を修正した [libvte][LVTE] ベースの端末エミュレータの安定版 [xfce4-terminal {version}][MTTM] を導入するための Formula です。

なお、この Formula で導入した [xfce4-terminal][XFTM] の使用法については、前述の ```z80oolong/vte/mate-terminal``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [xfce4-terminal][MTTM] は、 keg only で導入されることに留意して下さい。**

### z80oolong/vte/geany@{version}

(注：上記 ```{version}``` には、 [geany][GEAN] の各バージョン番号が入ります。以下同様。)

この Formula は、 ```z80oolong/vte/geany``` において述べた問題を修正した [libvte][LVTE] ベースの軽量 IDE である [geany][GEAN] の安定版 [geany {version}][GEAN] を導入します。

なお、この Formula で導入した [geany][GEAN] の使用法については、前述の ```z80oolong/vte/geany``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [geany][GEAN] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [geany][GEAN] を使用するには、 ```brew link --force z80oolong/vte/geany@{version}``` コマンドを実行する必要があります。

<!-- 外部リンク一覧 -->

[BREW]:https://linuxbrew.sh/
[TMUX]:https://tmux.github.io/
[EAWA]:http://www.unicode.org/reports/tr11/#Ambiguous
[GNME]:https://www.gnome.org/
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
