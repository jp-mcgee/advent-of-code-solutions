#!/bin/bash

part_1() {
    # get the ranges available
    mapfile -t input_arr < $1
    RANGE_DELIM='-'
    start_ids=0
    arr_len="${#input_arr[@]}"
    ranges=()
    for range_entry in "${input_arr[@]}"; do
        min_r=$(echo "$range_entry" | cut -d"$RANGE_DELIM" -sf1)
        max_r=$(echo "$range_entry" | cut -d"$RANGE_DELIM" -sf2)
        ((++start_ids))
        if [[ -z $min_r ]]; then
            break
        fi
        ranges+=($min_r $max_r)
    done

    total_sum=0
    num_ids=$(($arr_len - $start_ids))
    for id in "${input_arr[@]:$start_ids:$num_ids}"; do
        range_idx=0
        while [ $range_idx -lt ${#ranges[@]} ]; do
            if [ $id -ge ${ranges[$range_idx]} ]; then
                local max_range=$(($range_idx + 1))
                if [ $id -le ${ranges[$max_range]} ]; then
                    ((++total_sum))
                    break
                fi
            fi
            range_idx=$(($range_idx + 2))
        done
    done
    
    echo "$total_sum"
}

part_2() {
    # get the ranges available
    mapfile -t input_arr < $1
    RANGE_DELIM='-'
    total_sum=0

    mins=()
    maxs=()
    for range_entry in "${input_arr[@]}"; do
        min_r=$(echo "$range_entry" | cut -d"$RANGE_DELIM" -sf1)
        max_r=$(echo "$range_entry" | cut -d"$RANGE_DELIM" -sf2)
        if [[ -z $min_r ]]; then
            break
        fi
        mins+=($min_r)
        maxs+=($max_r)
    done

    # sort
    IFS=$'\n' mins=($(sort -n <<<"${mins[*]}"))
    maxs=($(sort -n <<<"${maxs[*]}"))
    unset IFS

    # merge
    range_idx=1
    prev_min=${mins[0]}
    prev_max=${maxs[0]}
    merged=()
    while [ $range_idx -lt ${#mins[@]} ]; do
        if [ "$prev_max" -ge "${mins[$range_idx]}" ]; then
            prev_max=${maxs[$range_idx]}
        else
            merged+=($prev_min $prev_max)
            prev_min=${mins[$range_idx]}
            prev_max=${maxs[$range_idx]}
        fi
        ((++range_idx))
    done
    # add last group
    merged+=($prev_min $prev_max)

    # sum merged
    range_idx=0
    while [ $range_idx -lt ${#merged[@]} ]; do
        m0=${merged[$range_idx]}
        ((++range_idx))
        m1=${merged[$range_idx]}
        ((++range_idx))
        ((total_sum+=$m1-$m0+1))
    done

    echo "$total_sum"
}

if [[ $# -lt 1 ]]; then
  exit 1
fi

part_1 $1
part_2 $1