set -x EDITOR vim
set -gx TERM screen-256color-bce # kmscon need this else it gonna show weird color code

# IME is fcitx5
#XMODIFIERS=@im=fcitx
#GTK_IM_MODULE=fcitx
#QT_IM_MODULE=fcitx

# Gemini authen for dataannotation
set -gx GEMINI_API_KEY "sk-plwkr01-WGA7VVMJX6VGFPEFQT3639RZP4W9JAPCDFFG7HME6EVMMCYM"
set -gx GOOGLE_GEMINI_BASE_URL "https://app.dataannotation.tech/api/llm_proxy/gemini"

# set -x LESS "-N" # Cause man page to be scrambled
# Scripts and stuff
if status is-interactive
    set -U fish_user_paths /home/reinir/path $fish_user_paths
end

function fish_greeting
    greet
end
function greet

    # System Information
    echo -n -e (set_color --bold blue)(uname -srmo)"\n"
    echo -n -e (set_color yellow)(date "+%A, %Y-%m-%d %H:%M:%S")"\t"(set_color cyan)(uptime -p)"\n"
    set_color normal

    echo "-------------------------------------------------------"

    # CPU Load
    echo -e -n (set_color yellow)"CPU:\t"(set_color --bold cyan)(uptime | awk -F 'load average: ' '{print $2}')"\t"(set_color normal)
    echo -e -n (set_color yellow)"Memory:\t"(set_color --bold cyan)(free -h | awk '/^Mem:/ {print $3 " / " $2}')"\n"(set_color normal)


    # Swap Usage
    # echo -e -n (set_color yellow)"Swap Usage:\t"(set_color cyan)
    # free -h | awk '/^Swap:/ {print $3 " / " $2}'
    # set_color normal

    # Disk Usage (root filesystem)
    echo -e -n (set_color yellow)"Store (/):\t"(set_color cyan)(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 " used)"}')"\n"
    echo -e -n (set_color yellow)"Store (/home):\t"(set_color cyan)(df -h /home | awk 'NR==2 {print $3 " / " $2 " (" $5 " used)"}')"\n"
    echo -e -n (set_color yellow)"Store (win10):\t"(set_color cyan)(df -h /mnt/win10 | awk 'NR==2 {print $3 " / " $2 " (" $5 " used)"}')"\n"
    set_color normal
    # Optional: GPU Usage (if you have an NVIDIA GPU)
    # if type -q nvidia-smi
    #    echo -e -n (set_color yellow)"GPU:\t"(set_color cyan)
    #    nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits | \
    #        awk -F ', ' '{print $1"% ("$2" MiB / "$3" MiB)"}'
    # set_color normal
    # end
    echo "-------------------------------------------------------"
    echo "|     Terminal session on Reinir's 3rd laptop         |"
    echo "-------------------------------------------------------"
    sed '/---/Q' ~/notes.txt 
    echo "-------------------------------------------------------"
end
