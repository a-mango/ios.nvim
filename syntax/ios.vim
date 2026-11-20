" Vim syntax file
" Language: Cisco IOS configuration

if exists("b:current_syntax")
  finish
endif

syn case ignore
setlocal iskeyword+=-

" Comments
syn match iosComment "^\s*!.*$" contains=iosTodo
syn keyword iosTodo contained TODO FIXME XXX NOTE

" Free-text lines: no highlighting of the remainder
syn match iosDescKw "^\s*\(description\|remark\)\>" nextgroup=iosText skipwhite
syn match iosText "\S.*$" contained
syn match iosDescKw "^\s*\(ip \|ipv6 \)\=\(access-list\s\+\S\+\s\+\d\+\s\+\)\=remark\>" nextgroup=iosText skipwhite
syn match iosDescKw "^\s*access-list\s\+\d\+\s\+remark\>" nextgroup=iosText skipwhite

" ip and ipv6 are a match defined before the section starters. As keywords they
" would take priority and hide `ip access-list` or `ip dhcp pool` at column 0.
syn match iosKeyword "\<ip\(v6\)\=\>"

" Section starters (column 0)
syn match iosSection "^\(interface\|router\|line\|route-map\|vrf\|class-map\|policy-map\|crypto\|aaa\|control-plane\|archive\|vlan\|ip access-list\|ipv6 access-list\|ip dhcp pool\|key chain\|track\|redundancy\|spanning-tree\|snmp-server\|ntp\|logging\|hostname\|username\|enable\|service\|banner\)\>"
syn match iosSection "^\s\+address-family\>"

" Negation
syn match iosNo "^\s*no\>"
syn match iosNo "^\s*default\>\ze\s"

" Actions
syn keyword iosPermit permit
syn keyword iosDeny deny
syn keyword iosShutdown shutdown

" Common keywords
syn keyword iosKeyword switchport trunk access allowed native vlan mode
syn keyword iosKeyword address helper-address access-group access-class
syn keyword iosKeyword network neighbor redistribute passive-interface router-id
syn keyword iosKeyword transport input output exec-timeout login password secret
syn keyword iosKeyword duplex speed mtu bandwidth encapsulation channel-group
syn keyword iosKeyword spanning-tree portfast bpduguard standby vrf forwarding
syn keyword iosKeyword match set service-policy remote-as update-source
syn keyword iosKeyword any host eq gt lt neq range established log

" Interface names (long and short forms, with slot paths and subinterfaces)
syn match iosInterface "\<\(GigabitEthernet\|TenGigabitEthernet\|TwentyFiveGigE\|FortyGigabitEthernet\|HundredGigE\|FastEthernet\|Ethernet\|Serial\|Loopback\|Vlan\|Port-channel\|Tunnel\|Management\|Null\|BDI\|Gi\|Te\|Twe\|Fo\|Hu\|Fa\|Eth\|Et\|Se\|Lo\|Po\|Tu\|Vl\|Mgmt\)\d\+\(/\d\+\)*\(\.\d\+\)\=\>"

" Addresses (numbers first so more specific matches defined later win)
syn match iosNumber "\<\d\+\>"
syn match iosIPv4 "\<\d\{1,3}\(\.\d\{1,3}\)\{3}\>"
syn match iosIPv4Mask "\<\(255\|254\|252\|248\|240\|224\|192\|128\|0\)\(\.\(255\|254\|252\|248\|240\|224\|192\|128\|0\)\)\{3}\>"
syn match iosIPv4Mask "\<0\(\.\d\{1,3}\)\{3}\>"
syn match iosIPv4Prefix "\<\d\{1,3}\(\.\d\{1,3}\)\{3}/\d\{1,2}\>"
syn match iosIPv6 "\<\x\{1,4}\(:\x\{0,4}\)\{2,7}\(/\d\{1,3}\)\=\(\s\|$\)\@="
syn match iosIPv6 "\<::\(\x\{1,4}\(:\x\{1,4}\)*\)\=\(/\d\{1,3}\)\=\>"
syn match iosMac "\<\x\{4}\.\x\{4}\.\x\{4}\>"

" Secrets: "secret 5 <hash>", "password 7 <hash>"
syn match iosSecret "\(\<\(secret\|password\)\s\+\d\s\+\)\@<=\S\+"

" Banners: banner motd ^C ... ^C  (delimiter can be any char; ^C is literal \x03 or "^C")
syn region iosBanner matchgroup=iosBannerStart start="^banner\s\+\S\+\s\+\z(\^C\|\%x03\|[^[:space:]]\)" end="\z1" contains=NONE keepend
syn match iosBannerStart "^banner\s\+\S\+\ze\s*$"

syn sync minlines=200
syn case match

hi def link iosComment Comment
hi def link iosTodo Todo
hi def link iosDescKw Keyword
hi def link iosText String
hi def link iosSection Statement
hi def link iosNo Special
hi def link iosPermit DiagnosticOk
hi def link iosDeny DiagnosticError
hi def link iosShutdown WarningMsg
hi def link iosKeyword Keyword
hi def link iosInterface Type
hi def link iosIPv4 Number
hi def link iosIPv4Mask Number
hi def link iosIPv4Prefix Number
hi def link iosIPv6 Number
hi def link iosMac Number
hi def link iosNumber Number
hi def link iosSecret Constant
hi def link iosBanner String
hi def link iosBannerStart Statement

let b:current_syntax = "ios"
