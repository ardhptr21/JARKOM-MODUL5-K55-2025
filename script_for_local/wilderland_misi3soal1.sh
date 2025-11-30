# bebas pilih script mana aja
# =============================Script dari Ardhi==========================================================

iptables -A INPUT -d 10.91.1.200/29 -j DROP
iptables -A OUTPUT -d 10.91.1.200/29 -j DROP

# =============================Script dari GEMINI untuk winderland==========================================================
# --- MISI 3: ISOLASI KHAMUL ---
# Subnet Khamul: 10.91.1.200/29

# 1. Blokir paket DARI Khamul (Apapun tujuannya)
iptables -A FORWARD -s 10.91.1.200/29 -j DROP

# 2. Blokir paket MENUJU Khamul (Dari manapun asalnya)
iptables -A FORWARD -d 10.91.1.200/29 -j DROP

# Cek Rules
iptables -L FORWARD -v -n


