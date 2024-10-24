# z80oolong/vte に含まれる Formula 一覧

## 概要

本文書では、 [Homebrew for Linux][BREW] 向け Tap リポジトリ z80oolong/vte に含まれる Formula 一覧を示します。各 Formula の詳細等については ```brew info <formula>``` コマンドも参照して下さい。

## Formula 一覧

### z80oolong/vte/sakura

Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）を修正した [libvte][LVTE] ベースの端末エミュレータである [sakura][SAKU] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [sakura][SAKU] では、以下の環境変数が拡張されます。

- ```VTE_CJK_WIDTH``` … [East Asian Ambiguous Character][EAWA] を全角文字幅として表示します。例えば、 [sakura][SAKU] において [East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、次のようにして [sakura][SAKU] を起動します。
  ```
  ...
   $ export VTE_CJK_WIDTH=1
   $ sakura
   (若しくは)
   $ env VTE_CJK_WIDTH=1 sakura
  ...
  ```

### z80oolong/vte/roxterm

Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）を修正した [libvte][LVTE] ベースの端末エミュレータである [roxterm][ROXT] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [roxterm][ROXT] では、前述の ```z80oolong/vte/sakura``` と同様に、環境変数 ```VTE_CJK_WIDTH``` が拡張されます。[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。

### z80oolong/vte/lxterminal

Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）を修正した [libvte][LVTE] ベースの LXDE 用端末エミュレータである lxterminal のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された lxterminal では、前述の ```z80oolong/vte/sakura``` と同様に、環境変数 ```VTE_CJK_WIDTH``` が拡張されます。[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。


### z80oolong/vte/mate-terminal

Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）を修正した [libvte][LVTE] ベースの MATE 用端末エミュレータである mate-terminal のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された mate-terminal では、前述の ```z80oolong/vte/sakura``` と同様に、環境変数 ```VTE_CJK_WIDTH``` が拡張されます。[East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。

**なお、この Formula によって導入された mate-terminal を正常に起動させるには、以下のように環境変数 ```GSETTINGS_SCHEMA_DIR, XDG_DATA_DIRS``` を適切に設定する必要があることに留意して下さい。**

```
  export GSETTINGS_SCHEMA_DIR="/home/linuxbrew/.linuxbrew/opt/mate-terminal/share/glib-2.0/schemas:/home/linuxbrew/.linuxbrew/share/glib-2.0/schemas:${GSETTINGS_SCHEMA_DIR}"
  export XDG_DATA_DIRS="/home/linuxbrew/.linuxbrew/opt/mate-terminal/share:/home/linuxbrew/.linuxbrew/share:${XDG_DATA_DIRS}"
```

### z80oolong/vte/geany

Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）を修正した [libvte][LVTE] ベースの軽量 IDE である [geany][GEAN] のうち、最新の安定版及び HEAD 版を導入するための Formula です。

この Formula によって導入された [geany][GEAN] では、前述の ```z80oolong/vte/sakura``` と同様に、環境変数 ```VTE_CJK_WIDTH``` が拡張されます。 [geany][GEAN] の端末機能において、 [East Asian Ambiguous Character][EAWA] を全角文字幅として表示する場合は、この環境変数の値を 1 に設定して下さい。


### z80oolong/eaw/libvte@2.91

GTK の端末エミュレータウィジェットである [libvte][LVTE] を提供する為のライブラリを導入するための Formula です。 ```sakura, roxterm, geany``` 等の [libvte][LVTE] ベースの端末エミュレータを持つアプリケーションがこのライブラリに依存します。

**この Formula は、 versioned formula であるため、この Formula によって導入される libvte は、 keg only で導入されることに留意して下さい。**

### z80oolong/eaw/sakura@{version}

(注：上記 ```{version}``` には、 [sakura][SAKU] の各バージョン番号が入ります。以下同様。)

この Formula は、 [East Asian Ambiguous Character][EAWA] 問題を修正した [libvte][LVTE] ベースの端末エミュレータである [sakura][SAKU] の安定版 [sakura {version}][SAKU] を導入します。

この Formula で導入した [sakura][SAKU] の使用法については、前述の ```z80oolong/vte/sakura``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [sakura][SAKU] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [sakura][SAKU] を使用するには、 ```brew link --force z80oolong/eaw/sakura@{version}``` コマンドを実行する必要があります。

### z80oolong/eaw/roxterm@{version}

(注：上記 ```{version}``` には、 [roxterm][ROXT] の各バージョン番号が入ります。以下同様。)

この Formula は、 [East Asian Ambiguous Character][EAWA] 問題を修正した [libvte][LVTE] ベースの端末エミュレータである [roxterm][ROXT] の安定版 [roxterm {version}][ROXT] を導入します。

この Formula で導入した [roxterm][ROXT] の使用法については、前述の ```z80oolong/vte/roxterm``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [roxterm][ROXT] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [roxterm][ROXT] を使用するには、 ```brew link --force z80oolong/eaw/roxterm@{version}``` コマンドを実行する必要があります。

### z80oolong/vte/lxterminal@{version}

(注：上記 ```{version}``` には、 lxterminal の各バージョン番号が入ります。以下同様。)

Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）を修正した [libvte][LVTE] ベースの端末エミュレータの安定版 ```lxterminal {version}``` を導入するための Formula です。

この Formula で導入した lxterminal の使用法については、前述の ```z80oolong/vte/lxterminal``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される lxterminal は、 keg only で導入されることに留意して下さい。**

### z80oolong/vte/mate-terminal@{version}

(注：上記 ```{version}``` には、 mate-terminal の各バージョン番号が入ります。以下同様。)

Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題 （以下、 [East Asian Ambiguous Character][EAWA] 問題）を修正した [libvte][LVTE] ベースの端末エミュレータの安定版 ```mate-terminal {version}``` を導入するための Formula です。

この Formula で導入した mate-terminal の使用法については、前述の ```z80oolong/vte/mate-terminal``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される mate-terminal は、 keg only で導入されることに留意して下さい。**

### z80oolong/eaw/geany@{version}

(注：上記 ```{version}``` には、 [geany][GEAN] の各バージョン番号が入ります。以下同様。)

この Formula は、 [East Asian Ambiguous Character][EAWA] 問題を修正した [libvte][LVTE] ベースの軽量 IDE である [geany][GEAN] の安定版 [geany {version}][GEAN] を導入します。

この Formula で導入した [roxterm][ROXT] の使用法については、前述の z80oolong/eaw/roxterm の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [geany][GEAN] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [geany][GEAN] を使用するには、 ```brew link --force z80oolong/eaw/geany@{version}``` コマンドを実行する必要があります。

<!-- 外部リンク一覧 -->

[BREW]:https://linuxbrew.sh/
[TMUX]:https://tmux.github.io/
[EAWA]:http://www.unicode.org/reports/tr11/#Ambiguous
[LVTE]:https://github.com/GNOME/vte
[SAKU]:https://github.com/dabisu/sakura
[ROXT]:https://github.com/realh/roxterm
[GEAN]:https://www.geany.org/
