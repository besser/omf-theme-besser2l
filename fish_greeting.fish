function fish_greeting -d "Greeting message on shell session start up"

    set --local os_type (uname -s)
    echo ""
    echo -en (welcome_message) "\n\n"
    # echo -en (show_date_info) "\n\n"
    if [ "$os_type" = "Linux" ]
        echo -en (show_os_info) "\n"
        echo -en (show_cpu_info) "\n"
        echo -en (show_mem_info) "\n"
        echo -en (show_net_info) "\n"
    else if [ "$os_type" = "Darwin" ]
        echo -en (show_os_info) "\n"
        echo -en (show_cpu_info) "\n"
        echo -en (show_mem_info) "\n"
        echo -en (show_net_info) "\n"
        #echo -en (show_net_info_only) "\n"
    end
    echo ""
    set_color FFF
    echo "All your bases are belong to us!"
    echo ""
    set_color normal

end


function welcome_message -d "Say welcome to user"

    echo -en "Welcome "
    set_color cyan
    echo -en (whoami) | tr -d " "
    set_color normal
    echo "!"

end


function show_date_info -d "Prints information about date"

    set --local up_time (uptime |sed 's/^ *//g' |cut -d " " -f4,5 |tr -d ",")

    echo -en "Today is "
    set_color cyan
    echo -en (date +%d.%m.%Y)
    set_color normal
    echo -en ", we are up and running for "
    set_color cyan
    echo -en "$up_time"
    set_color normal
    echo -en "."

end


function show_os_info -d "Prints operating system info"

    set_color FFF
    echo -en "OS    : "
    set_color cyan
    echo -en (uname -sm)
    set_color normal

end


function show_cpu_info -d "Prints iformation about cpu"

    set --local os_type (uname -s)
    set --local cpu_info ""

    if [ "$os_type" = "Linux" ]

        set --local procs_n (grep -c "^processor" /proc/cpuinfo)
        set --local cores_n (grep "cpu cores" /proc/cpuinfo | head -1 | cut -d ":"  -f2 | tr -d " ")
        set --local cpu_type (grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2)
        set cpu_info "$procs_n processors, $cores_n cores, $cpu_type"

    else if [ "$os_type" = "Darwin" ]

        set --local procs_n (system_profiler SPHardwareDataType | grep "Number of Processors" | cut -d ":" -f2 | tr -d " ")
        set --local cores_n (system_profiler SPHardwareDataType | grep "Cores" | cut -d ":" -f2 | tr -d " ")
        set --local cpu_type (system_profiler SPHardwareDataType | grep "Processor Name" | cut -d ":" -f2)
        set --local cpu_clock (system_profiler SPHardwareDataType | grep "Processor Speed" | cut -d ":" -f2 | tr -d " ")
        set cpu_info "$procs_n processors, $cores_n cores,$cpu_type @ $cpu_clock"

    end

    set_color FFF
    echo -en "CPU   : "
    set_color cyan
    echo -en $cpu_info
    set_color normal

end


function show_mem_info -d "Prints memory information"

    set --local os_type (uname -s)
    set --local total_memory ""

    if [ "$os_type" = "Linux" ]
        set total_memory (free -h | grep "Mem" | cut -d " " -f 12)

    else if [ "$os_type" = "Darwin" ]
        set total_memory (system_profiler SPHardwareDataType | grep "Memory:" | cut -d ":" -f 2 | tr -d " ")
    end

    set_color FFF
    echo -en "Memory: "
    set_color cyan
    echo -en $total_memory
    set_color normal

end


function show_net_info -d "Prints information about network"

    set --local os_type (uname -s)
    set --local ip ""
    set --local gw ""

    if [ "$os_type" = "Linux" ]
        set ip (ip addr show | grep -v "127.0.0.1" | grep "inet "| sed 's/^ *//g' | cut -d " " -f2)
        set gw (netstat -nr | grep UG | cut -d " " -f10)
    else if [ "$os_type" = "Darwin" ]
        set ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
        set gw (netstat -nr | grep default | cut -d " " -f13)
    end

    set_color FFF
    echo -en "Net   : "
    set_color cyan
    echo -en "IP address $ip, Gateway $gw"
    set_color normal

end


function show_net_info_only -d "Prints information about network"

    set --local os_type (uname -s)
    set --local ip ""
    set --local gw ""

    if [ "$os_type" = "Linux" ]
        set ip (ip addr show | grep -v "127.0.0.1" | grep "inet "| sed 's/^ *//g' | cut -d " " -f2)
        set gw (netstat -nr | grep UG | cut -d " " -f10)
    else if [ "$os_type" = "Darwin" ]
        set ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
        set gw (netstat -nr | grep default | cut -d " " -f13)
    end

    set_color FFF
    echo -en "Network: "
    set_color cyan
    echo -en "IP: $ip | Gateway: $gw"
    set_color normal

end
