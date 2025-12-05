use std::{env, fs, process};

fn get_start_end_ids(range: &str) -> (u64, u64) {
    let mut split_range = range.splitn(2,'-');
    let start = split_range.next().unwrap()
        .parse::<u64>().unwrap();
    let end = split_range.next().unwrap()
        .parse::<u64>().unwrap();
    return (start, end);
}

fn part_1(id_ranges: Vec<&str>) -> u64 {
    let mut sum: u64 = 0;

    // iterate through ID ranges
    for id_range in id_ranges {
        let (start, end) = get_start_end_ids(id_range);
        // go through range of IDs
        for id in start..=end {
            let curr_id = id.to_string();
            let mid = curr_id.len()/2;
            // compare halves
            if curr_id[..mid] == curr_id[mid..] && mid > 0 {
                sum += id;
            }
        }
    }

    return sum;
}

fn part_2(id_ranges: Vec<&str>) -> u64 {
    let mut sum: u64 = 0;

    // iterate through ID ranges
    for id_range in id_ranges {
        let (start, end) = get_start_end_ids(id_range);
        // go through range of IDs
        for id in start..=end {
            let curr_id = id.to_string();
            // check the number of times a substring repeats
            // if it is equal to the length of the ID string / length of the substring, break and continue
            for substr_len in 1..=curr_id.len() / 2 {
                let matching_str = &curr_id[0..substr_len];
                if curr_id.matches(&matching_str).count() == curr_id.len() / substr_len && curr_id.len() % substr_len == 0 {
                    sum += id;
                    break;
                }
            }
        }
    }

    return sum;
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        process::exit(1);
    }

    // file input and formatting
    let input_file = &args[1];
    let input_str = fs::read_to_string(input_file)
        .unwrap();
    let id_entries: Vec<&str> = input_str.split(',')
        .map(
            |s| s.trim()
        )
        .collect();

    println!("part 1: {}", part_1(id_entries.clone()));
    println!("part 2: {}", part_2(id_entries));
}
