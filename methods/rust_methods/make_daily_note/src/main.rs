use std::path::Path;
use std::{fs::OpenOptions, env::var };
use std::io::prelude::*;
use chrono::{self};
fn main() {
    let now = chrono::Local::now();
    let home = var("HOME").expect("~"); 
    let note_location = Path::new(&home).join("workspace/notes/daily_notes").join(now.format("%Y-%m-%d.md").to_string());
    let file = OpenOptions::new()
        .write(true)
        .create_new(true) // will not over-write existing file 
        .open(&note_location);
    if let Ok(mut f) = file {
          f.write_all(b"TODO:\n- [ ]\n").expect("failed to write");
          println!("Created daily note at {}", note_location.display());
    } else {
            println!("{} already exists", note_location.display());
    }
}

