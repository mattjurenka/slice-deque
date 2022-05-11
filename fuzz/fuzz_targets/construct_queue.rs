#![no_main]
use libfuzzer_sys::fuzz_target;

use slice_deque;

fuzz_target!(|data: &[u8]| {
    // fuzzed code goes here
    let mut slice = slice_deque::sdeq![data, data, data];
    let mut slice2 = slice_deque::sdeq![data, data, data];
    let _ = slice.len();
    slice.push_back(data);
    let _ = slice.append(&mut slice2);
});
