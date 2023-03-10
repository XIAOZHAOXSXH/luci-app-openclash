#!/bin/bash
. /lib/functions.sh
. /usr/share/openclash/ruby.sh

set_lock() {
   exec 885>"/tmp/lock/openclash_debug.lock" 2>/dev/null
   flock -x 885 2>/dev/null
}

del_lock() {
   flock -u 885 2>/dev/null
   rm -rf "/tmp/lock/openclash_debug.lock"
}

DEBUG_LOG="/tmp/openclash_debug.log"
LOGTIME=$(echo $(date "+%Y-%m-%d %H:%M:%S"))
uci -q commit openclash
set_lock

enable_custom_dns=$(uci -q get openclash.config.enable_custom_dns)
rule_source=$(uci -q get openclash.config.rule_source)
enable_custom_clash_rules=$(uci -q get openclash.config.enable_custom_clash_rules) 
ipv6_enable=$(uci -q get openclash.config.ipv6_enable)
ipv6_dns=$(uci -q get openclash.config.ipv6_dns)
enable_redirect_dns=$(uci -q get openclash.config.enable_redirect_dns)
disable_masq_cache=$(uci -q get openclash.config.disable_masq_cache)
proxy_mode=$(uci -q get openclash.config.proxy_mode)
intranet_allowed=$(uci -q get openclash.config.intranet_allowed)
enable_udp_proxy=$(uci -q get openclash.config.enable_udp_proxy)
enable_rule_proxy=$(uci -q get openclash.config.enable_rule_proxy)
en_mode=$(uci -q get openclash.config.en_mode)
RAW_CONFIG_FILE=$(uci -q get openclash.config.config_path)
CONFIG_FILE="/etc/openclash/$(uci -q get openclash.config.config_path |awk -F '/' '{print $5}' 2>/dev/null)"
core_type=$(uci -q get openclash.config.core_version)
cpu_model=$(opkg status libc 2>/dev/null |grep 'Architecture' |awk -F ': ' '{print $2}' 2>/dev/null)
core_version=$(/etc/openclash/core/clash -v 2>/dev/null |awk -F ' ' '{print $2}' 2>/dev/null)
core_tun_version=$(/etc/openclash/core/clash_tun -v 2>/dev/null |awk -F ' ' '{print $2}' 2>/dev/null)
core_meta_version=$(/etc/openclash/core/clash_meta -v 2>/dev/null |awk -F ' ' '{print $3}' 2>/dev/null)
servers_update=$(uci -q get openclash.config.servers_update)
mix_proxies=$(uci -q get openclash.config.mix_proxies)
op_version=$(opkg status luci-app-openclash 2>/dev/null |grep 'Version' |awk -F 'Version: ' '{print "v"$2}')
china_ip_route=$(uci -q get openclash.config.china_ip_route)
common_ports=$(uci -q get openclash.config.common_ports)
dns_remote=$(uci -q -q get openclash.config.dns_remote)
router_self_proxy=$(uci -q get openclash.config.router_self_proxy)

if [ -z "$RAW_CONFIG_FILE" ] || [ ! -f "$RAW_CONFIG_FILE" ]; then
	CONFIG_NAME=$(ls -lt /etc/openclash/config/ | grep -E '.yaml|.yml' | head -n 1 |awk '{print $9}')
	if [ ! -z "$CONFIG_NAME" ]; then
      RAW_CONFIG_FILE="/etc/openclash/config/$CONFIG_NAME"
      CONFIG_FILE="/etc/openclash/$CONFIG_NAME"
  fi
fi

ts_cf()
{
	if [ "$1" != 1 ]; then
	   echo "??????"
	else
	   echo "??????"
  fi
}

ts_re()
{
	if [ -z "$1" ]; then
	   echo "?????????"
	else
	   echo "?????????"
  fi
}

echo "OpenClash ????????????" > "$DEBUG_LOG"
cat >> "$DEBUG_LOG" <<-EOF

????????????: $LOGTIME
????????????: $op_version
????????????: ????????????????????????????????????????????????IP???????????????????????????????????????

\`\`\`
EOF

cat >> "$DEBUG_LOG" <<-EOF

#===================== ???????????? =====================#

????????????: $(cat /tmp/sysinfo/model 2>/dev/null)
????????????: $(cat /usr/lib/os-release 2>/dev/null |grep OPENWRT_RELEASE 2>/dev/null |awk -F '"' '{print $2}' 2>/dev/null)
LuCI??????: $(opkg status luci 2>/dev/null |grep 'Version' |awk -F ': ' '{print $2}' 2>/dev/null)
????????????: $(uname -r 2>/dev/null)
???????????????: $cpu_model

#???????????????,????????????IPv6,???????????????-??????-lan??????????????????IPV6???DHCP
IPV6-DHCP: $(uci -q get dhcp.lan.dhcpv6)

#????????????????????????????????????DNS????????????
Dnsmasq????????????: $(uci -q get dhcp.@dnsmasq[0].server)
EOF

cat >> "$DEBUG_LOG" <<-EOF

#===================== ???????????? =====================#

dnsmasq-full: $(ts_re "$(opkg status dnsmasq-full 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
coreutils: $(ts_re "$(opkg status coreutils 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
coreutils-nohup: $(ts_re "$(opkg status coreutils-nohup 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
bash: $(ts_re "$(opkg status bash 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
curl: $(ts_re "$(opkg status curl 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
ca-certificates: $(ts_re "$(opkg status ca-certificates 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
ipset: $(ts_re "$(opkg status ipset 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
ip-full: $(ts_re "$(opkg status ip-full 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
libcap: $(ts_re "$(opkg status libcap 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
libcap-bin: $(ts_re "$(opkg status libcap-bin 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
ruby: $(ts_re "$(opkg status ruby 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
ruby-yaml: $(ts_re "$(opkg status ruby-yaml 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
ruby-psych: $(ts_re "$(opkg status ruby-psych 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
ruby-pstore: $(ts_re "$(opkg status ruby-pstore 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
kmod-tun(TUN??????): $(ts_re "$(opkg status kmod-tun 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
luci-compat(Luci >= 19.07): $(ts_re "$(opkg status luci-compat 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
kmod-inet-diag(PROCESS-NAME): $(ts_re "$(opkg status kmod-inet-diag 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
unzip: $(ts_re "$(opkg status unzip 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
EOF
if [ -n "$(command -v fw4)" ]; then
cat >> "$DEBUG_LOG" <<-EOF
kmod-nft-tproxy: $(ts_re "$(opkg status kmod-nft-tproxy 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
iptables-mod-tproxy: $(ts_re "$(opkg status iptables-mod-tproxy 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
kmod-ipt-tproxy: $(ts_re "$(opkg status kmod-ipt-tproxy 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
iptables-mod-extra: $(ts_re "$(opkg status iptables-mod-extra 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
kmod-ipt-extra: $(ts_re "$(opkg status kmod-ipt-extra 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
kmod-ipt-nat: $(ts_re "$(opkg status kmod-ipt-nat 2>/dev/null |grep 'Status' |awk -F ': ' '{print $2}' 2>/dev/null)")
EOF
fi

EOF

#core
cat >> "$DEBUG_LOG" <<-EOF

#===================== ???????????? =====================#

EOF
if pidof clash >/dev/null; then
cat >> "$DEBUG_LOG" <<-EOF
????????????: ?????????
??????pid: $(pidof clash)
????????????: `getpcaps $(pidof clash)`
????????????: $(ps |grep "/etc/openclash/clash" |grep -v grep |awk '{print $2}' 2>/dev/null)
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
????????????: ?????????
EOF
fi
if [ "$core_type" = "0" ]; then
   core_type="???????????????"
fi
cat >> "$DEBUG_LOG" <<-EOF
??????????????????: $core_type

#?????????????????????????????????????????????????????????????????????????????????????????????
EOF

cat >> "$DEBUG_LOG" <<-EOF
Tun????????????: $core_tun_version
EOF
if [ ! -f "/etc/openclash/core/clash_tun" ]; then
cat >> "$DEBUG_LOG" <<-EOF
Tun????????????: ?????????
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
Tun????????????: ??????
EOF
fi
if [ ! -x "/etc/openclash/core/clash_tun" ]; then
cat >> "$DEBUG_LOG" <<-EOF
Tun??????????????????: ???
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
Tun??????????????????: ??????
EOF
fi

cat >> "$DEBUG_LOG" <<-EOF

Dev????????????: $core_version
EOF
if [ ! -f "/etc/openclash/core/clash" ]; then
cat >> "$DEBUG_LOG" <<-EOF
Dev????????????: ?????????
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
Dev????????????: ??????
EOF
fi
if [ ! -x "/etc/openclash/core/clash" ]; then
cat >> "$DEBUG_LOG" <<-EOF
Dev??????????????????: ???
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
Dev??????????????????: ??????
EOF
fi

cat >> "$DEBUG_LOG" <<-EOF

Meta????????????: $core_meta_version
EOF

if [ ! -f "/etc/openclash/core/clash_meta" ]; then
cat >> "$DEBUG_LOG" <<-EOF
Meta????????????: ?????????
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
Meta????????????: ??????
EOF
fi
if [ ! -x "/etc/openclash/core/clash_meta" ]; then
cat >> "$DEBUG_LOG" <<-EOF
Meta??????????????????: ???
EOF
else
cat >> "$DEBUG_LOG" <<-EOF
Meta??????????????????: ??????
EOF
fi

cat >> "$DEBUG_LOG" <<-EOF

#===================== ???????????? =====================#

??????????????????: $RAW_CONFIG_FILE
??????????????????: $CONFIG_FILE
????????????: $en_mode
??????????????????: $proxy_mode
UDP????????????(tproxy): $(ts_cf "$enable_udp_proxy")
DNS??????: $(ts_cf "$enable_redirect_dns")
?????????DNS: $(ts_cf "$enable_custom_dns")
IPV6??????: $(ts_cf "$ipv6_enable")
IPV6-DNS??????: $(ts_cf "$ipv6_dns")
??????Dnsmasq??????: $(ts_cf "$disable_masq_cache")
???????????????: $(ts_cf "$enable_custom_clash_rules")
???????????????: $(ts_cf "$intranet_allowed")
???????????????????????????: $(ts_cf "$enable_rule_proxy")
???????????????????????????: $(ts_cf "$common_ports")
??????????????????IP: $(ts_cf "$china_ip_route")
DNS????????????: $(ts_cf "$dns_remote")
??????????????????: $(ts_cf "$router_self_proxy")

#??????????????????????????????????????????
????????????: $(ts_cf "$mix_proxies")
????????????: $(ts_cf "$servers_update")
EOF

cat >> "$DEBUG_LOG" <<-EOF

#??????????????????????????????????????????
???????????????: $(ts_cf "$rule_source")
EOF


if [ "$enable_custom_clash_rules" -eq 1 ]; then
cat >> "$DEBUG_LOG" <<-EOF

#===================== ??????????????? ??? =====================#
EOF
cat /etc/openclash/custom/openclash_custom_rules.list >> "$DEBUG_LOG"

cat >> "$DEBUG_LOG" <<-EOF

#===================== ??????????????? ??? =====================#
EOF
cat /etc/openclash/custom/openclash_custom_rules_2.list >> "$DEBUG_LOG"
fi

cat >> "$DEBUG_LOG" <<-EOF

#===================== ???????????? =====================#

EOF
if [ -f "$CONFIG_FILE" ]; then
   ruby_read "$CONFIG_FILE" ".select {|x| 'proxies' != x and 'proxy-providers' != x }.to_yaml" 2>/dev/null >> "$DEBUG_LOG"
else
   ruby_read "$RAW_CONFIG_FILE" ".select {|x| 'proxies' != x and 'proxy-providers' != x }.to_yaml" 2>/dev/null >> "$DEBUG_LOG"
fi

sed -i '/^ \{0,\}secret:/d' "$DEBUG_LOG" 2>/dev/null

#firewall
cat >> "$DEBUG_LOG" <<-EOF

#===================== IPTABLES ??????????????? =====================#

#IPv4 NAT chain

EOF
iptables-save -t nat >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#IPv4 Mangle chain

EOF
iptables-save -t mangle >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#IPv4 Filter chain

EOF
iptables-save -t filter >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#IPv6 NAT chain

EOF
ip6tables-save -t nat >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#IPv6 Mangle chain

EOF
ip6tables-save -t mangle >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#IPv6 Filter chain

EOF
ip6tables-save -t filter >> "$DEBUG_LOG" 2>/dev/null

if [ -n "$(command -v fw4)" ]; then
cat >> "$DEBUG_LOG" <<-EOF

#===================== NFTABLES ??????????????? =====================#

EOF
   for nft in "input" "forward" "dstnat" "srcnat" "nat_output" "mangle_prerouting" "mangle_output"; do
      nft list chain inet fw4 "$nft" >> "$DEBUG_LOG" 2>/dev/null
   done >/dev/null 2>&1
   for nft in "openclash" "openclash_mangle" "openclash_mangle_output" "openclash_output" "openclash_post" "openclash_wan_input" "openclash_dns_hijack" "openclash_mangle_v6" "openclash_mangle_output_v6" "openclash_post_v6" "openclash_wan6_input"; do
      nft list chain inet fw4 "$nft" >> "$DEBUG_LOG" 2>/dev/null
   done >/dev/null 2>&1
fi

cat >> "$DEBUG_LOG" <<-EOF

#===================== IPSET?????? =====================#

EOF
ipset list |grep "Name:" >> "$DEBUG_LOG"

cat >> "$DEBUG_LOG" <<-EOF

#===================== ??????????????? =====================#

EOF
echo "#route -n" >> "$DEBUG_LOG"
route -n >> "$DEBUG_LOG" 2>/dev/null
echo "#ip route list" >> "$DEBUG_LOG"
ip route list >> "$DEBUG_LOG" 2>/dev/null
echo "#ip rule show" >> "$DEBUG_LOG"
ip rule show >> "$DEBUG_LOG" 2>/dev/null

if [ "$en_mode" != "fake-ip" ] && [ "$en_mode" != "redir-host" ]; then
cat >> "$DEBUG_LOG" <<-EOF

#===================== Tun???????????? =====================#

EOF
ip tuntap list >> "$DEBUG_LOG" 2>/dev/null
fi

cat >> "$DEBUG_LOG" <<-EOF

#===================== ?????????????????? =====================#

EOF
netstat -nlp |grep clash >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#===================== ????????????DNS?????? =====================#

EOF
nslookup www.baidu.com >> "$DEBUG_LOG" 2>/dev/null

if [ -s "/tmp/resolv.conf.auto" ]; then
cat >> "$DEBUG_LOG" <<-EOF

#===================== resolv.conf.auto =====================#

EOF
cat /tmp/resolv.conf.auto >> "$DEBUG_LOG"
fi

if [ -s "/tmp/resolv.conf.d/resolv.conf.auto" ]; then
cat >> "$DEBUG_LOG" <<-EOF

#===================== resolv.conf.d =====================#

EOF
cat /tmp/resolv.conf.d/resolv.conf.auto >> "$DEBUG_LOG"
fi

cat >> "$DEBUG_LOG" <<-EOF

#===================== ???????????????????????? =====================#

EOF
curl -SsI -m 5 www.baidu.com >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#===================== ???????????????????????? =====================#

EOF
VERSION_URL="https://raw.githubusercontent.com/vernesong/OpenClash/master/version"
if pidof clash >/dev/null; then
   curl -SsIL -m 3 --retry 2 "$VERSION_URL" >> "$DEBUG_LOG" 2>/dev/null
else
   curl -SsIL -m 3 --retry 2 "$VERSION_URL" >> "$DEBUG_LOG" 2>/dev/null
fi

cat >> "$DEBUG_LOG" <<-EOF

#===================== ?????????????????? =====================#

EOF
tail -n 50 "/tmp/openclash.log" >> "$DEBUG_LOG" 2>/dev/null

cat >> "$DEBUG_LOG" <<-EOF

#===================== ?????????????????? =====================#

EOF
/usr/share/openclash/openclash_debug_getcon.lua

cat >> "$DEBUG_LOG" <<-EOF

\`\`\`
EOF

wan_ip=$(/usr/share/openclash/openclash_get_network.lua "wanip")
wan_ip6=$(/usr/share/openclash/openclash_get_network.lua "wanip6")

if [ -n "$wan_ip" ]; then
	for i in $wan_ip; do
      wanip=$(echo "$i" |awk -F '.' '{print $1"."$2"."$3}')
      sed -i "s/${wanip}/*WAN IP*/g" "$DEBUG_LOG" 2>/dev/null
  done
fi

if [ -n "$wan_ip6" ]; then
	for i in $wan_ip6; do
      wanip=$(echo "$i" |awk -F: 'OFS=":",NF-=1')
      sed -i "s/${wanip}/*WAN IP*/g" "$DEBUG_LOG" 2>/dev/null
  done
fi

del_lock