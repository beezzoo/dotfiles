# dotfiles

Конфиги для zsh, tmux и консольных утилит в палитре gruvbox.

## Состав

| Файл / каталог        | Назначение                                                  |
|-----------------------|-------------------------------------------------------------|
| `.zshrc`              | zsh: Oh My Zsh, zinit, Powerlevel10k, zoxide, алиасы, pyenv |
| `.p10k.zsh`           | тема Powerlevel10k (powerline без nerdfont)                 |
| `.tmux.conf`          | tmux: tpm, статусбар, true color, мышь                      |
| `.config/tmux/`       | скрипты для статусбара tmux и плагин tpm                    |
| `.config/yazi/`       | файловый менеджер yazi: тема gruvbox, плагин piper          |
| `.config/superfile/`  | файловый менеджер superfile и набор тем                     |
| `.config/glow/`       | рендер markdown в терминале, стиль gruvbox                  |
| `.config/bat/`        | замена cat                                                  |
| `.config/eza/`        | замена ls                                                   |

## Установка

```sh
git clone https://github.com/beezzoo/dotfiles ~/dotfiles
ln -s dotfiles/.zshrc     ~/.zshrc
ln -s dotfiles/.tmux.conf ~/.tmux.conf
ln -s dotfiles/.p10k.zsh  ~/.p10k.zsh
ln -s dotfiles/.config    ~/.config
```

Поскольку `~/.config` целиком указывает в репозиторий, приложения складывают
туда своё состояние, кэши и токены. `.gitignore` игнорирует всё в `.config/`,
кроме каталогов из таблицы выше. Чтобы начать вести новый каталог, добавьте
в `.gitignore` строку вида `!.config/<имя>/`.

При первом запуске zsh сам скачает Oh My Zsh и zinit, если их нет.
Плагины tmux ставятся через tpm: `prefix + I`.

Нужные утилиты: `zsh`, `tmux`, `eza`, `bat`, `duf`, `zoxide`, `yazi`, `glow`,
`pyenv`, `npm`.

## Локальные настройки: `~/.zshrc.local`

Всё, что относится только к одной машине, живёт в `~/.zshrc.local`.
Файл не входит в репозиторий, а `.zshrc` подключает его последней строкой,
если он существует:

```sh
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
```

Что туда класть:

- алиасы под конкретную машину, например `alias sudo='sudo-rs'`
  или алиасы для проектов вроде `ida-dev`;
- пути к локально установленным инструментам: texlive, zigup, opencode,
  astracode и т.п.;
- подключение приватных env-файлов, например `~/.config/openbao/env`.

Пример:

```sh
alias sudo='sudo-rs'
alias ida-dev='cd ~/projects/BILabs/IDA_DEV && source venv/bin/activate'

export PATH="$HOME/.local/share/zigup/0.14.1/files:$PATH"
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
export TEXMFSYSVAR=/usr/local/texlive/2025/texmf-var

[ -f ~/.config/openbao/env ] && source ~/.config/openbao/env
```

Так `.zshrc` в репозитории остаётся одинаковым на всех машинах,
а `git status` не показывает вечно изменённый файл.
