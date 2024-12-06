let rec lists source =
  try
    let line = input_line source in
    if line = "" then ([], [])
    else
      let first_blank = String.index line ' ' in
      let left = String.sub line 0 first_blank in
      let right =
        String.trim
          (String.sub line first_blank (String.length line - first_blank))
      in
      let list_left, list_right = lists source in
      (int_of_string left :: list_left, int_of_string right :: list_right)
  with End_of_file -> ([], [])

let () =
  print_endline "Where should I read the lists ? [stdin/<filename>]";
  let source =
    match read_line () with "stdin" -> stdin | filename -> open_in filename
  in
  let left, right = lists source in
  let left = List.sort compare left in
  let right = List.sort compare right in
  let distance =
    List.fold_left2 (fun dist l r -> dist + abs (l - r)) 0 left right
  in
  print_int distance
