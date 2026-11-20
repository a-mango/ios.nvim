local fails = 0
local function check(name, cond)
  print((cond and "PASS " or "FAIL ") .. name)
  if not cond then fails = fails + 1 end
end
local function find(pat)
  for l = 1, vim.fn.line("$") do
    local c = vim.fn.getline(l):find(pat)
    if c then return l, c end
  end
end
local function grp(pat, off)
  local l, c = find(pat)
  return vim.fn.synIDattr(vim.fn.synID(l, c + (off or 0), 1), "name")
end

vim.cmd("edit test/fixtures/sample.ios")
check("filetype ios", vim.bo.filetype == "ios")
check("commentstring", vim.bo.commentstring == "! %s")
check("iskeyword has -", vim.bo.iskeyword:find("-", 1, true) ~= nil)
check("comment", grp("^!", 0) == "iosComment")
check("section interface", grp("^interface Gig", 0) == "iosSection")
check("section ip access-list", grp("^ip access%-list", 3) == "iosSection")
check("section ip dhcp pool", grp("^ip dhcp pool", 3) == "iosSection")
check("ip keyword inside a block", grp(" ip address 10", 1) == "iosKeyword")
check("ipv6 keyword inside a block", grp(" ipv6 address", 1) == "iosKeyword")
check("interface name", grp("GigabitEthernet0/0/1", 0) == "iosInterface")
check("short iface Gi1/0/1", grp("Gi1/0/1", 0) == "iosInterface")
check("no", grp(" no shutdown", 1) == "iosNo")
check("shutdown", grp("no shutdown", 3) == "iosShutdown")
check("permit", grp(" permit tcp", 1) == "iosPermit")
check("deny", grp(" deny ip", 1) == "iosDeny")
check("description keyword", grp("description permit", 1) == "iosDescKw")
check("description text not keyword", grp("description permit uplink", 13) == "iosText")
check("remark text not keyword", grp("remark deny", 8) == "iosText")
check("ipv4", grp("ip address 10.0.0.1", 11) == "iosIPv4")
check("mask", grp("255.255.255.0", 0) == "iosIPv4Mask")
check("ipv6", grp("2001:db8::1/64", 0) == "iosIPv6")
check("mac", grp("aaaa.bbbb.cccc", 0) == "iosMac")
check("secret", grp("secret 5 %$1", 9) == "iosSecret")
check("password 7", grp("password 7 0822", 11) == "iosSecret")
-- banner body single region, keywords inside not highlighted
check("banner body", grp("interface permit deny", 0) == "iosBanner")
check("banner deny", grp("interface permit deny", 17) == "iosBanner")
check("banner text", grp("This is a banner", 0) == "iosBanner")
check("after banner normal", grp("^interface GigabitEthernet0/0/1", 0) == "iosSection")

-- completion
local complete = require("ios.complete")
vim.cmd("normal! G")
local l = find(" description permit uplink")
vim.api.nvim_win_set_cursor(0, { l, 1 })
local c = complete._candidates_for(l)
check("interface completion context", vim.tbl_contains(c, "switchport mode trunk"))
check("global context", vim.tbl_contains(complete._candidates_for(find("^hostname")), "interface"))
check("acl completion context", vim.tbl_contains(complete._candidates_for(find(" permit tcp")), "remark"))
local dhcp = complete._candidates_for(find(" default%-router"))
check("dhcp pool completion context", vim.tbl_contains(dhcp, "dns-server"))
check("dhcp pool gets no acl keywords", not vim.tbl_contains(dhcp, "permit"))

-- content detection
vim.cmd("edit test/fixtures/sample.cfg")
check(".cfg detected by content", vim.bo.filetype == "ios")
check("x-confg", vim.filetype.match({ filename = "r1-confg" }) == "ios")
local tmp = vim.fn.tempname() .. ".cfg"
vim.fn.writefile({ "[section]", "key=value" }, tmp)
vim.cmd("edit " .. tmp)
check(".cfg non-ios keeps built-in filetype", vim.bo.filetype == "cfg")
tmp = vim.fn.tempname() .. ".txt"
vim.fn.writefile({ "plain text" }, tmp)
vim.cmd("edit " .. tmp)
check(".txt non-ios keeps built-in filetype", vim.bo.filetype == "text")
tmp = vim.fn.tempname() .. ".txt"
vim.fn.writefile({ "hostname R2", "interface Loopback0" }, tmp)
vim.cmd("edit " .. tmp)
check(".txt detected by content", vim.bo.filetype == "ios")

print(fails == 0 and "ALL OK" or (fails .. " FAILED"))
vim.cmd(fails == 0 and "qa!" or "cq!")
