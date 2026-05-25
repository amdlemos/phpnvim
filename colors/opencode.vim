" OpenCode Theme for Neovim
" Based on OpenCode desktop theme

set background=dark
let g:colors_name = "opencode"

" Clear existing colors
highlight clear
if exists("syntax_on")
  syntax reset
endif

" Detectar dark/light
let s:is_dark = &background == "dark"

" Dark mode palette
let s:dark = {
  \ 'bg': '#0a0a0a',
  \ 'fg': '#eeeeee',
  \ 'primary': '#fab283',
  \ 'accent': '#9d7cd8',
  \ 'success': '#7fd88f',
  \ 'warning': '#f5a742',
  \ 'error': '#e06c75',
  \ 'info': '#56b6c2',
  \ 'diffAdd': '#b8db87',
  \ 'diffDelete': '#e26a75',
  \ 'text_weak': '#808080',
  \ 'comment': '#808080',
  \ 'keyword': '#9d7cd8',
  \ 'string': '#7fd88f',
  \ 'primitive': '#fab283',
  \ 'variable': '#e06c75',
  \ 'property': '#56b6c2',
  \ 'type_color': '#e5c07b',
  \ 'constant': '#f5a742',
  \ 'operator': '#56b6c2',
  \ 'punctuation': '#eeeeee',
  \ 'object': '#e06c75',
  \ 'heading': '#9d7cd8',
  \ 'link': '#fab283',
  \ 'link_text': '#56b6c2',
  \ 'code': '#7fd88f',
  \ 'block_quote': '#e5c07b',
  \ 'emph': '#e5c07b',
  \ 'strong': '#f5a742',
  \ }

" Light mode palette
let s:light = {
  \ 'bg': '#ffffff',
  \ 'fg': '#1a1a1a',
  \ 'primary': '#3b7dd8',
  \ 'accent': '#d68c27',
  \ 'success': '#3d9a57',
  \ 'warning': '#d68c27',
  \ 'error': '#d1383d',
  \ 'info': '#318795',
  \ 'diffAdd': '#4db380',
  \ 'diffDelete': '#f52a65',
  \ 'text_weak': '#8a8a8a',
  \ 'comment': '#8a8a8a',
  \ 'keyword': '#d68c27',
  \ 'string': '#3d9a57',
  \ 'primitive': '#3b7dd8',
  \ 'variable': '#d1383d',
  \ 'property': '#318795',
  \ 'type_color': '#b0851f',
  \ 'constant': '#d68c27',
  \ 'operator': '#318795',
  \ 'punctuation': '#1a1a1a',
  \ 'object': '#d1383d',
  \ 'heading': '#d68c27',
  \ 'link': '#3b7dd8',
  \ 'link_text': '#318795',
  \ 'code': '#3d9a57',
  \ 'block_quote': '#b0851f',
  \ 'emph': '#b0851f',
  \ 'strong': '#d68c27',
  \ }

let s:colors = s:is_dark ? s:dark : s:light

" UI / Editor
execute 'highlight Normal guifg=' . s:colors.fg . ' guibg=' . s:colors.bg
execute 'highlight NormalFloat guifg=' . s:colors.fg . ' guibg=' . s:colors.bg
execute 'highlight FloatBorder guifg=' . s:colors.primary . ' guibg=' . s:colors.bg
execute 'highlight EndOfBuffer guifg=' . s:colors.bg
execute 'highlight LineNr guifg=' . s:colors.comment
execute 'highlight LineNrAbove guifg=' . s:colors.comment
execute 'highlight LineNrBelow guifg=' . s:colors.comment
execute 'highlight CursorLine guibg=' . (s:is_dark ? '#1a1a1a' : '#f5f5f5')
execute 'highlight CursorLineNr guifg=' . s:colors.primary . ' gui=bold'
execute 'highlight CursorColumn guibg=' . (s:is_dark ? '#1a1a1a' : '#f5f5f5')
execute 'highlight VertSplit guifg=' . s:colors.text_weak
execute 'highlight Folded guifg=' . s:colors.comment . ' guibg=' . (s:is_dark ? '#1a1a1a' : '#f5f5f5')
execute 'highlight SignColumn guibg=' . s:colors.bg
execute 'highlight StatusLine guifg=' . s:colors.fg . ' guibg=' . (s:is_dark ? '#1a1a1a' : '#f5f5f5')
execute 'highlight StatusLineNC guifg=' . s:colors.text_weak . ' guibg=' . (s:is_dark ? '#0f0f0f' : '#fafafa')
execute 'highlight TabLine guifg=' . s:colors.text_weak . ' guibg=' . (s:is_dark ? '#1a1a1a' : '#f5f5f5')
execute 'highlight TabLineFill guibg=' . (s:is_dark ? '#1a1a1a' : '#f5f5f5')
execute 'highlight TabLineSel guifg=' . s:colors.fg . ' guibg=' . s:colors.bg . ' gui=bold'

" Search/Selection
execute 'highlight Search guifg=' . s:colors.bg . ' guibg=' . s:colors.warning . ' gui=bold'
execute 'highlight IncSearch guifg=' . s:colors.bg . ' guibg=' . s:colors.accent . ' gui=bold'
execute 'highlight Visual guibg=' . (s:is_dark ? '#2a2a3a' : '#e8f0f8')
execute 'highlight VisualNOS guibg=' . (s:is_dark ? '#2a2a3a' : '#e8f0f8')

" Syntax
execute 'highlight Comment guifg=' . s:colors.comment . ' gui=italic'
execute 'highlight String guifg=' . s:colors.string
execute 'highlight Character guifg=' . s:colors.string
execute 'highlight Number guifg=' . s:colors.primitive
execute 'highlight Boolean guifg=' . s:colors.primitive . ' gui=bold'
execute 'highlight Float guifg=' . s:colors.primitive
execute 'highlight Identifier guifg=' . s:colors.fg
execute 'highlight Function guifg=' . s:colors.accent
execute 'highlight Statement guifg=' . s:colors.keyword . ' gui=bold'
execute 'highlight Keyword guifg=' . s:colors.keyword . ' gui=bold'
execute 'highlight Conditional guifg=' . s:colors.keyword . ' gui=bold'
execute 'highlight Repeat guifg=' . s:colors.keyword . ' gui=bold'
execute 'highlight Label guifg=' . s:colors.keyword
execute 'highlight Operator guifg=' . s:colors.operator
execute 'highlight Exception guifg=' . s:colors.error . ' gui=bold'
execute 'highlight PreProc guifg=' . s:colors.keyword
execute 'highlight Include guifg=' . s:colors.keyword
execute 'highlight Define guifg=' . s:colors.keyword
execute 'highlight Macro guifg=' . s:colors.keyword
execute 'highlight PreCondit guifg=' . s:colors.keyword
execute 'highlight Type guifg=' . s:colors.type_color
execute 'highlight StorageClass guifg=' . s:colors.keyword
execute 'highlight Structure guifg=' . s:colors.type_color
execute 'highlight Typedef guifg=' . s:colors.type_color
execute 'highlight Constant guifg=' . s:colors.constant . ' gui=bold'
execute 'highlight Special guifg=' . s:colors.accent
execute 'highlight SpecialChar guifg=' . s:colors.accent
execute 'highlight Delimiter guifg=' . s:colors.punctuation
execute 'highlight SpecialComment guifg=' . s:colors.comment . ' gui=italic'
execute 'highlight Todo guifg=' . s:colors.warning . ' gui=bold'
execute 'highlight Error guifg=' . s:colors.error . ' gui=bold,underline'
execute 'highlight ErrorMsg guifg=' . s:colors.error . ' gui=bold'
execute 'highlight WarningMsg guifg=' . s:colors.warning . ' gui=bold'
execute 'highlight InfoMsg guifg=' . s:colors.info
execute 'highlight Question guifg=' . s:colors.success . ' gui=bold'

" Diff
execute 'highlight DiffAdd guifg=' . s:colors.diffAdd . ' guibg=' . (s:is_dark ? '#1a3a1a' : '#e8f5e9')
execute 'highlight DiffDelete guifg=' . s:colors.diffDelete . ' guibg=' . (s:is_dark ? '#3a1a1a' : '#ffebee')
execute 'highlight DiffChange guifg=' . s:colors.warning . ' guibg=' . (s:is_dark ? '#2a2a1a' : '#fff3e0')
execute 'highlight DiffText guifg=' . s:colors.warning . ' guibg=' . (s:is_dark ? '#3a3a1a' : '#ffe0b2') . ' gui=bold'

" Markdown
execute 'highlight markdownHeading guifg=' . s:colors.heading . ' gui=bold'
execute 'highlight markdownH1 guifg=' . s:colors.heading . ' gui=bold'
execute 'highlight markdownH2 guifg=' . s:colors.heading . ' gui=bold'
execute 'highlight markdownH3 guifg=' . s:colors.heading . ' gui=bold'
execute 'highlight markdownLink guifg=' . s:colors.link . ' gui=underline'
execute 'highlight markdownLinkText guifg=' . s:colors.link_text
execute 'highlight markdownCode guifg=' . s:colors.code
execute 'highlight markdownCodeBlock guifg=' . s:colors.code
execute 'highlight markdownBlockquote guifg=' . s:colors.block_quote . ' gui=italic'
execute 'highlight markdownItalic guifg=' . s:colors.emph . ' gui=italic'
execute 'highlight markdownBold guifg=' . s:colors.strong . ' gui=bold'
execute 'highlight markdownListMarker guifg=' . s:colors.link

" LSP
execute 'highlight DiagnosticError guifg=' . s:colors.error
execute 'highlight DiagnosticWarn guifg=' . s:colors.warning
execute 'highlight DiagnosticInfo guifg=' . s:colors.info
execute 'highlight DiagnosticHint guifg=' . s:colors.property
execute 'highlight DiagnosticUnderlineError guifg=' . s:colors.error . ' gui=underline'
execute 'highlight DiagnosticUnderlineWarn guifg=' . s:colors.warning . ' gui=underline'
execute 'highlight DiagnosticUnderlineInfo guifg=' . s:colors.info . ' gui=underline'
execute 'highlight DiagnosticUnderlineHint guifg=' . s:colors.property . ' gui=underline'

" Completion
execute 'highlight Pmenu guifg=' . s:colors.fg . ' guibg=' . (s:is_dark ? '#1a1a1a' : '#f5f5f5')
execute 'highlight PmenuSel guifg=' . s:colors.bg . ' guibg=' . s:colors.primary . ' gui=bold'
execute 'highlight PmenuSbar guibg=' . (s:is_dark ? '#0f0f0f' : '#efefef')
execute 'highlight PmenuThumb guibg=' . s:colors.text_weak

" DAP
execute 'highlight DapBreakpoint guifg=' . s:colors.error
execute 'highlight DapStopped guifg=' . s:colors.success
execute 'highlight DebugStopped guibg=' . (s:is_dark ? '#1a3a1a' : '#e8f5e9')

" Git Signs
execute 'highlight GitSignsAdd guifg=' . s:colors.success
execute 'highlight GitSignsChange guifg=' . s:colors.warning
execute 'highlight GitSignsDelete guifg=' . s:colors.error

" Trouble
execute 'highlight TroubleNormal guifg=' . s:colors.fg . ' guibg=' . s:colors.bg
execute 'highlight TroubleText guifg=' . s:colors.fg

" Folke plugins
execute 'highlight LazyProgressDone guifg=' . s:colors.success
execute 'highlight LazyProgressTodo guifg=' . s:colors.text_weak

" Terminal colors
if s:is_dark
  let g:terminal_color_0 = '#0a0a0a'
  let g:terminal_color_1 = s:colors.error
  let g:terminal_color_2 = s:colors.success
  let g:terminal_color_3 = s:colors.warning
  let g:terminal_color_4 = s:colors.primary
  let g:terminal_color_5 = s:colors.accent
  let g:terminal_color_6 = s:colors.info
  let g:terminal_color_7 = s:colors.text_weak
  let g:terminal_color_8 = s:colors.comment
  let g:terminal_color_9 = s:colors.error
  let g:terminal_color_10 = s:colors.success
  let g:terminal_color_11 = s:colors.warning
  let g:terminal_color_12 = s:colors.primary
  let g:terminal_color_13 = s:colors.accent
  let g:terminal_color_14 = s:colors.info
  let g:terminal_color_15 = s:colors.fg
else
  let g:terminal_color_0 = '#ffffff'
  let g:terminal_color_1 = s:colors.error
  let g:terminal_color_2 = s:colors.success
  let g:terminal_color_3 = s:colors.warning
  let g:terminal_color_4 = s:colors.primary
  let g:terminal_color_5 = s:colors.accent
  let g:terminal_color_6 = s:colors.info
  let g:terminal_color_7 = s:colors.text_weak
  let g:terminal_color_8 = s:colors.comment
  let g:terminal_color_9 = s:colors.error
  let g:terminal_color_10 = s:colors.success
  let g:terminal_color_11 = s:colors.warning
  let g:terminal_color_12 = s:colors.primary
  let g:terminal_color_13 = s:colors.accent
  let g:terminal_color_14 = s:colors.info
  let g:terminal_color_15 = s:colors.fg
endif
