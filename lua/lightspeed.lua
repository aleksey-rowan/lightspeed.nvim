local api = vim.api
local function inc(x)
  return (x + 1)
end
local function dec(x)
  return (x - 1)
end
local function clamp(val, min, max)
  if (val < min) then
    return min
  elseif (val > max) then
    return max
  elseif "else" then
    return val
  end
end
local function last(tbl)
  return tbl[#tbl]
end
local empty_3f = vim.tbl_isempty
local map = vim.tbl_map
local function string_3f(x)
  return (type(x) == "string")
end
local function reverse_lookup(tbl)
  local tbl_9_auto = {}
  for k, v in ipairs(tbl) do
    local _2_, _3_ = v, k
    if ((nil ~= _2_) and (nil ~= _3_)) then
      local k_10_auto = _2_
      local v_11_auto = _3_
      tbl_9_auto[k_10_auto] = v_11_auto
    end
  end
  return tbl_9_auto
end
local function getchar_as_str()
  local ok_3f, ch = pcall(vim.fn.getchar)
  local function _5_()
    if (type(ch) == "number") then
      return vim.fn.nr2char(ch)
    else
      return ch
    end
  end
  return ok_3f, _5_()
end
local function replace_keycodes(s)
  return api.nvim_replace_termcodes(s, true, false, true)
end
local function echo(msg)
  vim.cmd("redraw")
  return api.nvim_echo({{msg}}, false, {})
end
local function operator_pending_mode_3f()
  return string.match(api.nvim_get_mode().mode, "o")
end
local function yank_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator == "y"))
end
local function change_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator == "c"))
end
local function delete_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator == "d"))
end
local function dot_repeatable_operation_3f()
  return (operator_pending_mode_3f() and (vim.v.operator ~= "y"))
end
local function get_cursor_pos()
  return {vim.fn.line("."), vim.fn.col(".")}
end
local function char_at_pos(_6_, _8_)
  local _arg_7_ = _6_
  local line = _arg_7_[1]
  local byte_col = _arg_7_[2]
  local _arg_9_ = _8_
  local char_offset = _arg_9_["char-offset"]
  local line_str = vim.fn.getline(line)
  local char_idx = vim.fn.charidx(line_str, dec(byte_col))
  local char_nr = vim.fn.strgetchar(line_str, (char_idx + (char_offset or 0)))
  if (char_nr ~= -1) then
    return vim.fn.nr2char(char_nr)
  end
end
local function leftmost_editable_wincol()
  local view = vim.fn.winsaveview()
  vim.cmd("norm! 0")
  local wincol = vim.fn.wincol()
  vim.fn.winrestview(view)
  return wincol
end
local opts = {cycle_group_bwd_key = nil, cycle_group_fwd_key = nil, grey_out_search_area = true, highlight_unique_chars = false, instant_repeat_bwd_key = nil, instant_repeat_fwd_key = nil, jump_on_partial_input_safety_timeout = 400, jump_to_first_match = true, labels = nil, limit_ft_matches = 5, match_only_the_start_of_same_char_seqs = true, substitute_chars = {["\13"] = "\194\172"}, x_mode_prefix_key = "<c-x>"}
local function setup(user_opts)
  opts = setmetatable(user_opts, {__index = opts})
  return nil
end
local hl
local function _11_(self, hl_group, line, startcol, endcol)
  return api.nvim_buf_add_highlight(0, self.ns, hl_group, line, startcol, endcol)
end
local function _12_(self, line, col, opts0)
  return api.nvim_buf_set_extmark(0, self.ns, line, col, opts0)
end
local function _13_(self)
  return api.nvim_buf_clear_namespace(0, self.ns, 0, -1)
end
hl = {["add-hl"] = _11_, ["set-extmark"] = _12_, cleanup = _13_, group = {["label-distant"] = "LightspeedLabelDistant", ["label-distant-overlapped"] = "LightspeedLabelDistantOverlapped", ["label-overlapped"] = "LightspeedLabelOverlapped", ["masked-ch"] = "LightspeedMaskedChar", ["one-char-match"] = "LightspeedOneCharMatch", ["pending-op-area"] = "LightspeedPendingOpArea", ["shortcut-overlapped"] = "LightspeedShortcutOverlapped", ["unique-ch"] = "LightspeedUniqueChar", ["unlabeled-match"] = "LightspeedUnlabeledMatch", cursor = "LightspeedCursor", greywash = "LightspeedGreyWash", label = "LightspeedLabel", shortcut = "LightspeedShortcut"}, ns = api.nvim_create_namespace("")}
local function init_highlight(force_3f)
  local bg = vim.o.background
  local groupdefs
  local _15_
  do
    local _14_ = bg
    if (_14_ == "light") then
      _15_ = "#f02077"
    else
      local _ = _14_
      _15_ = "#ff2f87"
    end
  end
  local _20_
  do
    local _19_ = bg
    if (_19_ == "light") then
      _20_ = "#ff4090"
    else
      local _ = _19_
      _20_ = "#e01067"
    end
  end
  local _25_
  do
    local _24_ = bg
    if (_24_ == "light") then
      _25_ = "Blue"
    else
      local _ = _24_
      _25_ = "Cyan"
    end
  end
  local _30_
  do
    local _29_ = bg
    if (_29_ == "light") then
      _30_ = "#399d9f"
    else
      local _ = _29_
      _30_ = "#99ddff"
    end
  end
  local _35_
  do
    local _34_ = bg
    if (_34_ == "light") then
      _35_ = "Cyan"
    else
      local _ = _34_
      _35_ = "Blue"
    end
  end
  local _40_
  do
    local _39_ = bg
    if (_39_ == "light") then
      _40_ = "#59bdbf"
    else
      local _ = _39_
      _40_ = "#79bddf"
    end
  end
  local _45_
  do
    local _44_ = bg
    if (_44_ == "light") then
      _45_ = "#cc9999"
    else
      local _ = _44_
      _45_ = "#b38080"
    end
  end
  local _50_
  do
    local _49_ = bg
    if (_49_ == "light") then
      _50_ = "Black"
    else
      local _ = _49_
      _50_ = "White"
    end
  end
  local _55_
  do
    local _54_ = bg
    if (_54_ == "light") then
      _55_ = "#272020"
    else
      local _ = _54_
      _55_ = "#f3ecec"
    end
  end
  groupdefs = {{hl.group.label, {cterm = "bold,underline", ctermbg = "NONE", ctermfg = "Red", gui = "bold,underline", guibg = "NONE", guifg = _15_}}, {hl.group["label-overlapped"], {cterm = "underline", ctermbg = "NONE", ctermfg = "Magenta", gui = "underline", guibg = "NONE", guifg = _20_}}, {hl.group["label-distant"], {cterm = "bold,underline", ctermbg = "NONE", ctermfg = _25_, gui = "bold,underline", guibg = "NONE", guifg = _30_}}, {hl.group["label-distant-overlapped"], {cterm = "underline", ctermfg = _35_, gui = "underline", guifg = _40_}}, {hl.group.shortcut, {cterm = "bold,underline", ctermbg = "Red", ctermfg = "White", gui = "bold,underline", guibg = "#f00077", guifg = "#ffffff"}}, {hl.group["one-char-match"], {cterm = "bold", ctermbg = "Red", ctermfg = "White", gui = "bold", guibg = "#f00077", guifg = "#ffffff"}}, {hl.group["masked-ch"], {cterm = "NONE", ctermbg = "NONE", ctermfg = "DarkGrey", gui = "NONE", guibg = "NONE", guifg = _45_}}, {hl.group["unlabeled-match"], {cterm = "bold", ctermbg = "NONE", ctermfg = _50_, gui = "bold", guibg = "NONE", guifg = _55_}}, {hl.group["pending-op-area"], {ctermbg = "Red", ctermfg = "White", guibg = "#f00077", guifg = "#ffffff"}}, {hl.group.greywash, {cterm = "NONE", ctermbg = "NONE", ctermfg = "Grey", gui = "NONE", guibg = "NONE", guifg = "#777777"}}}
  for _, _59_ in ipairs(groupdefs) do
    local _each_60_ = _59_
    local group = _each_60_[1]
    local attrs = _each_60_[2]
    local attrs_str
    local _61_
    do
      local tbl_12_auto = {}
      for k, v in pairs(attrs) do
        tbl_12_auto[(#tbl_12_auto + 1)] = (k .. "=" .. v)
      end
      _61_ = tbl_12_auto
    end
    attrs_str = table.concat(_61_, " ")
    local _62_
    if force_3f then
      _62_ = ""
    else
      _62_ = "default "
    end
    vim.cmd(("highlight " .. _62_ .. group .. " " .. attrs_str))
  end
  for _, _64_ in ipairs({{hl.group["unique-ch"], hl.group["unlabeled-match"]}, {hl.group["shortcut-overlapped"], hl.group.shortcut}, {hl.group.cursor, "Cursor"}}) do
    local _each_65_ = _64_
    local from_group = _each_65_[1]
    local to_group = _each_65_[2]
    local _66_
    if force_3f then
      _66_ = ""
    else
      _66_ = "default "
    end
    vim.cmd(("highlight " .. _66_ .. "link " .. from_group .. " " .. to_group))
  end
  return nil
end
local function grey_out_search_area(reverse_3f)
  local _let_68_ = map(dec, get_cursor_pos())
  local curline = _let_68_[1]
  local curcol = _let_68_[2]
  local _let_69_ = {dec(vim.fn.line("w0")), dec(vim.fn.line("w$"))}
  local win_top = _let_69_[1]
  local win_bot = _let_69_[2]
  local function _71_()
    if reverse_3f then
      return {{win_top, 0}, {curline, curcol}}
    else
      return {{curline, inc(curcol)}, {win_bot, -1}}
    end
  end
  local _let_70_ = _71_()
  local start = _let_70_[1]
  local finish = _let_70_[2]
  return vim.highlight.range(0, hl.ns, hl.group.greywash, start, finish)
end
local function highlight_range(hl_group, _72_, _74_, _76_)
  local _arg_73_ = _72_
  local startline = _arg_73_[1]
  local startcol = _arg_73_[2]
  local start = _arg_73_
  local _arg_75_ = _74_
  local endline = _arg_75_[1]
  local endcol = _arg_75_[2]
  local _end = _arg_75_
  local _arg_77_ = _76_
  local forced_motion = _arg_77_["forced-motion"]
  local inclusive_motion_3f = _arg_77_["inclusive-motion?"]
  local ctrl_v = replace_keycodes("<c-v>")
  local hl_range
  local function _78_(start0, _end0, end_inclusive_3f)
    return vim.highlight.range(0, hl.ns, hl_group, start0, _end0, nil, end_inclusive_3f)
  end
  hl_range = _78_
  local _79_ = forced_motion
  if (_79_ == ctrl_v) then
    local _let_80_ = {math.min(startcol, endcol), math.max(startcol, endcol)}
    local startcol0 = _let_80_[1]
    local endcol0 = _let_80_[2]
    for line = startline, endline do
      hl_range({line, startcol0}, {line, endcol0}, true)
    end
    return nil
  elseif (_79_ == "V") then
    return hl_range({startline, 0}, {endline, -1})
  elseif (_79_ == "v") then
    return hl_range(start, _end, not inclusive_motion_3f)
  else
    local _ = _79_
    return hl_range(start, _end, inclusive_motion_3f)
  end
end
local function echo_no_prev_search()
  return echo("no previous search")
end
local function echo_not_found(s)
  return echo(("not found: " .. s))
end
local function push_cursor_21(direction)
  local function _83_()
    local _82_ = direction
    if (_82_ == "fwd") then
      return "W"
    elseif (_82_ == "bwd") then
      return "bW"
    end
  end
  return vim.fn.search("\\_.", _83_())
end
local function cursor_before_eof_3f()
  return ((vim.fn.line(".") == vim.fn.line("$")) and (vim.fn.virtcol(".") == dec(vim.fn.virtcol("$"))))
end
local function force_matchparen_refresh()
  vim.cmd("silent! doautocmd matchparen CursorMoved")
  return vim.cmd("silent! doautocmd matchup_matchparen CursorMoved")
end
local function onscreen_match_positions(pattern, reverse_3f, _85_)
  local _arg_86_ = _85_
  local ft_search_3f = _arg_86_["ft-search?"]
  local limit = _arg_86_["limit"]
  local view = vim.fn.winsaveview()
  local cpo = vim.o.cpo
  local opts0
  if reverse_3f then
    opts0 = "b"
  else
    opts0 = ""
  end
  local stopline
  local function _88_()
    if reverse_3f then
      return "w0"
    else
      return "w$"
    end
  end
  stopline = vim.fn.line(_88_())
  local cleanup
  local function _89_()
    vim.fn.winrestview(view)
    vim.o.cpo = cpo
    return nil
  end
  cleanup = _89_
  local non_editable_width = dec(leftmost_editable_wincol())
  local col_in_edit_area = (vim.fn.wincol() - non_editable_width)
  local left_bound = (vim.fn.col(".") - dec(col_in_edit_area))
  local window_width = api.nvim_win_get_width(0)
  local right_bound = (left_bound + dec((window_width - non_editable_width - 1)))
  local function skip_to_fold_edge_21()
    local _90_
    local _91_
    if reverse_3f then
      _91_ = vim.fn.foldclosed
    else
      _91_ = vim.fn.foldclosedend
    end
    _90_ = _91_(vim.fn.line("."))
    if (_90_ == -1) then
      return "not-in-fold"
    elseif (nil ~= _90_) then
      local fold_edge = _90_
      vim.fn.cursor(fold_edge, 0)
      local function _93_()
        if reverse_3f then
          return 1
        else
          return vim.fn.col("$")
        end
      end
      vim.fn.cursor(0, _93_())
      return "moved-the-cursor"
    end
  end
  local function skip_to_next_in_window_pos_21()
    local _local_95_ = get_cursor_pos()
    local line = _local_95_[1]
    local col = _local_95_[2]
    local from_pos = _local_95_
    local _96_
    if (col < left_bound) then
      if reverse_3f then
        if (dec(line) >= stopline) then
          _96_ = {dec(line), right_bound}
        else
        _96_ = nil
        end
      else
        _96_ = {line, left_bound}
      end
    elseif (col > right_bound) then
      if reverse_3f then
        _96_ = {line, right_bound}
      else
        if (inc(line) <= stopline) then
          _96_ = {inc(line), left_bound}
        else
        _96_ = nil
        end
      end
    else
    _96_ = nil
    end
    if (nil ~= _96_) then
      local to_pos = _96_
      if (from_pos ~= to_pos) then
        vim.fn.cursor(to_pos)
        return "moved-the-cursor"
      end
    end
  end
  vim.o.cpo = cpo:gsub("c", "")
  local match_count = 0
  local function rec(match_at_curpos_3f)
    if (limit and (match_count >= limit)) then
      return cleanup()
    else
      local _104_
      local _105_
      if match_at_curpos_3f then
        _105_ = "c"
      else
        _105_ = ""
      end
      _104_ = vim.fn.searchpos(pattern, (opts0 .. _105_), stopline)
      if ((type(_104_) == "table") and ((_104_)[1] == 0) and true) then
        local _ = (_104_)[2]
        return cleanup()
      elseif ((type(_104_) == "table") and (nil ~= (_104_)[1]) and (nil ~= (_104_)[2])) then
        local line = (_104_)[1]
        local col = (_104_)[2]
        local pos = _104_
        if ft_search_3f then
          match_count = (match_count + 1)
          return pos
        else
          local _107_ = skip_to_fold_edge_21()
          if (_107_ == "moved-the-cursor") then
            return rec(false)
          elseif (_107_ == "not-in-fold") then
            if (vim.wo.wrap or (function(_108_,_109_,_110_) return (_108_ <= _109_) and (_109_ <= _110_) end)(left_bound,col,right_bound)) then
              match_count = (match_count + 1)
              return pos
            else
              local _111_ = skip_to_next_in_window_pos_21()
              if (_111_ == "moved-the-cursor") then
                return rec(true)
              else
                local _ = _111_
                return cleanup()
              end
            end
          end
        end
      end
    end
  end
  return rec
end
local function highlight_cursor(_3fpos)
  local _let_118_ = (_3fpos or get_cursor_pos())
  local line = _let_118_[1]
  local col = _let_118_[2]
  local pos = _let_118_
  local ch_at_curpos = (char_at_pos(pos, {}) or " ")
  return hl["set-extmark"](hl, dec(line), dec(col), {hl_mode = "combine", virt_text = {{ch_at_curpos, hl.group.cursor}}, virt_text_pos = "overlay"})
end
local function handle_interrupted_change_op_21()
  echo("")
  local curcol = vim.fn.col(".")
  local endcol = vim.fn.col("$")
  local _3fright
  if (not vim.o.insertmode and (curcol > 1) and (curcol < endcol)) then
    _3fright = "<RIGHT>"
  else
    _3fright = ""
  end
  return api.nvim_feedkeys(replace_keycodes(("<C-\\><C-G>" .. _3fright)), "n", true)
end
local function doau_when_exists(event)
  if vim.fn.exists(("#User#" .. event)) then
    return vim.cmd(("doautocmd <nomodeline> User " .. event))
  end
end
local function enter(mode)
  doau_when_exists("LightspeedEnter")
  local _121_ = mode
  if (_121_ == "sx") then
    return doau_when_exists("LightspeedSxEnter")
  elseif (_121_ == "ft") then
    return doau_when_exists("LightspeedFtEnter")
  end
end
local function get_input_and_clean_up()
  local ok_3f, res = getchar_as_str()
  hl:cleanup()
  if (ok_3f and (res ~= replace_keycodes("<esc>"))) then
    return res
  end
end
local function set_dot_repeat(cmd, _3fcount)
  if operator_pending_mode_3f() then
    local op = vim.v.operator
    if (op ~= "y") then
      local change
      if (op == "c") then
        change = replace_keycodes("<c-r>.<esc>")
      else
      change = nil
      end
      local seq = (op .. (_3fcount or "") .. cmd .. (change or ""))
      pcall(vim.fn["repeat#setreg"], seq, vim.v.register)
      return pcall(vim.fn["repeat#set"], seq, -1)
    end
  end
end
local function get_plug_key(kind, reverse_3f, x_or_t_3f, repeat_invoc)
  local _128_
  do
    local _127_ = repeat_invoc
    if (_127_ == "dot") then
      _128_ = "dotrepeat_"
    else
      local _ = _127_
      _128_ = ""
    end
  end
  local _133_
  do
    local _132_ = {kind, not not reverse_3f, not not x_or_t_3f}
    if ((type(_132_) == "table") and ((_132_)[1] == "ft") and ((_132_)[2] == false) and ((_132_)[3] == false)) then
      _133_ = "f"
    elseif ((type(_132_) == "table") and ((_132_)[1] == "ft") and ((_132_)[2] == true) and ((_132_)[3] == false)) then
      _133_ = "F"
    elseif ((type(_132_) == "table") and ((_132_)[1] == "ft") and ((_132_)[2] == false) and ((_132_)[3] == true)) then
      _133_ = "t"
    elseif ((type(_132_) == "table") and ((_132_)[1] == "ft") and ((_132_)[2] == true) and ((_132_)[3] == true)) then
      _133_ = "T"
    elseif ((type(_132_) == "table") and ((_132_)[1] == "sx") and ((_132_)[2] == false) and ((_132_)[3] == false)) then
      _133_ = "s"
    elseif ((type(_132_) == "table") and ((_132_)[1] == "sx") and ((_132_)[2] == false) and ((_132_)[3] == true)) then
      _133_ = "S"
    elseif ((type(_132_) == "table") and ((_132_)[1] == "sx") and ((_132_)[2] == true) and ((_132_)[3] == false)) then
      _133_ = "x"
    elseif ((type(_132_) == "table") and ((_132_)[1] == "sx") and ((_132_)[2] == true) and ((_132_)[3] == true)) then
      _133_ = "X"
    else
    _133_ = nil
    end
  end
  return ("<Plug>Lightspeed_" .. _128_ .. _133_)
end
local ft = {state = {cold = {["in"] = nil, ["reverse?"] = nil, ["t-mode?"] = nil}, dot = {["in"] = nil}, instant = {["in"] = nil, stack = nil}}}
ft.go = function(self, reverse_3f, t_mode_3f, repeat_invoc)
  local instant_repeat_3f = ((repeat_invoc == "instant") or (repeat_invoc == "reverted-instant"))
  local reverted_instant_repeat_3f = (repeat_invoc == "reverted-instant")
  local cold_repeat_3f = (repeat_invoc == "cold")
  local dot_repeat_3f = (repeat_invoc == "dot")
  local count
  if reverted_instant_repeat_3f then
    count = 0
  else
    count = vim.v.count1
  end
  local _let_144_ = map(replace_keycodes, {opts.instant_repeat_fwd_key, opts.instant_repeat_bwd_key})
  local repeat_key = _let_144_[1]
  local revert_key = _let_144_[2]
  local op_mode_3f = operator_pending_mode_3f()
  local dot_repeatable_op_3f = dot_repeatable_operation_3f()
  local cmd_for_dot_repeat = replace_keycodes(get_plug_key("ft", reverse_3f, t_mode_3f, "dot"))
  if not instant_repeat_3f then
    enter("ft")
  end
  if not repeat_invoc then
    echo("")
    highlight_cursor()
    vim.cmd("redraw")
  end
  local _147_
  if instant_repeat_3f then
    _147_ = self.state.instant["in"]
  elseif dot_repeat_3f then
    _147_ = self.state.dot["in"]
  elseif cold_repeat_3f then
    _147_ = self.state.cold["in"]
  else
    local _148_
    local function _149_()
      if change_operation_3f() then
        handle_interrupted_change_op_21()
      end
      do
      end
      doau_when_exists("LightspeedFtLeave")
      doau_when_exists("LightspeedLeave")
      return nil
    end
    _148_ = (get_input_and_clean_up() or _149_())
    if (_148_ == "\13") then
      local function _151_()
        if change_operation_3f() then
          handle_interrupted_change_op_21()
        end
        do
          echo_no_prev_search()
        end
        doau_when_exists("LightspeedFtLeave")
        doau_when_exists("LightspeedLeave")
        return nil
      end
      _147_ = (self.state.cold["in"] or _151_())
    elseif (nil ~= _148_) then
      local in0 = _148_
      _147_ = in0
    else
    _147_ = nil
    end
  end
  if (nil ~= _147_) then
    local in1 = _147_
    if not repeat_invoc then
      self.state.cold = {["in"] = in1, ["reverse?"] = reverse_3f, ["t-mode?"] = t_mode_3f}
    end
    local function _157_()
      if reverse_3f then
        return "nWb"
      else
        return "nW"
      end
    end
    local _local_156_ = vim.fn.searchpos("\\_.", _157_())
    local next_line = _local_156_[1]
    local next_col = _local_156_[2]
    local match_pos = nil
    local i = 0
    local function _160_()
      local pattern = ("\\V" .. in1:gsub("\\", "\\\\"))
      local limit
      if opts.limit_ft_matches then
        limit = (count + opts.limit_ft_matches)
      else
      limit = nil
      end
      return onscreen_match_positions(pattern, reverse_3f, {["ft-search?"] = true, limit = limit})
    end
    for _158_ in _160_() do
      local _each_161_ = _158_
      local line = _each_161_[1]
      local col = _each_161_[2]
      local pos = _each_161_
      if not (repeat_invoc and t_mode_3f and (i == 0) and (line == next_line) and (col == next_col)) then
        i = (i + 1)
        if (i <= count) then
          match_pos = pos
        else
          if not op_mode_3f then
            hl["add-hl"](hl, hl.group["one-char-match"], dec(line), dec(col), col)
          end
        end
      end
    end
    if ((count > 0) and not match_pos) then
      if change_operation_3f() then
        handle_interrupted_change_op_21()
      end
      do
        echo_not_found(in1)
      end
      doau_when_exists("LightspeedFtLeave")
      doau_when_exists("LightspeedLeave")
      return nil
    else
      if not reverted_instant_repeat_3f then
        local op_mode_3f_4_auto = operator_pending_mode_3f()
        local restore_virtualedit_autocmd_5_auto = ("autocmd CursorMoved,WinLeave,BufLeave" .. ",InsertEnter,CmdlineEnter,CmdwinEnter" .. " * ++once set virtualedit=" .. vim.o.virtualedit)
        if not instant_repeat_3f then
          vim.cmd("norm! m`")
        end
        vim.fn.cursor(match_pos)
        if t_mode_3f then
          local function _167_()
            if reverse_3f then
              return "fwd"
            else
              return "bwd"
            end
          end
          push_cursor_21(_167_())
        end
        if (op_mode_3f_4_auto and not reverse_3f and true) then
          local _169_ = string.sub(vim.fn.mode("t"), -1)
          if (_169_ == "v") then
            push_cursor_21("bwd")
          elseif (_169_ == "o") then
            if not cursor_before_eof_3f() then
              push_cursor_21("fwd")
            else
              vim.cmd("set virtualedit=onemore")
              vim.cmd("norm! l")
              vim.cmd(restore_virtualedit_autocmd_5_auto)
            end
          end
        end
        if not op_mode_3f_4_auto then
          force_matchparen_refresh()
        end
      end
      if op_mode_3f then
        do
          if dot_repeatable_op_3f then
            self.state.dot = {["in"] = in1}
            set_dot_repeat(cmd_for_dot_repeat, count)
          end
        end
        doau_when_exists("LightspeedFtLeave")
        doau_when_exists("LightspeedLeave")
        return nil
      else
        highlight_cursor()
        vim.cmd("redraw")
        local _176_
        local function _177_()
          do
          end
          doau_when_exists("LightspeedFtLeave")
          doau_when_exists("LightspeedLeave")
          return nil
        end
        _176_ = (get_input_and_clean_up() or _177_())
        if (nil ~= _176_) then
          local in2 = _176_
          local mode
          if (vim.fn.mode() == "n") then
            mode = "n"
          else
            mode = "x"
          end
          local repeat_3f = ((in2 == repeat_key) or string.match(vim.fn.maparg(in2, mode), get_plug_key("ft", false, t_mode_3f)))
          local revert_3f = ((in2 == revert_key) or string.match(vim.fn.maparg(in2, mode), get_plug_key("ft", true, t_mode_3f)))
          local do_instant_repeat_3f = (repeat_3f or revert_3f)
          if do_instant_repeat_3f then
            if not instant_repeat_3f then
              self.state.instant = {["in"] = in1, stack = {}}
            end
            if revert_3f then
              local _180_ = table.remove(self.state.instant.stack)
              if (nil ~= _180_) then
                local old_pos = _180_
                vim.fn.cursor(old_pos)
              end
            elseif repeat_3f then
              table.insert(self.state.instant.stack, get_cursor_pos())
            end
            local function _183_()
              if revert_3f then
                return "reverted-instant"
              else
                return "instant"
              end
            end
            return ft:go(reverse_3f, t_mode_3f, _183_())
          else
            do
              vim.fn.feedkeys(in2, "i")
            end
            doau_when_exists("LightspeedFtLeave")
            doau_when_exists("LightspeedLeave")
            return nil
          end
        end
      end
    end
  end
end
do
  local deprec_msg = {{"ligthspeed.nvim", "Question"}, {": You're trying to access deprecated fields in the lightspeed.ft table.\n"}, {"There are dedicated <Plug> keys available for native-like "}, {";", "Visual"}, {" and "}, {",", "Visual"}, {" functionality now.\n"}, {"See "}, {":h lightspeed-custom-mappings", "Visual"}, {"."}}
  local function _189_(t, k)
    if ((k == "instant-repeat?") or (k == "prev-t-like?")) then
      return api.nvim_echo(deprec_msg, true, {})
    end
  end
  setmetatable(ft, {__index = _189_})
end
local function get_labels()
  local function _191_()
    if opts.jump_to_first_match then
      return {"f", "s", "n", "u", "t", "/", "q", "F", "S", "G", "H", "L", "M", "N", "U", "R", "T", "Z", "?", "Q"}
    else
      return {"f", "j", "d", "k", "s", "l", "a", ";", "e", "i", "w", "o", "g", "h", "v", "n", "c", "m", "z", "."}
    end
  end
  return (opts.labels or _191_())
end
local function get_cycle_keys()
  local function _192_()
    if opts.jump_to_first_match then
      return "<tab>"
    else
      return "<space>"
    end
  end
  local function _193_()
    if opts.jump_to_first_match then
      return "<s-tab>"
    else
      return "<tab>"
    end
  end
  return map(replace_keycodes, {(opts.cycle_group_fwd_key or _192_()), (opts.cycle_group_bwd_key or _193_())})
end
local function highlight_unique_chars(reverse_3f, ignorecase)
  local unique_chars = {}
  local pattern = ".\\_."
  for pos in onscreen_match_positions(pattern, reverse_3f, {}) do
    local ch = char_at_pos(pos, {})
    local _195_
    do
      local _194_ = unique_chars[ch]
      if (_194_ == nil) then
        _195_ = pos
      else
        local _ = _194_
        _195_ = false
      end
    end
    unique_chars[ch] = _195_
  end
  for ch, pos in pairs(unique_chars) do
    local _199_ = pos
    if ((type(_199_) == "table") and (nil ~= (_199_)[1]) and (nil ~= (_199_)[2])) then
      local line = (_199_)[1]
      local col = (_199_)[2]
      hl["set-extmark"](hl, dec(line), dec(col), {virt_text = {{ch, hl.group["unique-ch"]}}, virt_text_pos = "overlay"})
    end
  end
  return nil
end
local function get_targets(ch1, reverse_3f)
  local targets = {}
  local prev_match = {}
  local added_prev_match_3f = nil
  local pattern = ("\\V\\C" .. ch1:gsub("\\", "\\\\") .. "\\_.")
  for _201_ in onscreen_match_positions(pattern, reverse_3f, {}) do
    local _each_202_ = _201_
    local line = _each_202_[1]
    local col = _each_202_[2]
    local pos = _each_202_
    local ch2 = (char_at_pos(pos, {["char-offset"] = 1}) or "\13")
    local overlaps_prev_match_3f
    local _203_
    if reverse_3f then
      _203_ = dec
    else
      _203_ = inc
    end
    overlaps_prev_match_3f = ((line == prev_match.line) and (col == _203_(prev_match.col)))
    local same_char_triplet_3f = (overlaps_prev_match_3f and (ch2 == prev_match.ch2))
    local overlaps_prev_target_3f = (overlaps_prev_match_3f and added_prev_match_3f)
    prev_match = {ch2 = ch2, col = col, line = line}
    if (same_char_triplet_3f and (added_prev_match_3f or opts.match_only_the_start_of_same_char_seqs)) then
      added_prev_match_3f = false
    else
      local target = {pair = {ch1, ch2}, pos = pos}
      if overlaps_prev_target_3f then
        local _205_
        if reverse_3f then
          _205_ = last(targets)
        else
          _205_ = target
        end
        _205_["overlapped?"] = true
      end
      table.insert(targets, target)
      added_prev_match_3f = true
    end
  end
  if next(targets) then
    return targets
  end
end
local function populate_sublists(targets)
  targets["sublists"] = {}
  for _, _210_ in ipairs(targets) do
    local _each_211_ = _210_
    local target = _each_211_
    local _each_212_ = _each_211_["pair"]
    local _0 = _each_212_[1]
    local ch2 = _each_212_[2]
    if not targets.sublists[ch2] then
      targets["sublists"][ch2] = {}
    end
    table.insert(targets.sublists[ch2], target)
  end
  return nil
end
local function set_labels(targets, jump_to_first_3f)
  local labels = get_labels()
  for _, sublist in pairs(targets.sublists) do
    if (#sublist > 1) then
      for i, target in ipairs(sublist) do
        local _214_
        if not (jump_to_first_3f and (i == 1)) then
          local _215_
          local _217_
          if jump_to_first_3f then
            _217_ = dec(i)
          else
            _217_ = i
          end
          _215_ = (_217_ % #labels)
          if (_215_ == 0) then
            _214_ = last(labels)
          elseif (nil ~= _215_) then
            local n = _215_
            _214_ = labels[n]
          else
          _214_ = nil
          end
        else
        _214_ = nil
        end
        target["label"] = _214_
      end
    end
  end
  return nil
end
local function set_label_states_for_sublist(target_list, _224_)
  local _arg_225_ = _224_
  local group_offset = _arg_225_["group-offset"]
  local jump_to_first_3f = _arg_225_["jump-to-first?"]
  local labels = get_labels()
  local _7clabels_7c = #labels
  local base
  if jump_to_first_3f then
    base = 2
  else
    base = 1
  end
  local offset = (group_offset * _7clabels_7c)
  local primary_start = (base + offset)
  local primary_end = (primary_start + dec(_7clabels_7c))
  local secondary_end = (primary_end + _7clabels_7c)
  for i, target in ipairs(target_list) do
    local _227_
    if target.label then
      if ((i < primary_start) or (i > secondary_end)) then
        _227_ = "inactive"
      elseif (i <= primary_end) then
        _227_ = "active-primary"
      else
        _227_ = "active-secondary"
      end
    else
    _227_ = nil
    end
    target["label-state"] = _227_
  end
  return nil
end
local function set_label_states(targets, jump_to_first_3f)
  for _, sublist in pairs(targets.sublists) do
    set_label_states_for_sublist(sublist, {["group-offset"] = 0, ["jump-to-first?"] = jump_to_first_3f})
  end
  return nil
end
local function set_shortcuts_and_populate_shortcuts_map(targets)
  targets["shortcuts"] = {}
  local potential_2nd_inputs
  do
    local tbl_9_auto = {}
    for ch2, _ in pairs(targets.sublists) do
      local _230_, _231_ = ch2, true
      if ((nil ~= _230_) and (nil ~= _231_)) then
        local k_10_auto = _230_
        local v_11_auto = _231_
        tbl_9_auto[k_10_auto] = v_11_auto
      end
    end
    potential_2nd_inputs = tbl_9_auto
  end
  local labels_used_up_as_shortcut = {}
  for _, _233_ in ipairs(targets) do
    local _each_234_ = _233_
    local target = _each_234_
    local label = _each_234_["label"]
    local label_state = _each_234_["label-state"]
    if (label_state == "active-primary") then
      if not ((potential_2nd_inputs)[label] or labels_used_up_as_shortcut[label]) then
        target["shortcut?"] = true
        targets.shortcuts[label] = target
        labels_used_up_as_shortcut[label] = true
      end
    end
  end
  return nil
end
local function set_beacon(_237_, repeat_3f)
  local _arg_238_ = _237_
  local target = _arg_238_
  local label = _arg_238_["label"]
  local label_state = _arg_238_["label-state"]
  local overlapped_3f = _arg_238_["overlapped?"]
  local _arg_239_ = _arg_238_["pair"]
  local ch1 = _arg_239_[1]
  local ch2 = _arg_239_[2]
  local _arg_240_ = _arg_238_["pos"]
  local _ = _arg_240_[1]
  local col = _arg_240_[2]
  local shortcut_3f = _arg_238_["shortcut?"]
  local function _242_(_241)
    return (opts.substitute_chars[_241] or _241)
  end
  local _let_241_ = map(_242_, {ch1, ch2})
  local ch10 = _let_241_[1]
  local ch20 = _let_241_[2]
  local function _244_(_241)
    return (not repeat_3f and _241)
  end
  local _let_243_ = map(_244_, {overlapped_3f, shortcut_3f})
  local overlapped_3f0 = _let_243_[1]
  local shortcut_3f0 = _let_243_[2]
  local unlabeled_hl = hl.group["unlabeled-match"]
  local function _248_()
    if shortcut_3f0 then
      return {hl.group.shortcut, hl.group["shortcut-overlapped"]}
    else
      local _246_ = label_state
      if (_246_ == "active-secondary") then
        return {hl.group["label-distant"], hl.group["label-distant-overlapped"]}
      elseif (_246_ == "active-primary") then
        return {hl.group.label, hl.group["label-overlapped"]}
      else
        local _0 = _246_
        return {nil, nil}
      end
    end
  end
  local _let_245_ = _248_()
  local label_hl = _let_245_[1]
  local overlapped_label_hl = _let_245_[2]
  local _249_
  if not label then
    if overlapped_3f0 then
      _249_ = {inc(col), {ch20, unlabeled_hl}}
    else
      _249_ = {col, {ch10, unlabeled_hl}, {ch20, unlabeled_hl}}
    end
  elseif (label_state == "inactive") then
    _249_ = nil
  elseif overlapped_3f0 then
    _249_ = {inc(col), {label, overlapped_label_hl}}
  elseif repeat_3f then
    _249_ = {inc(col), {label, label_hl}}
  else
    _249_ = {col, {ch20, hl.group["masked-ch"]}, {label, label_hl}}
  end
  target["beacon"] = _249_
  return nil
end
local function set_beacons(target_list, _252_)
  local _arg_253_ = _252_
  local repeat_3f = _arg_253_["repeat?"]
  for _, target in ipairs(target_list) do
    set_beacon(target, repeat_3f)
  end
  return nil
end
local function light_up_beacons(target_list)
  for _, _254_ in ipairs(target_list) do
    local _each_255_ = _254_
    local beacon = _each_255_["beacon"]
    local _each_256_ = _each_255_["pos"]
    local line = _each_256_[1]
    local _0 = _each_256_[2]
    local _257_ = beacon
    if ((type(_257_) == "table") and (nil ~= (_257_)[1]) and (nil ~= (_257_)[2]) and true) then
      local startcol = (_257_)[1]
      local chunk1 = (_257_)[2]
      local _3fchunk2 = (_257_)[3]
      hl["set-extmark"](hl, dec(line), dec(startcol), {virt_text = {chunk1, _3fchunk2}, virt_text_pos = "overlay"})
    end
  end
  return nil
end
local function get_target_with_active_primary_label(target_list, input)
  local res = nil
  for _, _259_ in ipairs(target_list) do
    local _each_260_ = _259_
    local target = _each_260_
    local label = _each_260_["label"]
    local label_state = _each_260_["label-state"]
    if res then break end
    if ((label == input) and (label_state == "active-primary")) then
      res = target
    end
  end
  return res
end
local function ignore_char_until_timeout(char_to_ignore)
  local start = os.clock()
  local timeout_secs = (opts.jump_on_partial_input_safety_timeout / 1000)
  local ok_3f, input = getchar_as_str()
  if not ((input == char_to_ignore) and (os.clock() < (start + timeout_secs))) then
    if ok_3f then
      return vim.fn.feedkeys(input, "i")
    end
  end
end
local sx = {state = {cold = {["reverse?"] = nil, ["x-mode?"] = nil, in1 = nil, in2 = nil}, dot = {["x-mode?"] = nil, in1 = nil, in2 = nil, in3 = nil}}}
sx.go = function(self, reverse_3f, invoked_in_x_mode_3f, repeat_invoc)
  local dot_repeat_3f = (repeat_invoc == "dot")
  local cold_repeat_3f = (repeat_invoc == "cold")
  local op_mode_3f = operator_pending_mode_3f()
  local change_op_3f = change_operation_3f()
  local delete_op_3f = delete_operation_3f()
  local dot_repeatable_op_3f = dot_repeatable_operation_3f()
  local x_mode_prefix_key = replace_keycodes((opts.x_mode_prefix_key or opts.full_inclusive_prefix_key))
  local _let_264_ = get_cycle_keys()
  local cycle_fwd_key = _let_264_[1]
  local cycle_bwd_key = _let_264_[2]
  local labels = get_labels()
  local jump_to_first_3f = (opts.jump_to_first_match and not op_mode_3f)
  local cmd_for_dot_repeat = replace_keycodes(get_plug_key("sx", reverse_3f, invoked_in_x_mode_3f, "dot"))
  local x_mode_3f = invoked_in_x_mode_3f
  local enter_repeat_3f = nil
  local new_search_3f = nil
  local function get_first_input()
    if dot_repeat_3f then
      x_mode_3f = self.state.dot["x-mode?"]
      return self.state.dot.in1
    elseif cold_repeat_3f then
      return self.state.cold.in1
    else
      local _265_
      local function _266_()
        if change_operation_3f() then
          handle_interrupted_change_op_21()
        end
        do
        end
        doau_when_exists("LightspeedSxLeave")
        doau_when_exists("LightspeedLeave")
        return nil
      end
      _265_ = (get_input_and_clean_up() or _266_())
      if (nil ~= _265_) then
        local in0 = _265_
        do
          local _268_ = in0
          if (_268_ == "\13") then
            enter_repeat_3f = true
          elseif (_268_ == x_mode_prefix_key) then
            x_mode_3f = true
          end
        end
        local res = in0
        if (x_mode_3f and not invoked_in_x_mode_3f) then
          local _270_
          local function _271_()
            if change_operation_3f() then
              handle_interrupted_change_op_21()
            end
            do
            end
            doau_when_exists("LightspeedSxLeave")
            doau_when_exists("LightspeedLeave")
            return nil
          end
          _270_ = (get_input_and_clean_up() or _271_())
          if (_270_ == "\13") then
            enter_repeat_3f = true
          elseif (nil ~= _270_) then
            local in0_2a = _270_
            res = in0_2a
          end
        end
        new_search_3f = not (repeat_invoc or enter_repeat_3f)
        if enter_repeat_3f then
          local function _275_()
            if change_operation_3f() then
              handle_interrupted_change_op_21()
            end
            do
              echo_no_prev_search()
            end
            doau_when_exists("LightspeedSxLeave")
            doau_when_exists("LightspeedLeave")
            return nil
          end
          return (self.state.cold.in1 or _275_())
        else
          return res
        end
      end
    end
  end
  local function save_state_for_repeat_2a(in1)
    local function _282_(_280_)
      local _arg_281_ = _280_
      local cold = _arg_281_["cold"]
      local dot = _arg_281_["dot"]
      if new_search_3f then
        if cold then
          local _283_ = cold
          _283_["in1"] = in1
          _283_["x-mode?"] = x_mode_3f
          _283_["reverse?"] = reverse_3f
          self.state.cold = _283_
        end
        if (dot_repeatable_op_3f and dot) then
          do
            local _285_ = dot
            _285_["in1"] = in1
            _285_["x-mode?"] = x_mode_3f
            self.state.dot = _285_
          end
          return nil
        end
      end
    end
    return _282_
  end
  local jump_wrapped_21
  do
    local first_jump_3f = true
    local function _288_(target)
      do
        local op_mode_3f_4_auto = operator_pending_mode_3f()
        local restore_virtualedit_autocmd_5_auto = ("autocmd CursorMoved,WinLeave,BufLeave" .. ",InsertEnter,CmdlineEnter,CmdwinEnter" .. " * ++once set virtualedit=" .. vim.o.virtualedit)
        if first_jump_3f then
          vim.cmd("norm! m`")
        end
        vim.fn.cursor(target)
        if x_mode_3f then
          push_cursor_21("fwd")
          if reverse_3f then
            push_cursor_21("fwd")
          end
        end
        if (op_mode_3f_4_auto and not reverse_3f and (x_mode_3f and not reverse_3f)) then
          local _292_ = string.sub(vim.fn.mode("t"), -1)
          if (_292_ == "v") then
            push_cursor_21("bwd")
          elseif (_292_ == "o") then
            if not cursor_before_eof_3f() then
              push_cursor_21("fwd")
            else
              vim.cmd("set virtualedit=onemore")
              vim.cmd("norm! l")
              vim.cmd(restore_virtualedit_autocmd_5_auto)
            end
          end
        end
        if not op_mode_3f_4_auto then
          force_matchparen_refresh()
        end
      end
      if dot_repeatable_op_3f then
        set_dot_repeat(cmd_for_dot_repeat)
      end
      first_jump_3f = false
      return nil
    end
    jump_wrapped_21 = _288_
  end
  local function jump_and_ignore_ch2_until_timeout_21(_298_, ch2)
    local _arg_299_ = _298_
    local target_line = _arg_299_[1]
    local target_col = _arg_299_[2]
    local from_pos = map(dec, get_cursor_pos())
    jump_wrapped_21({target_line, target_col})
    if new_search_3f then
      local ctrl_v = replace_keycodes("<c-v>")
      local forward_x_3f = (x_mode_3f and not reverse_3f)
      local backward_x_3f = (x_mode_3f and reverse_3f)
      local forced_motion = string.sub(vim.fn.mode("t"), -1)
      local to_col
      if backward_x_3f then
        to_col = inc(inc(target_col))
      elseif forward_x_3f then
        to_col = inc(target_col)
      else
        to_col = target_col
      end
      local to_pos = map(dec, {target_line, to_col})
      local function _302_()
        if reverse_3f then
          return to_pos
        else
          return from_pos
        end
      end
      local _let_301_ = _302_()
      local startline = _let_301_[1]
      local startcol = _let_301_[2]
      local start = _let_301_
      local function _304_()
        if reverse_3f then
          return from_pos
        else
          return to_pos
        end
      end
      local _let_303_ = _304_()
      local _ = _let_303_[1]
      local endcol = _let_303_[2]
      local _end = _let_303_
      local _3fhighlight_cursor_at
      if op_mode_3f then
        local function _305_()
          if (forced_motion == ctrl_v) then
            return {startline, math.min(startcol, endcol)}
          elseif not reverse_3f then
            return from_pos
          end
        end
        _3fhighlight_cursor_at = map(inc, _305_())
      else
      _3fhighlight_cursor_at = nil
      end
      if not change_op_3f then
        highlight_cursor(_3fhighlight_cursor_at)
      end
      if op_mode_3f then
        highlight_range(hl.group["pending-op-area"], start, _end, {["forced-motion"] = forced_motion, ["inclusive-motion?"] = forward_x_3f})
      end
      vim.cmd("redraw")
      ignore_char_until_timeout(ch2)
      if change_op_3f then
        echo("")
      end
      return hl:cleanup()
    end
  end
  local function handle_cold_repeating_X(sublist)
    local _let_311_ = sublist
    local _let_312_ = _let_311_[1]
    local first = _let_312_
    local _let_313_ = _let_312_["pos"]
    local line = _let_313_[1]
    local col = _let_313_[2]
    local rest = {(table.unpack or unpack)(_let_311_, 2)}
    local cursor_right_before_first_target_3f
    do
      local _let_314_ = vim.fn.searchpos("\\_.", "nWb")
      local line_2a = _let_314_[1]
      local col_2a = _let_314_[2]
      do local _ = (line == line_2a) end
      cursor_right_before_first_target_3f = (col == dec(col_2a))
    end
    local skip_one_target_3f = (cold_repeat_3f and x_mode_3f and reverse_3f and cursor_right_before_first_target_3f)
    if skip_one_target_3f then
      local _let_315_ = rest
      local first_rest = _let_315_[1]
      local rest_rest = {(table.unpack or unpack)(_let_315_, 2)}
      return {first_rest, rest_rest, rest}
    else
      return {first, rest, sublist}
    end
  end
  local function after_cold_repeat(target_list)
    if not op_mode_3f then
      do
        if (opts.grey_out_search_area and not cold_repeat_3f) then
          grey_out_search_area(reverse_3f)
        end
        do
          for _, _318_ in ipairs(target_list) do
            local _each_319_ = _318_
            local _each_320_ = _each_319_["pos"]
            local line = _each_320_[1]
            local col = _each_320_[2]
            hl["add-hl"](hl, hl.group["one-char-match"], dec(line), dec(col), inc(col))
          end
        end
        highlight_cursor()
        vim.cmd("redraw")
      end
      do
        vim.fn.feedkeys((get_input_and_clean_up() or ""), "i")
      end
      doau_when_exists("LightspeedSxLeave")
      doau_when_exists("LightspeedLeave")
      return nil
    end
  end
  local function select_match_group(target_list, enter_repeat_3f0)
    local res = nil
    local group_offset = 0
    local loop_3f = true
    while loop_3f do
      local _322_
      local function _323_()
        if dot_repeat_3f then
          return self.state.dot.in3
        end
      end
      local function _324_()
        loop_3f = false
        res = nil
        return nil
      end
      _322_ = (_323_() or get_input_and_clean_up() or _324_())
      if (nil ~= _322_) then
        local input = _322_
        if ((input == cycle_fwd_key) or (input == cycle_bwd_key)) then
          local max_offset = math.floor((#target_list / #labels))
          local _326_
          do
            local _325_ = input
            if (_325_ == cycle_fwd_key) then
              _326_ = inc
            else
              local _ = _325_
              _326_ = dec
            end
          end
          group_offset = clamp(_326_(group_offset), 0, max_offset)
          set_label_states_for_sublist(target_list, {["group-offset"] = group_offset, ["jump-to-first?"] = false})
          set_beacons(target_list, {["repeat?"] = enter_repeat_3f0})
          if (opts.grey_out_search_area and not cold_repeat_3f) then
            grey_out_search_area(reverse_3f)
          end
          do
            light_up_beacons(target_list)
          end
          highlight_cursor()
          vim.cmd("redraw")
        else
          loop_3f = false
          res = {input, group_offset}
        end
      end
    end
    return res
  end
  enter("sx")
  if not repeat_invoc then
    echo("")
    if (opts.grey_out_search_area and not cold_repeat_3f) then
      grey_out_search_area(reverse_3f)
    end
    do
      if opts.highlight_unique_chars then
        highlight_unique_chars(reverse_3f)
      end
    end
    highlight_cursor()
    vim.cmd("redraw")
  end
  local _336_ = get_first_input()
  if (nil ~= _336_) then
    local in1 = _336_
    local save_state_for_repeat = save_state_for_repeat_2a(in1)
    local prev_in2
    if (cold_repeat_3f or enter_repeat_3f) then
      prev_in2 = self.state.cold.in2
    elseif dot_repeat_3f then
      prev_in2 = self.state.dot.in2
    else
    prev_in2 = nil
    end
    local _338_
    local function _339_()
      if change_operation_3f() then
        handle_interrupted_change_op_21()
      end
      do
        echo_not_found((in1 .. (prev_in2 or "")))
      end
      doau_when_exists("LightspeedSxLeave")
      doau_when_exists("LightspeedLeave")
      return nil
    end
    _338_ = (get_targets(in1, reverse_3f) or _339_())
    if ((type(_338_) == "table") and ((type((_338_)[1]) == "table") and ((type(((_338_)[1]).pair) == "table") and true and (nil ~= (((_338_)[1]).pair)[2])) and (nil ~= ((_338_)[1]).pos)) and ((_338_)[2] == nil)) then
      local _ = (((_338_)[1]).pair)[1]
      local ch2 = (((_338_)[1]).pair)[2]
      local pos = ((_338_)[1]).pos
      if (new_search_3f or (ch2 == prev_in2)) then
        do
          save_state_for_repeat({cold = {in2 = ch2}, dot = {in2 = ch2, in3 = labels[1]}})
          jump_and_ignore_ch2_until_timeout_21(pos, ch2)
        end
        doau_when_exists("LightspeedSxLeave")
        doau_when_exists("LightspeedLeave")
        return nil
      else
        if change_operation_3f() then
          handle_interrupted_change_op_21()
        end
        do
          echo_not_found((in1 .. prev_in2))
        end
        doau_when_exists("LightspeedSxLeave")
        doau_when_exists("LightspeedLeave")
        return nil
      end
    elseif (nil ~= _338_) then
      local targets = _338_
      do
        local _343_ = targets
        populate_sublists(_343_)
        set_labels(_343_, jump_to_first_3f)
        set_label_states(_343_, jump_to_first_3f)
      end
      if new_search_3f then
        do
          local _344_ = targets
          set_shortcuts_and_populate_shortcuts_map(_344_)
          set_beacons(_344_, {["repeat?"] = false})
        end
        if (opts.grey_out_search_area and not cold_repeat_3f) then
          grey_out_search_area(reverse_3f)
        end
        do
          light_up_beacons(targets)
        end
        highlight_cursor()
        vim.cmd("redraw")
      end
      local _347_
      local function _348_()
        if change_operation_3f() then
          handle_interrupted_change_op_21()
        end
        do
        end
        doau_when_exists("LightspeedSxLeave")
        doau_when_exists("LightspeedLeave")
        return nil
      end
      _347_ = (prev_in2 or get_input_and_clean_up() or _348_())
      if (nil ~= _347_) then
        local in2 = _347_
        local _350_
        if new_search_3f then
          _350_ = targets.shortcuts[in2]
        else
        _350_ = nil
        end
        if ((type(_350_) == "table") and ((type((_350_).pair) == "table") and true and (nil ~= ((_350_).pair)[2])) and (nil ~= (_350_).pos)) then
          local _ = ((_350_).pair)[1]
          local ch2 = ((_350_).pair)[2]
          local pos = (_350_).pos
          do
            save_state_for_repeat({cold = {in2 = ch2}, dot = {in2 = ch2, in3 = in2}})
            jump_wrapped_21(pos)
          end
          doau_when_exists("LightspeedSxLeave")
          doau_when_exists("LightspeedLeave")
          return nil
        else
          local _ = _350_
          save_state_for_repeat({cold = {in2 = in2}, dot = {in2 = in2, in3 = labels[1]}})
          local _352_
          local function _353_()
            if change_operation_3f() then
              handle_interrupted_change_op_21()
            end
            do
              echo_not_found((in1 .. in2))
            end
            doau_when_exists("LightspeedSxLeave")
            doau_when_exists("LightspeedLeave")
            return nil
          end
          _352_ = (targets.sublists[in2] or _353_())
          if (nil ~= _352_) then
            local sublist = _352_
            local _let_355_ = handle_cold_repeating_X(sublist)
            local first = _let_355_[1]
            local rest = _let_355_[2]
            local sublist0 = _let_355_[3]
            local target_list
            if jump_to_first_3f then
              target_list = rest
            else
              target_list = sublist0
            end
            if (first and (empty_3f(rest) or cold_repeat_3f or jump_to_first_3f)) then
              jump_wrapped_21(first.pos)
            end
            if empty_3f(rest) then
              do
              end
              doau_when_exists("LightspeedSxLeave")
              doau_when_exists("LightspeedLeave")
              return nil
            elseif cold_repeat_3f then
              return after_cold_repeat(rest)
            else
              if not (dot_repeat_3f and self.state.dot.in3) then
                set_beacons(target_list, {["repeat?"] = enter_repeat_3f})
                if (opts.grey_out_search_area and not cold_repeat_3f) then
                  grey_out_search_area(reverse_3f)
                end
                do
                  light_up_beacons(target_list)
                end
                highlight_cursor()
                vim.cmd("redraw")
              end
              local _360_
              local function _361_()
                if change_operation_3f() then
                  handle_interrupted_change_op_21()
                end
                do
                end
                doau_when_exists("LightspeedSxLeave")
                doau_when_exists("LightspeedLeave")
                return nil
              end
              _360_ = (select_match_group(target_list, enter_repeat_3f) or _361_())
              if ((type(_360_) == "table") and (nil ~= (_360_)[1]) and (nil ~= (_360_)[2])) then
                local in3 = (_360_)[1]
                local group_offset = (_360_)[2]
                if (dot_repeatable_op_3f and not dot_repeat_3f) then
                  if (group_offset > 0) then
                    self.state.dot.in3 = nil
                  else
                    self.state.dot.in3 = in3
                  end
                end
                local _365_ = get_target_with_active_primary_label(target_list, in3)
                if ((type(_365_) == "table") and (nil ~= (_365_).pos)) then
                  local pos = (_365_).pos
                  do
                    jump_wrapped_21(pos)
                  end
                  doau_when_exists("LightspeedSxLeave")
                  doau_when_exists("LightspeedLeave")
                  return nil
                else
                  local _0 = _365_
                  if jump_to_first_3f then
                    do
                      vim.fn.feedkeys(in3, "i")
                    end
                    doau_when_exists("LightspeedSxLeave")
                    doau_when_exists("LightspeedLeave")
                    return nil
                  else
                    if change_operation_3f() then
                      handle_interrupted_change_op_21()
                    end
                    do
                    end
                    doau_when_exists("LightspeedSxLeave")
                    doau_when_exists("LightspeedLeave")
                    return nil
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
local temporary_editor_opts = {["vim.wo.conceallevel"] = 0, ["vim.wo.scrolloff"] = 0}
local saved_editor_opts = {}
local function save_editor_opts()
  for opt, _ in pairs(temporary_editor_opts) do
    local _let_376_ = vim.split(opt, ".", true)
    local _0 = _let_376_[1]
    local scope = _let_376_[2]
    local name = _let_376_[3]
    local _377_
    if (opt == "vim.wo.scrolloff") then
      _377_ = api.nvim_eval("&l:scrolloff")
    else
      _377_ = _G.vim[scope][name]
    end
    saved_editor_opts[opt] = _377_
  end
  return nil
end
local function set_editor_opts(opts0)
  for opt, val in pairs(opts0) do
    local _let_379_ = vim.split(opt, ".", true)
    local _ = _let_379_[1]
    local scope = _let_379_[2]
    local name = _let_379_[3]
    _G.vim[scope][name] = val
  end
  return nil
end
local function set_temporary_editor_opts()
  return set_editor_opts(temporary_editor_opts)
end
local function restore_editor_opts()
  return set_editor_opts(saved_editor_opts)
end
local function set_plug_keys()
  local plug_keys = {{"<Plug>Lightspeed_s", "sx:go(false)"}, {"<Plug>Lightspeed_S", "sx:go(true)"}, {"<Plug>Lightspeed_x", "sx:go(false, true)"}, {"<Plug>Lightspeed_X", "sx:go(true, true)"}, {"<Plug>Lightspeed_f", "ft:go(false)"}, {"<Plug>Lightspeed_F", "ft:go(true)"}, {"<Plug>Lightspeed_t", "ft:go(false, true)"}, {"<Plug>Lightspeed_T", "ft:go(true, true)"}, {"<Plug>Lightspeed_;_sx", "sx:go(require'lightspeed'.sx.state.cold['reverse?'], require'lightspeed'.sx.state.cold['x-mode?'], 'cold')"}, {"<Plug>Lightspeed_,_sx", "sx:go(not require'lightspeed'.sx.state.cold['reverse?'], require'lightspeed'.sx.state.cold['x-mode?'], 'cold')"}, {"<Plug>Lightspeed_;_ft", "ft:go(require'lightspeed'.ft.state.cold['reverse?'], require'lightspeed'.ft.state.cold['t-mode?'], 'cold')"}, {"<Plug>Lightspeed_,_ft", "ft:go(not require'lightspeed'.ft.state.cold['reverse?'], require'lightspeed'.ft.state.cold['t-mode?'], 'cold')"}, {"<Plug>Lightspeed_;", "ft:go(require'lightspeed'.ft.state.cold['reverse?'], require'lightspeed'.ft.state.cold['t-mode?'], 'cold')"}, {"<Plug>Lightspeed_,", "ft:go(not require'lightspeed'.ft.state.cold['reverse?'], require'lightspeed'.ft.state.cold['t-mode?'], 'cold')"}}
  for _, _380_ in ipairs(plug_keys) do
    local _each_381_ = _380_
    local lhs = _each_381_[1]
    local rhs_call = _each_381_[2]
    for _0, mode in ipairs({"n", "x", "o"}) do
      api.nvim_set_keymap(mode, lhs, ("<cmd>lua require'lightspeed'." .. rhs_call .. "<cr>"), {noremap = true, silent = true})
    end
  end
  for _, _382_ in ipairs({{"<Plug>Lightspeed_dotrepeat_s", "sx:go(false, false, 'dot')"}, {"<Plug>Lightspeed_dotrepeat_S", "sx:go(true, false, 'dot')"}, {"<Plug>Lightspeed_dotrepeat_x", "sx:go(false, true, 'dot')"}, {"<Plug>Lightspeed_dotrepeat_X", "sx:go(true, true, 'dot')"}, {"<Plug>Lightspeed_dotrepeat_f", "ft:go(false, false, 'dot')"}, {"<Plug>Lightspeed_dotrepeat_F", "ft:go(true, false, 'dot')"}, {"<Plug>Lightspeed_dotrepeat_t", "ft:go(false, true, 'dot')"}, {"<Plug>Lightspeed_dotrepeat_T", "ft:go(true, true, 'dot')"}}) do
    local _each_383_ = _382_
    local lhs = _each_383_[1]
    local rhs_call = _each_383_[2]
    api.nvim_set_keymap("o", lhs, ("<cmd>lua require'lightspeed'." .. rhs_call .. "<cr>"), {noremap = true, silent = true})
  end
  return nil
end
local function set_default_keymaps()
  local default_keymaps = {{"n", "s", "<Plug>Lightspeed_s"}, {"n", "S", "<Plug>Lightspeed_S"}, {"x", "s", "<Plug>Lightspeed_s"}, {"x", "S", "<Plug>Lightspeed_S"}, {"o", "z", "<Plug>Lightspeed_s"}, {"o", "Z", "<Plug>Lightspeed_S"}, {"o", "x", "<Plug>Lightspeed_x"}, {"o", "X", "<Plug>Lightspeed_X"}, {"n", "f", "<Plug>Lightspeed_f"}, {"n", "F", "<Plug>Lightspeed_F"}, {"x", "f", "<Plug>Lightspeed_f"}, {"x", "F", "<Plug>Lightspeed_F"}, {"o", "f", "<Plug>Lightspeed_f"}, {"o", "F", "<Plug>Lightspeed_F"}, {"n", "t", "<Plug>Lightspeed_t"}, {"n", "T", "<Plug>Lightspeed_T"}, {"x", "t", "<Plug>Lightspeed_t"}, {"x", "T", "<Plug>Lightspeed_T"}, {"o", "t", "<Plug>Lightspeed_t"}, {"o", "T", "<Plug>Lightspeed_T"}}
  for _, _384_ in ipairs(default_keymaps) do
    local _each_385_ = _384_
    local mode = _each_385_[1]
    local lhs = _each_385_[2]
    local rhs = _each_385_[3]
    if ((vim.fn.mapcheck(lhs, mode) == "") and (vim.fn.hasmapto(rhs, mode) == 0)) then
      api.nvim_set_keymap(mode, lhs, rhs, {silent = true})
    end
  end
  return nil
end
init_highlight()
set_plug_keys()
set_default_keymaps()
vim.cmd("augroup lightspeed_reinit_highlight\n   autocmd!\n   autocmd ColorScheme * lua require'lightspeed'.init_highlight()\n   augroup end")
vim.cmd("augroup lightspeed_editor_opts\n   autocmd!\n   autocmd User LightspeedEnter lua require'lightspeed'.save_editor_opts(); require'lightspeed'.set_temporary_editor_opts()\n   autocmd User LightspeedLeave lua require'lightspeed'.restore_editor_opts()\n   augroup end")
return {ft = ft, init_highlight = init_highlight, opts = opts, restore_editor_opts = restore_editor_opts, save_editor_opts = save_editor_opts, set_default_keymaps = set_default_keymaps, set_temporary_editor_opts = set_temporary_editor_opts, setup = setup, sx = sx}
