fcfs() {

    echo -e "\n\t\t\t ---------------------------------------   "
    echo -e "\t\t\t   |      First-Come, First-Served       |   "
    echo -e "\t\t\t   ---------------------------------------   "

    echo -n "Enter the number of Processes: " 
    read N

    Processes=()
    BurstTime=()
    WaitingTime=()
    TurnAroundTime=()

    for i in $(seq 1 1 $N); do
        echo -n "Enter the name of Process $i: "
        read P
        Processes+=("$P")

        echo -n "Burst Time for $P (in units): "
        read B
        BurstTime+=("$B")
    done

    echo -e "\nSimulating FCFS...\n"

    WaitingTime[0]=0
    TurnAroundTime[0]=${BurstTime[0]}
    TotalWaitingTime=0
    TotalTurnAroundTime=${TurnAroundTime[0]}

    echo -e "Process\tBurst Time\tWaiting Time\tTurnaround Time"


    echo -e "${Processes[0]}\t${BurstTime[0]}\t\t${WaitingTime[0]}\t\t${TurnAroundTime[0]}"
    echo -n "Executing ${Processes[0]}: "
    for t in $(seq 1 1 ${BurstTime[0]}); do
        sleep 1 
        echo -n "."
    done
    echo " Complete!"

    for i in $(seq 1 1 $((N-1))); do
        WaitingTime[$i]=$((${TurnAroundTime[$((i-1))]}))
        TurnAroundTime[$i]=$((${WaitingTime[$i]} + ${BurstTime[$i]}))

        TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$i]}))
        TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$i]}))

        echo -e "${Processes[$i]}\t${BurstTime[$i]}\t\t${WaitingTime[$i]}\t\t${TurnAroundTime[$i]}"
        
    
        echo -n "Executing ${Processes[$i]}: "
        for t in $(seq 1 1 ${BurstTime[$i]}); do
            sleep 1  
            echo -n "."
        done
        echo " Complete!"
    done

    AvgWaitingTime=$(($TotalWaitingTime / $N))
    AvgTurnAroundTime=$(($TotalTurnAroundTime / $N)) 

    echo -e "\nAverage Waiting Time: $AvgWaitingTime"
    echo "Average Turnaround Time: $AvgTurnAroundTime"
}



sjf(){

    echo -e "\n\t\t\t ---------------------------------------   "
    echo -e "\t\t\t   |          Shortest Job First         |   "
    echo -e "\t\t\t   ---------------------------------------   "

    echo -n "Enter the number of Processes: "
    read N

    Processes=()
    BurstTime=()
    WaitingTime=()
    TurnAroundTime=()

    for i in $(seq 1 1 $N); do
        echo -n "Enter the name of Process $i: "
        read P
        Processes+=("$P")

        echo -n "Burst Time for $P (in units): "
        read B
        BurstTime+=("$B")
    done


    for ((i = 0; i < ($N-1); i++)); do
        for ((j = 0; j < ($N-i-1); j++)); do
            if [ ${BurstTime[j]} -gt ${BurstTime[$((j+1))]} ]; then
              
                temp=${BurstTime[j]}
                BurstTime[$j]=${BurstTime[$((j+1))]}  
                BurstTime[$((j+1))]=$temp

               
                temp=${Processes[j]}
                Processes[$j]=${Processes[$((j+1))]}  
                Processes[$((j+1))]=$temp
            fi
        done
    done

    echo -e "\nSimulating SJF...\n"

    WaitingTime[0]=0
    TurnAroundTime[0]=${BurstTime[0]}
    TotalWaitingTime=0
    TotalTurnAroundTime=${TurnAroundTime[0]}

    echo -e "Process\tBurst Time\tWaiting Time\tTurnaround Time"


    echo -e "${Processes[0]}\t${BurstTime[0]}\t\t${WaitingTime[0]}\t\t${TurnAroundTime[0]}"
    echo -n "Executing ${Processes[0]}: "
    for t in $(seq 1 1 ${BurstTime[0]}); do
        sleep 1  
        echo -n "."
    done
    echo " Complete!"

    for i in $(seq 1 1 $((N-1))); do
        WaitingTime[$i]=$((${TurnAroundTime[$((i-1))]}))
        TurnAroundTime[$i]=$((${WaitingTime[$i]} + ${BurstTime[$i]}))

        TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$i]}))
        TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$i]}))

        echo -e "${Processes[$i]}\t${BurstTime[$i]}\t\t${WaitingTime[$i]}\t\t${TurnAroundTime[$i]}"

       
        echo -n "Executing ${Processes[$i]}: "
        for t in $(seq 1 1 ${BurstTime[$i]}); do
            sleep 1  
            echo -n "."
        done
        echo " Complete!"
    done

    AvgWaitingTime=$(($TotalWaitingTime / $N))
    AvgTurnAroundTime=$(($TotalTurnAroundTime / $N)) 

    echo -e "\nAverage Waiting Time: $AvgWaitingTime"
    echo "Average Turnaround Time: $AvgTurnAroundTime"
}


Priority() {

    echo -e "\n\t\t\t ---------------------------------------   "
    echo -e "\t\t\t   |          Priority Scheduling        |   "
    echo -e "\t\t\t   ---------------------------------------   "

    echo -n "Enter the number of Processes: "
    read N

    Processes=()
    BurstTime=()
    Priority=()
    WaitingTime=()
    TurnAroundTime=()

    for i in $(seq 1 1 $N); do
        echo -n "Enter the name of Process $i: "
        read P
        Processes+=("$P")

        echo -n "Burst Time for $P (in units): "
        read B
        BurstTime+=("$B")

        echo -n "Priority for $P: "
        read Pr
        Priority+=("$Pr")
    done

    echo -e "\nSimulating Priority Scheduling...\n"

 
    for ((i = 0; i < ($N-1); i++)); do
        for ((j = 0; j < ($N-i-1); j++)); do
            if [ ${Priority[j]} -gt ${Priority[$((j+1))]} ]; then
               
                temp=${Priority[j]}
                Priority[$j]=${Priority[$((j+1))]}  
                Priority[$((j+1))]=$temp

               
                temp=${BurstTime[j]}
                BurstTime[$j]=${BurstTime[$((j+1))]}  
                BurstTime[$((j+1))]=$temp

               
                temp=${Processes[j]}
                Processes[$j]=${Processes[$((j+1))]}  
                Processes[$((j+1))]=$temp
            fi
        done
    done

    WaitingTime[0]=0
    TurnAroundTime[0]=${BurstTime[0]}
    TotalWaitingTime=0
    TotalTurnAroundTime=${TurnAroundTime[0]}

    echo -e "Process\t\tBurst Time\tPriority\tWaiting Time\tTurnaround Time"

  
    echo -e "${Processes[0]}\t\t${BurstTime[0]}\t\t${Priority[0]}\t\t${WaitingTime[0]}\t\t${TurnAroundTime[0]}"
    echo -n "Executing ${Processes[0]}: "
    for t in $(seq 1 1 ${BurstTime[0]}); do
        sleep 1 
        echo -n "."
    done
    echo " Complete!"

    for i in $(seq 1 1 $((N-1))); do
        WaitingTime[$i]=$((${TurnAroundTime[$((i-1))]}))
        TurnAroundTime[$i]=$((${WaitingTime[$i]} + ${BurstTime[$i]}))

        TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$i]}))
        TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$i]}))

        echo -e "${Processes[$i]}\t\t${BurstTime[$i]}\t\t${Priority[$i]}\t\t${WaitingTime[$i]}\t\t${TurnAroundTime[$i]}"
        

        echo -n "Executing ${Processes[$i]}: "
        for t in $(seq 1 1 ${BurstTime[$i]}); do
            sleep 1 
            echo -n "."
        done
        echo " Complete!"
    done

    AvgWaitingTime=$(($TotalWaitingTime / $N))
    AvgTurnAroundTime=$(($TotalTurnAroundTime / $N)) 

    echo -e "\nAverage Waiting Time: $AvgWaitingTime"
    echo "Average Turnaround Time: $AvgTurnAroundTime"
}


Robin() {

    echo -e "\n\t\t\t ---------------------------------------   "
    echo -e "\t\t\t   |              Round Robin            |   "
    echo -e "\t\t\t   ---------------------------------------   "

  echo "Enter the number of processes:"
  read n
  echo "Enter the quantum time:"
  read qt

  bt=() 
  rbt=() 
  tat=() 
  wt=()

  echo "Enter the burst time:"
  for i in $(seq 1 1 $n); do
    echo -n "Process $i : burst time:"
    read bt[$i]
    rbt[$i]=${bt[$i]}
  done

  p=$n
  pt=0

  echo -e "\nSimulating Round Robin...\n"
  echo -e "Time\tProcess\tBurst Time\tRemaining Time"

  while [[ $p -gt 0 ]]; do
    for i in $(seq 1 1 $n); do
      if [[ ${rbt[$i]} -gt 0 ]]; then
        if [[ ${rbt[$i]} -le $qt ]]; then
          pt=$((pt + rbt[$i]))
          wt[$i]=$((pt - bt[$i]))
          tat[$i]=$pt
          p=$((p - 1))

          echo -e "$pt\tP$i\t${bt[$i]}\t\t${rbt[$i]} (Completed)"
          rbt[$i]=0
        else
          pt=$((pt + qt))
          rbt[$i]=$((rbt[$i] - qt))

          echo -e "$pt\tP$i\t${bt[$i]}\t\t${rbt[$i]} (Partial)"
        fi
      fi
      sleep 1
    done
  done

  echo -e "\nProcess\tWaiting Time\tTurnaround Time"
  for i in $(seq 1 1 $n); do
    echo -e "P$i\t${wt[$i]}\t\t${tat[$i]}"
  done

  sum_wt=0
  for i in $(seq 1 1 $n); do
    sum_wt=$((sum_wt + wt[$i]))
  done
  avg_wt=$((sum_wt / n))
  echo -e "\nAverage Waiting Time: $avg_wt"

  sum_tat=0
  for i in $(seq 1 1 $n); do
    sum_tat=$((sum_tat + tat[$i]))
  done
  avg_tat=$((sum_tat / n))
  echo "Average Turnaround Time: $avg_tat"
}


multithread(){

    echo -e "\n\t\t\t ---------------------------------------   "
    echo -e "\t\t\t   |              Multithread            |   "
    echo -e "\t\t\t   ---------------------------------------   "

    get_process_info() {
    echo -n "Enter the number of Processes: "
    read N

    ProcessNames=()
    BurstTime=()

    for i in $(seq 1 1 $N); do
        echo -n "Enter Process $i (name burst_time): "
        read process_input
        IFS=' ' read -r process_name burst_time <<< "$process_input"
        ProcessNames+=("$process_name")
        BurstTime+=("$burst_time")
    done

    echo "Process Names: ${ProcessNames[@]}"
    echo "Burst Time: ${BurstTime[@]}"
}

fcf() {
    WaitingTime=()
    TurnAroundTime=()

    WaitingTime[0]=0
    TurnAroundTime[0]=${BurstTime[0]}
    TotalWaitingTime=0
    TotalTurnAroundTime=${TurnAroundTime[0]}

    for i in $(seq 0 1 $((N-1))); do
        (
            echo "Executing Process: ${ProcessNames[$i]}, Burst Time: ${BurstTime[$i]}"
            echo "Process ${ProcessNames[$i]} is running..."
            sleep ${BurstTime[$i]}
            echo "Process ${ProcessNames[$i]} completed."

            if [ $i -lt $((N-1)) ]; then
                WaitingTime[$((i+1))]=$((${TurnAroundTime[$i]}))
                TurnAroundTime[$((i+1))]=$((${WaitingTime[$((i+1))]} + ${BurstTime[$((i+1))]}))


                TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$((i+1))]}))
                TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$((i+1))]}))
            fi
        ) &
    done
    wait

    AvgWaitingTime=$(($TotalWaitingTime / $N))
    AvgTurnAroundTime=$(($TotalTurnAroundTime / $N))

    echo " "
    echo " "
}

sj() {
    for ((i = 0; i < N; i++)); do
        for ((j = 0; j < N - i - 1; j++)); do
            if [ "${BurstTime[$j]}" -gt "${BurstTime[$((j+1))]}" ]; then
                temp="${BurstTime[$j]}"
                BurstTime[$j]="${BurstTime[$((j+1))]}"
                BurstTime[$((j+1))]=$temp

                temp="${ProcessNames[$j]}"
                ProcessNames[$j]="${ProcessNames[$((j+1))]}"
                ProcessNames[$((j+1))]=$temp
            fi
        done
    done

    echo "Sorted Process Names: ${ProcessNames[@]}"
    echo "Sorted Burst Time: ${BurstTime[@]}"

    WaitingTime=()
    TurnAroundTime=()

    WaitingTime[0]=0
    TurnAroundTime[0]=${BurstTime[0]}
    TotalWaitingTime=0
    TotalTurnAroundTime=${TurnAroundTime[0]}

    for i in $(seq 0 1 $((N-1))); do
        (
            echo "Executing Process: ${ProcessNames[$i]}, Burst Time: ${BurstTime[$i]}"
            echo "Process ${ProcessNames[$i]} is running..."
            sleep ${BurstTime[$i]}
            echo "Process ${ProcessNames[$i]} completed."

            if [ $i -lt $((N-1)) ]; then
                WaitingTime[$((i+1))]=$((${TurnAroundTime[$i]}))
                TurnAroundTime[$((i+1))]=$((${WaitingTime[$((i+1))]} + ${BurstTime[$((i+1))]}))


                TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$((i+1))]}))
                TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$((i+1))]}))
            fi
        ) &
    done
    wait

    AvgWaitingTime=$(($TotalWaitingTime / $N))
    AvgTurnAroundTime=$(($TotalTurnAroundTime / $N))

    
    
}
get_process_info
fcf
sj
echo " "
}

Deadlock(){

    echo -e "\n\t\t\t ---------------------------------------   "
    echo -e "\t\t\t   |         Banker's Algorithm          |   "
    echo -e "\t\t\t   ---------------------------------------   "

    takeInputAndCalculateNeedMatrix() {
    echo -n "Enter total number of processes: "
    read n
    echo -n "Enter total number of resources: "
    read m

    for ((i = 0; i < n; i++)); do
        echo -e "\nProcess $((i + 1))"
        for ((j = 0; j < m; j++)); do
            echo -n "Allocation for resource $((j + 1)): "
            read A[$i,$j]
            echo -n "Maximum for resource $((j + 1)): "
            read M[$i,$j]
        done
    done

    echo -e "\nAvailable resources:"
    for ((i = 0; i < m; i++)); do
        echo -n "Resource $((i + 1)): "
        read W[0,$i]
    done

    for ((i = 0; i < n; i++)); do
        for ((j = 0; j < m; j++)); do
            N[$i,$j]=$((M[$i,$j] - A[$i,$j]))
        done
    done
}

safety() {
    local F=()
    local W=("${W[@]}")  

    for ((i = 0; i < n; i++)); do
        F[$i]=0
    done

    for ((k = 0; k < n; k++)); do
        for ((i = 0; i < n; i++)); do
            if [[ ${F[$i]} -eq 0 ]]; then
                local f2=0
                for ((j = 0; j < m; j++)); do
                    if [[ ${N[$i,$j]} -gt ${W[$j]} ]]; then
                        f2=1
                        break
                    fi
                done

                if [[ $f2 -eq 0 ]]; then
                    for ((j = 0; j < m; j++)); do
                        W[$j]=$((W[$j] + A[$i,$j]))
                    done
                    F[$i]=1
                fi
            fi
        done
    done

    for ((i = 0; i < n; i++)); do
        if [[ ${F[$i]} -eq 0 ]]; then
            return 1  
        fi
    done

    return 0 
}

takeInputAndCalculateNeedMatrix
safety

if [[ $? -eq 0 ]]; then
    echo -e "\nIt is safe to allocate resources."
else
    echo -e "\nDeadlock has occurred."
fi
}


mft(){

    echo -e "\n\t\t\t ------------------------------------------------------------- "
    echo -e "\t\t\t   |        Multiprogramming with a Fixed number of Tasks      | "
    echo -e "\t\t\t   ------------------------------------------------------------- "

echo -n "Enter the total memory available (in Bytes): "
read ms

echo -n "Enter the block size (in Bytes): "
read bs

nob=$((ms / bs))
ef=$((ms - nob * bs))

echo -n "Enter the number of processes: "
read n

echo ""

for ((i = 0; i < n; i++))
do
    echo -n "Enter memory required for process $((i + 1)) (in Bytes): "
    read mp[i]
done

echo -e "\nNo. of Blocks available in memory: $nob"
echo -e "\nPROCESS\t\tMEMORY REQUIRED\t\tALLOCATED\tINTERNAL FRAGMENTATION"

p=0
tif=0

for ((i = 0; i < n && p < nob; i++))
do
    echo -e "$((i + 1))\t\t${mp[i]}\c"
    
    if [ "${mp[i]}" -gt "$bs" ]; then
        echo -e "\t\t\tNO\t\t"
    else
        echo -e "\t\t\tYES\t\t$((bs - mp[i]))"
        tif=$((tif + bs - mp[i]))
        p=$((p + 1))
    fi
done

if [ "$i" -lt "$n" ]; then
    echo -e "\nMemory is Full, Remaining Processes cannot be accommodated"
fi

echo -e "\nTotal Internal Fragmentation is $tif"
echo -e "Total External Fragmentation is $ef"
}


function mvt() {

    echo -e "\n\t\t\t -------------------------------------------------------------- "
    echo -e "\t\t\t   |        Multiprogramming with Variable number of Tasks      | "
    echo -e "\t\t\t   -------------------------------------------------------------- "

    echo -n "Enter the number of Blocks: "
    read numBlocks

    blockSizes=()
    for ((i = 0; i < numBlocks; i++)); do
        echo -n "Block $((i + 1)) size (in Bytes): "
        read size
        blockSizes+=("$size")
    done

    echo -n "Enter the number of Processes: "
    read numProcesses

    processSizes=()
    for ((i = 0; i < numProcesses; i++)); do
        echo -n "Enter memory required for process $((i + 1)) (in Bytes): "
        read size
        processSizes+=("$size")
    done

    echo -e "\nAlgorithm\tInternal Frag\tAllocation\t\t\tBlock Sizes\t\t\tProcess Sizes"

    declare -A internalFragments
    declare -A allocations
    algorithms=("First Fit" "Best Fit" "Worst Fit")

    for algorithm in "${algorithms[@]}"; do
        internalF=0
        blockSizesCopy=("${blockSizes[@]}")

        for ((i = 0; i < numProcesses; i++)); do
            if [ "$algorithm" == "First Fit" ]; then
                fitBlockFirstFit $i
            elif [ "$algorithm" == "Best Fit" ]; then
                fitBlockBestFit $i
            elif [ "$algorithm" == "Worst Fit" ]; then
                fitBlockWorstFit $i
            fi

            if [ "${fitIndex}" -ne -1 ]; then
                internalF=$((internalF + blockSizesCopy[fitIndex] - processSizes[i]))
                blockSizesCopy[fitIndex]=-1
                allocations["$algorithm,$i"]="Block $((fitIndex + 1))"
            fi
        done

        internalFragments["$algorithm"]=$internalF
        echo -e "$algorithm\t$internalF\t\t${allocations["$algorithm,0"]},${allocations["$algorithm,1"]},${allocations["$algorithm,2"]}\t\t${blockSizes[@]}\t\t\t${processSizes[@]}"
    done

    suggestBestFit
}

function fitBlockFirstFit {
    local processIndex=$1
    fitIndex=-1

    for ((j = 0; j < numBlocks; j++)); do
        if [ "${blockSizesCopy[j]}" -ge "${processSizes[processIndex]}" ]; then
            fitIndex=$j
            break
        fi
    done
}

function fitBlockBestFit {
    local processIndex=$1
    fitIndex=-1

    minSize=-1
    for ((j = 0; j < numBlocks; j++)); do
        if [ "${blockSizesCopy[j]}" -ge "${processSizes[processIndex]}" ]; then
            if [ "$fitIndex" -eq -1 ] || [ "${blockSizesCopy[j]}" -lt "$minSize" ]; then
                fitIndex=$j
                minSize=${blockSizesCopy[j]}
            fi
        fi
    done
}

function fitBlockWorstFit {
    local processIndex=$1
    fitIndex=-1

    maxSize=-1
    for ((j = 0; j < numBlocks; j++)); do
        if [ "${blockSizesCopy[j]}" -ge "${processSizes[processIndex]}" ]; then
            if [ "$fitIndex" -eq -1 ] || [ "${blockSizesCopy[j]}" -gt "$maxSize" ]; then
                fitIndex=$j
                maxSize=${blockSizesCopy[j]}
            fi
        fi
    done
}

function suggestBestFit {
    minFrag=-1
    bestFit=""

    if [ "${internalFragments["First Fit"]}" -eq "${internalFragments["Best Fit"]}" ] && \
       [ "${internalFragments["Best Fit"]}" -eq "${internalFragments["Worst Fit"]}" ]; then
        echo -e "\n\t\t\t ---------------------------------------   "
        echo -e "\t\t\t   | You can choose any of the algorithm |   "
        echo -e "\t\t\t   ---------------------------------------   "
    else
        for algorithm in "${algorithms[@]}"; do
            if [ "$minFrag" -eq -1 ] || [ "${internalFragments[$algorithm]}" -lt "$minFrag" ]; then
                minFrag=${internalFragments[$algorithm]}
                bestFit=$algorithm
            fi
        done

        sleep 1
        echo -e "\n\t\t   -----------------------------------------------------------  "
        echo -e "\t\t\t   | Suggested Best Algorithm for This Scenario is: $bestFit |      "
        echo -e "\t\t\t   -----------------------------------------------------------   "

    fi
}


p=1
t=0
while [ $p ]
do 
echo    "               ----------------------------------------------------------------               "
echo -e "---------------| Welcome To Process Scheduling & Mmemory Management Technique |---------------"
echo    "               ----------------------------------------------------------------               "
echo -e "                                                                                              "
echo -e "                                                                                              "
echo    "               ----------------------------------------------------------------               "
echo -e "---------------| 1-CPU ALGORITHMS                                             |---------------"
echo -e "---------------| 2-Banker’s Algorithm and Deadlock Avoidance                  |---------------"
echo -e "---------------| 3-Simulating the MFT and MVT Memory Management Techniques    |---------------"
echo -e "---------------| 4-Exit                                                       |---------------"
echo    "               ----------------------------------------------------------------               "
echo -n "Please Enter Your Choice: "
read s 
echo " "
echo " "
k=0
case $s in
1 | "cpu" | "cpu algorithm")
echo    "               --------------------------------------------------------------------------------               "
echo -e "---------------| ***CPU ALGORITHMS***                                                         |---------------"
echo -e "---------------|                                                                              |---------------"
echo -e "---------------| 1-First Come First Served Scheduling Algorithm                               |---------------"
echo -e "---------------| 2-Shortest Job First Scheduling Algorithm                                    |---------------"
echo -e "---------------| 3-Priority Scheduling Algorithm                                              |---------------"
echo -e "---------------| 4-Round Robin Scheduling Algorithm                                           |---------------"
echo -e "---------------| 5-Multi-Threaded First Come First Served and Shortest Job First Algorithm    |---------------"
echo -e "---------------| 6-Back to Main Menu                                                          |---------------"
echo -e "---------------| 7-Exit                                                                       |---------------"
echo    "               --------------------------------------------------------------------------------               "

echo -n "Please Enter Your Choice: "
read choice
echo " "

case $choice in
    1 | "fcfs" | "FCFS")
    fcfs
    echo ""
    ;;
    2 | "sjf" | "SJF")
    sjf
    echo ""
    ;;
    3 | "priority" | "PRIORITY")
    priority
    echo ""
    ;;
    4 | "round" | "ROUND")
    Robin
    echo ""
    ;;
    5 | "multithread" | "multithread")
    multithread
    echo ""
    ;;
    6 | "menu" | "MENU")
    clear
    echo ""
    continue 
    ;;
    7 | "exit" | "EXIT")
    echo "Exit"
    exit
    ;;
    *)
    echo "Enter a valid serial number !!!"
    ;;
esac

;;

2 | "Banker" | "Banker Algorithm")
echo    "               -------------------------------------------------------------------               "
echo -e "---------------| ***Banker’s Algorithm and Deadlock Avoidance***                 |---------------"
echo -e "---------------| 1-Run Banker’s Algorithm and Deadlock Avoidance                 |---------------"
echo -e "---------------| 2-Back to Main Menu                                             |---------------"
echo -e "---------------| 3-Exit                                                          |---------------"
echo    "               -------------------------------------------------------------------               "

echo -n "Please Enter Your Choice: "
read choice
echo " "

case $choice in
  1 | "Banker" | "Banker Algorithm")
    Deadlock
    echo ""
    ;;
  2 | "menu" | "MENU")
    clear
    echo ""
    continue 
    ;;
  2 | "exit" | "EXIT")
    echo "Exit"
    exit
    ;;
  *)
    echo "Enter a valid serial number !!!"
    ;;
esac

;;

3 | "memory" | "memory management")
echo    "               -------------------------------------------------------------------               "
echo -e "---------------| ***Simulating the MFT and MVT Memory Management Techniques***   |---------------"
echo -e "---------------| 1-MFT Memory Management Techniques                              |---------------"
echo -e "---------------| 2-MVT Memory Management Techniques                              |---------------"
echo -e "---------------| 3-Back to Main Menu                                               |---------------"
echo -e "---------------| 4-Exit                                                             |---------------"
echo    "               -------------------------------------------------------------------               "

echo -n "Please Enter Your Choice: "
read choice
echo " "

case $choice in
    1 | "mft" | "MFT")
    mft
    echo ""
    ;;
    2 | "mvt" | "MVT")
    mvt
    echo ""
    ;;
    3 | "menu" | "MENU")
    clear
    echo ""
    continue 
    ;;
  4 | "exit" | "EXIT")
    echo "Exit"
    exit
    ;;
  *)
    echo "Enter a valid serial number !!!"
    ;;
esac
;;

4 | "exit" | "EXIT")
t=1
;;
*)
echo "Enter a valid serial number !!!"
esac

if [ $t -eq 1 ]
then
break
fi

done
