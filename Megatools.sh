#!/bin/bash

-------------------------------

Mega Tools Installer - Completo

Autor: Mrx-rng  By- THERAC-25

-------------------------------

--- Arte ASCII ---

ascii_art() {
cat << "EOF"
⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄
⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄
⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄
⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄
⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰
⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤
⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗
⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄
⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄
⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄
⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄
⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄
⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄
⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴
⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿
EOF
}

--- Cores ---

VERDE="\033[1;32m"
VERMELHO="\033[1;31m"
AMARELO="\033[1;33m"
AZUL="\033[1;34m"
RESET="\033[0m"

--- Pasta para instalar ferramentas ---

PASTA_INSTALACAO="$HOME/tools"
mkdir -p "$PASTA_INSTALACAO"

--- Função animação digitação ---

type_text() {
local texto="$1"
local delay=${2:-0.03}
for (( i=0; i<${#texto}; i++ )); do
echo -n "${texto:$i:1}"
sleep $delay
done
echo
}

--- Spinner para loading ---

spinner() {
local pid=$1
local delay=0.1
local spinstr='|/-'
while kill -0 "$pid" 2>/dev/null; do
local temp=${spinstr#?}
printf " [%c]  " "$spinstr"
spinstr=$temp${spinstr%"$temp"}
sleep $delay
printf "\b\b\b\b\b\b"
done
echo "    "
}

--- Função para instalar ou atualizar ferramenta ---

instalar_ferramenta() {
local nome="$1"
local url="$2"
local pasta_destino="$PASTA_INSTALACAO/$nome"

echo -e "${AZUL}Instalando ou atualizando $nome...${RESET}"
if [[ "$url" == https://* || "$url" == git@* ]]; then
if [ -d "$pasta_destino/.git" ]; then
echo -e "${AMARELO}Pasta já existe, atualizando...${RESET}"
(cd "$pasta_destino" && git pull --quiet) &
spinner $!
else
git clone --quiet "$url" "$pasta_destino" &
spinner $!
fi
echo -e "${VERDE}$nome instalado/atualizado em $pasta_destino${RESET}"
else
echo -e "${VERMELHO}URL inválida ou site estático, acesso manual necessário: $url${RESET}"
fi
echo -e "Pressione Enter para continuar..."
read -r
}

--- Função para mostrar menu de categoria ---

menu_categoria() {
local -n arr=$1
while true; do
clear
ascii_art
echo -e "${VERDE}Selecione a ferramenta para instalar (0 para voltar):${RESET}"
local i=1
local keys=()
for key in "${!arr[@]}"; do
echo -e "  $i) $key"
keys+=("$key")
((i++))
done
echo -n "Opção: "
read -r opc
if [[ "$opc" == "0" ]]; then
break
elif [[ "$opc" =~ ^[0-9]+$ ]] && (( opc >= 1 && opc < i )); then
local escolha="${keys[$((opc-1))]}"
instalar_ferramenta "$escolha" "${arr[$escolha]}"
else
echo -e "${VERMELHO}Opção inválida! Tente novamente.${RESET}"
sleep 1
fi
done
}

--- Declaração das categorias e ferramentas ---

declare -A Android=(
["Backdoor-apk"]="https://github.com/dana-at-cp/backdoor-apk.git"
["Evil-Droid"]="https://github.com/M4sc3r4n0/Evil-Droid.git"
["Spade"]="https://github.com/turksiberguvenlik/spade.git"
["AhMyth"]="https://github.com/AhMyth/AhMyth-Android-RAT.git"
["Andspoilt"]="https://github.com/sundaysec/Andspoilt.git"
["kwetza"]="https://github.com/sensepost/kwetza.git"
["Termux"]="https://termux.com"
["Android-Exploits"]="https://github.com/sundaysec/Android-Exploits.git"
["Grabcam"]="https://github.com/noob-hackers/grabcam.git"
["Androidpatternlock"]="https://github.com/sch3m4/androidpatternlock.git"
)

declare -A Windows=(
["Winpayloads"]="https://github.com/nccgroup/Winpayloads.git"
["sAINT"]="https://github.com/tiagorlampert/sAINT.git"
["BeeLogger"]="https://github.com/4w4k3/BeeLogger.git"
["FakeImageExploiter"]="https://github.com/r00t-3xp10it/FakeImageExploiter.git"
["Koadic"]="https://github.com/zerosum0x0/koadic.git"
["Phantom-Evasion"]="https://github.com/oddcod3/Phantom-Evasion.git"
["Ps1encode"]="https://github.com/CroweCybersecurity/ps1encode.git"
["DKMC"]="https://github.com/Mr-Un1k0d3r/DKMC.git"
["Cromos"]="https://github.com/6IX7ine/cromos.git"
["Eternal_scanner"]="https://github.com/peterpt/eternal_scanner.git"
["Eternalblue-Doublepulsar-Metasploit"]="https://github.com/ElevenPaths/Eternalblue-Doublepulsar-Metasploit.git"
["MS17-010-EternalBlue-WinXP-Win10"]="https://github.com/hanshaze/MS17-010-EternalBlue-WinXP-Win10.git"
["WindowsExploits"]="https://github.com/WindowsExploits/Exploits.git"
)

declare -A Phishing=(
["HiddenEye"]="https://github.com/DarkSecDevelopers/HiddenEye.git"
["PhishX"]="https://github.com/Userphish/PhishX.git"
["SocialPhish"]="https://github.com/xHak9x/SocialPhish.git"
["SocialFish"]="https://github.com/UndeadSec/SocialFish.git"
["Phisher-man"]="https://github.com/FDX100/Phisher-man.git"
["Spectre"]="https://github.com/Pure-L0G1C/Spectre.git"
["Blackeye"]="https://github.com/An0nUD4Y/blackeye.git"
["PhEmail"]="https://github.com/Dionach/PhEmail.git"
["Weeman"]="https://github.com/evait-security/weeman.git"
["Zphisher"]="https://github.com/htr-tech/zphisher.git"
["AIOPhish"]="https://github.com/DeepSociety/AIOPhish.git"
)

declare -A WifiAttacks=(
["Fluxion"]="https://github.com/FluxionNetwork/fluxion.git"
["Wifiphisher"]="https://github.com/wifiphisher/wifiphisher.git"
["WiFiBroot"]="https://github.com/hash3liZer/WiFiBroot.git"
["Wifite"]="https://github.com/derv82/wifite.git"
["Ettercap"]="https://github.com/Ettercap/ettercap.git"
["Linset"]="https://github.com/chunkingz/linsetmv1-2.git"
["Wifi-Pumpkin"]="https://github.com/P0cL4bs/WiFi-Pumpkin.git"
["Wifresti"]="https://github.com/LionSec/wifresti.git"
["Evillimiter"]="https://github.com/bitbrute/evillimiter.git"
["Netool-toolkit"]="https://github.com/r00t-3xp10it/netool-toolkit.git"
["Dracnmap"]="https://github.com/Screetsec/Dracnmap.git"
["Airgeddon"]="https://github.com/v1s1t0r1sh3r3/airgeddon.git"
["Routersploit"]="https://github.com/threat9/routersploit.git"
["Eaphammer"]="https://github.com/s0lst1c3/eaphammer.git"
["VMR-MDK"]="https://github.com/chunkingz/VMR-MDK-K2-2017R-012x4.git"
["Wirespy"]="https://github.com/aress31/wirespy.git"
["Wireshark"]="https://www.wireshark.org"
["SniffAir"]="https://github.com/Tylous/SniffAir.git"
["Wifijammer"]="https://github.com/DanMcInerney/wifijammer.git"
["KawaiiDeauther"]="https://github.com/aryanrtm/KawaiiDeauther.git"
)

declare -A PasswordAttacks=(
["Cupp"]="https://github.com/Mebus/cupp.git"
["Facebooker"]="https://github.com/FakeFBI/Facebooker.git"
["BluForce-FB"]="https://github.com/AngelSecurityTeam/BluForce-FB.git"
["Brut3k1t"]="https://github.com/ex0dus-0x/brut3k1t.git"
["SocialBox"]="https://github.com/TunisianEagles/SocialBox.git"
["JohnTheRipper"]="https://github.com/magnumripper/JohnTheRipper.git"
["Hashcat"]="https://github.com/hashcat/hashcat.git"
["BruteDum"]="https://github.com/GitHackTools/BruteDum.git"
["Facebash"]="https://github.com/thelinuxchoice/facebash.git"
["Brutespray"]="https://github.com/x90skysn3k/brutespray.git"
["PUPI"]="https://github.com/mIcHyAmRaNe/PUPI.git"
["B4r-brute"]="https://github.com/b4rc0d37/b4r-brute.git"
["Fb-hack"]="https://github.com/mirzaaltaf/fb-hack.git"
)

declare -A WebAttacks=(
["SQLmap"]="https://github.com/sqlmapproject/sqlmap.git"
["XAttacker"]="https://github.com/Moham3dRiahi/XAttacker.git"
["Fuxploider"]="https://github.com/almandin/fuxploider.git"
["Wordpresscan"]="https://github.com/swisskyrepo/Wordpresscan.git"
["SiteBroker"]="https://github.com/Anon-Exploiter/SiteBroker.git"
["NoSQLMap"]="https://github.com/codingo/NoSQLMap.git"
["Sqli-scanner"]="https://github.com/the-c0d3r/sqli-scanner.git"
["Joomscan"]="https://github.com/rezasp/joomscan.git"
["Metagoofil"]="https://github.com/laramies/metagoofil.git"
["Sublist3r"]="https://github.com/aboul3la/Sublist3r.git"
["WAFNinja"]="https://github.com/khalilbijjou/WAFNinja.git"
["Dirsearch"]="https://github.com/maurosoria/dirsearch.git"
["XSStrike"]="https://github.com/s0md3v/XSStrike.git"
["LinksF1nd3r"]="https://github.com/ihebski/LinksF1nd3r.git"
["D-Tech"]="https://github.com/bibortone/D-Tech.git"
["Phpsploit"]="https://github.com/nil0x42/phpsploit.git"
)

declare -A Spoofing=(
["SpoofMAC"]="https://github.com/feross/SpoofMAC.git"
["Ip_spoofing"]="https://github.com/pankajmore/ip_spoofing.git"
["ArpSpoof"]="https://github.com/ickerwx/arpspoof.git"
["DerpNSpoof"]="https://github.com/Trackbool/DerpNSpoof.git"
["DrSpoof"]="https://github.com/Enixes/Dr.Spoof.git"
["GOD-KILLER"]="https://github.com/FDX100/GOD-KILLER.git"
)

declare -A InfoGathering=(
["Nmap"]="https://github.com/nmap/nmap.git"
["Th3inspector"]="https://github.com/Moham3dRiahi/Th3inspector.git"
["Facebook Information"]="https://github.com/xHak9x/fbi.git"
["Infoga"]="https://github.com/m4ll0k/Infoga.git"
["Crips"]="https://github.com/Manisso/Crips.git"
["BillCipher"]="https://github.com/GitHackTools/BillCipher.git"
["RED_HAWK"]="https://github.com/Tuhinshubhra/RED_HAWK.git"
["Recon-ng"]="https://github.com/lanmaster53/recon-ng.git"
["TheHarvester"]="https://github.com/alanchavez88/theHarvester.git"
["PhoneInfoga"]="https://github.com/sundowndev/PhoneInfoga.git"
["Gasmask"]="https://github.com/twelvesec/gasmask.git"
["URLextractor"]="https://github.com/eschultze/URLextractor.git"
["Devploit"]="https://github.com/GhettoCole/Devploit.git"
["ReconDog"]="https://github.com/s0md3v/ReconDog.git"
["Webkiller"]="https://github.com/ultrasecurity/webkiller.git"
["Quasar"]="https://github.com/Cyb0r9/quasar.git"
["Info-instagram-iphone"]="https://github.com/0xfff0800/info-instagram-iphone.git"
["UserScan"]="https://github.com/JoeTech-Studio/UserScan.git"
["XCTR-Hacking-Tools"]="https://github.com/capture0x/XCTR-Hacking-Tools.git"
["DeadTrap"]="https://github.com/Chr0m0s0m3s/DeadTrap.git"
)

declare -A Others=(
["TheFatRat"]="https://github.com/Screetsec/TheFatRat.git"
["Msfpc"]="https://github.com/g0tmi1k/msfpc.git"
["Fcrackzip"]="https://github.com/hyc/fcrackzip.git"
["QRLJacking"]="https://github.com/OWASP/QRLJacking.git"
["Lazy"]="https://github.com/arismelachroinos/lscript.git"
["HTB-INVITE"]="https://github.com/nycto-hackerone/HTB-INVITE.git"
["Ngrok"]="https://ngrok.com"
["Bluepot"]="https://github.com/andrewmichaelsmith/bluepot.git"
["Social-engineer-toolkit"]="https://github.com/trustedsec/social-engineer-toolkit.git"
["A2sv"]="https://github.com/hahwul/a2sv.git"
["4nonimizer"]="https://github.com/Hackplayers/4nonimizer.git"
["Easysploit"]="https://github.com/KALILINUXTRICKSYT/easysploit.git"
["NXcrypt"]="https://github.com/Hadi999/NXcrypt.git"
["KnockMail"]="https://github.com/4w4k3/KnockMail.git"
["Rkhunter"]="https://github.com/installation/rkhunter.git"
["HeraKeylogger"]="https://github.com/UndeadSec/HeraKeylogger.git"
["ZLogger"]="https://github.com/z00z/ZLogger.git"
["Xerosploit"]="https://github.com/LionSec/xerosploit.git"
["Slacksec"]="https://github.com/franc205/Slacksec.git"
["KatanaFramework"]="https://github.com/PowerScript/KatanaFramework.git"
["Z0172CK-Tools"]="https://github.com/Erik172/Z0172CK-Tools.git"
["Cam-Hack"]="https://github.com/Hack-The-World-With-Tech/Cam-Hack.git"
["Onex"]="https://github.com/rajkumardusad/onex.git"
["Ransom0"]="https://github.com/HugoLB0/Ransom0.git"
["Morpheus"]="https://github.com/r00t-3xp10it/morpheus.git"
["FBTOOL"]="https://github.com/mkdirlove/FBTOOL.git"
["Venom"]="https://github.com/r00t-3xp10it/venom.git"
)

--- Menu principal ---

menu_principal() {
while true; do
clear
ascii_art
echo -e "${VERDE}===== Mega Tools Installer =====${RESET}"
echo -e "1) Android"
echo -e "2) Windows"
echo -e "3) Phishing"
echo -e "4) Wifi Attacks"
echo -e "5) Password Attacks"
echo -e "6) Web Attacks"
echo -e "7) Spoofing"
echo -e "8) Information Gathering"
echo -e "9) Others"
echo -e "0) Sair"
echo -ne "\nEscolha uma categoria: "
read -r opcao

case $opcao in  
  1) menu_categoria Android ;;  
  2) menu_categoria Windows ;;  
  3) menu_categoria Phishing ;;  
  4) menu_categoria WifiAttacks ;;  
  5) menu_categoria PasswordAttacks ;;  
  6) menu_categoria WebAttacks ;;  
  7) menu_categoria Spoofing ;;  
  8) menu_categoria InfoGathering ;;  
  9) menu_categoria Others ;;  
  0) echo -e "${AMARELO}Saindo...${RESET}"; exit 0 ;;  
  *) echo -e "${VERMELHO}Opção inválida! Tente novamente.${RESET}"; sleep 1 ;;  
esac

done
}

--- Início do script ---

menu_principal

