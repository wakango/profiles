PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# users generic .zshrc file for zsh(1)
# PROMPT
autoload colors
colors
PROMPT="[%n@%m]%{${fg[green]}%}%~%{${reset_color}%}
$ "

PROMPT2='> ' 

### Environment variable configuration
    # LANG
    # http://curiousabt.blog27.fc2.com/blog-entry-65.html
    export LANG=ja_JP.UTF-8
    export LESSCHARSET=utf-8
    
    # プロンプトが表示されるたびにプロンプト文字列を評価、置換する
    setopt prompt_subst
    
    ### 移動 ###
    # つまりディレクトリ名でcd
    setopt auto_cd
    # cd でTabを押すとdir list を表示
    setopt auto_pushd
    # ディレクトリスタックに同じディレクトリを追加しないようになる
    #setopt pushd_ignore_dups
    # シンボリックリンクは実体を追うようになる
    #setopt chase_links

### スペルチェック ###
    # コマンドのスペルチェックをする
    setopt correct
    # コマンドライン全てのスペルチェックをする
    setopt correct_all
    # 上書きリダイレクトの禁止
    #setopt no_clobber

### 補完 ###
    # 補完候補リストを詰めて表示
    setopt list_packed
    # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
    setopt list_types
    # 補完候補が複数ある時に、一覧表示する
    setopt auto_list
    # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
    setopt magic_equal_subst
    # カッコの対応などを自動的に補完する
    setopt auto_param_keys
    # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
    setopt auto_param_slash
    # 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
    setopt auto_menu
    # sudoも補完の対象
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
    # 色付きで補完する
    zstyle ':completion:*' list-colors di=34 fi=0
    #zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
    #setopt noautoremoveslash
    # 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
    setopt multios
    # beepを鳴らさないようにする
    setopt nolistbeep

### Keybind configuration ###
    # emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
    #   to end of it)
    bindkey -v

    # historical backward/forward search with linehead string binded to ^P/^N
    autoload history-search-end
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    bindkey "^p" history-beginning-search-backward-end
    bindkey "^n" history-beginning-search-forward-end
    bindkey "\\ep" history-beginning-search-backward-end
    bindkey "\\en" history-beginning-search-forward-end
    
    # glob(*)によるインクリメンタルサーチ
    bindkey '^R' history-incremental-pattern-search-backward
    bindkey '^S' history-incremental-pattern-search-forward

    # ctrl-w, ctrl-bキーで単語移動
    bindkey "^W" forward-word
    bindkey "^B" backward-word
    # ctrl-h, ctrl-lキーで単語移動
    #bindkey "^h" backward-char
    #bindkey "^l" forward-char
    
### Command history configuration ###
    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    # 登録済コマンド行は古い方を削除
    setopt hist_ignore_all_dups
    # historyの共有
    setopt share_history
    # 余分な空白は詰める
    setopt hist_reduce_blanks
    # add history when command executed.
    setopt inc_append_history
    # history (fc -l) コマンドをヒストリリストから取り除く。
    setopt hist_no_store
    # コマンドラインでも # 以降をコメントと見なす
    setopt interactive_comments
    # コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
    setopt path_dirs
    # 各コマンドが実行されるときにパスをハッシュに入れる
    #setopt hash_cmds
    # コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
    #setopt hist_ignore_space
    # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
    #setopt hist_verify
    # シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
    #setopt NO_hup
    # メールスプール $MAIL が読まれていたらワーニングを表示する
    #setopt mail_warning
    # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
    #setopt mark_dirs
    # ファイル名の展開で、辞書順ではなく数値的にソートされるようになる
    #setopt numeric_glob_sort
    # 戻り値が 0 以外の場合終了コードを表示する
    # setopt print_exit_value
    # pushd を引数なしで実行した場合 pushd $HOME と見なされる
    #setopt pushd_to_home
    # rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
    #setopt rm_star_silent
    # for, repeat, select, if, function などで簡略文法が使えるようになる
    #setopt short_loops
    # コマンドラインがどのように展開され実行されたかを表示するようになる
    #setopt xtrace

### Moving Configuration ###
    # back-wordでの単語境界の設定
    autoload -Uz select-word-style
    select-word-style default
    zstyle ':zle:*' word-chars " _-./;@"
    zstyle ':zle:*' word-style unspecified

# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# エラーメッセージ本文出力に色付け
e_normal=`echo -e "¥033[0;30m"`
e_RED=`echo -e "¥033[1;31m"`
e_BLUE=`echo -e "¥033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}

### Completion configuration ###
    fpath=(~/.zsh/functions/Completion ${fpath})
    autoload -U compinit
    compinit
    #compinit -u

### zsh editor ###
    autoload zed

### Prediction configuration ###
    autoload predict-on
    #predict-off

### Command Line Stack [Esc]-[q] ###
    bindkey -a 'q' push-line

###  Alias configuration ###
    # expand aliases before completing
    setopt complete_aliases     # aliased ls needs if file/dir completions work
    alias where="command -v"
    
    case "${OSTYPE}" in
    # MacOSX
    darwin*)
        export PATH=$PATH:/opt/local/bin:/opt/local/sbin/
        export PATH=$PATH:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/
        ;;
    freebsd*)
        case ${UID} in
        0)
            updateports()
            {
                if [ -f /usr/ports/.portsnap.INDEX ]
                then
                    portsnap fetch update
                else
                    portsnap fetch extract update
                fi
                (cd /usr/ports/; make index)
    
                portversion -v -l \<
            }
            alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
            ;;
        esac
        ;;
    esac
    [ -f ~/profiles/.zshrc.alias ] && source ~/profiles/.zshrc.alias
    
    case "${OSTYPE}" in
    # Mac(Unix)
    darwin*)
        [ -f ~/profiles/.zshrc.osx ] && source ~/profiles/.zshrc.osx
        ;;
    # Linux
    linux*)
        [ -f ~/profiles/.zshrc.linux ] && source ~/profiles/.zshrc.linux
        ;;
    esac
    
### terminal configuration ###
    export EDITOR=vim
    export PATH=$PATH:$HOME/local/bin:/usr/local/git/bin
    export PATH=$PATH:$HOME/profiles/bin
    export PATH=$PATH:/sbin:/usr/local/bin
    export MANPATH=$MANPATH:/opt/local/man:/usr/local/share/man

expand-to-home-or-insert () {
    if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
            LBUFFER+="~/"
    else
            zle self-insert
    fi
}

# C-M-h でチートシートを表示する
cheat-sheet () { zle -M "`cat ~/profiles/.zsh/cheat-sheet`" }
zle -N cheat-sheet

# zsh の exntended_glob と HEAD^^^ を共存させる。
# http://subtech.g.hatena.ne.jp/cho45/20080617/1213629154
typeset -A abbreviations
abbreviations=(
  "L"    "| $PAGER"
  "G"    "| grep"

  "HEAD^"     "HEAD\\^"
  "HEAD^^"    "HEAD\\^\\^"
  "HEAD^^^"   "HEAD\\^\\^\\^"
  "HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
  "HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"
)

magic-abbrev-expand () {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-abbrev-expand-and-insert () {
  magic-abbrev-expand
  zle self-insert
}

magic-abbrev-expand-and-accept () {
  magic-abbrev-expand
  zle accept-line
}

no-magic-abbrev-expand () {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
bindkey "\r"  magic-abbrev-expand-and-accept # M-x RET はできなくなる
bindkey "^J"  accept-line # no magic
bindkey " "   magic-abbrev-expand-and-insert
bindkey "."   magic-abbrev-expand-and-insert
bindkey "^x " no-magic-abbrev-expand

### local固有設定
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
