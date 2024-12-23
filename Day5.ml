let rec rules source =
  try
    let rule = input_line source in
    if rule = "" then []
    else List.map int_of_string (String.split_on_char '|' rule) :: rules source
  with End_of_file -> []

let rec updates source =
  try
    let update = input_line source in
    if update = "" then []
    else
      List.map int_of_string (String.split_on_char ',' update) :: updates source
  with End_of_file -> []

let rec is_valid_update rules update =
  match update with
  | [] -> true
  | p :: rest ->
      let p_rules =
        List.map List.hd (List.filter (fun rule -> List.nth rule 1 = p) rules)
      in
      (* we keep all rules that state that p should be after a number, which invalidates the update since p is in first place*)
      (not
         (List.exists
            (fun q -> List.exists (fun page -> page = q) rest)
            p_rules))
      && is_valid_update rules rest

let middle_value update = List.nth update (List.length update / 2)

let rec count_valid rules updates =
  match updates with
  | [] -> 0
  | update :: rest ->
      (if is_valid_update rules update then middle_value update else 0)
      + count_valid rules rest

let rec rectified rules update =
  if is_valid_update rules update then update
  else
    match update with
    | [] -> []
    | p :: rest -> (
        match rectified rules rest with
        | [] -> [ p ]
        | n :: rest ->
            if List.exists (fun rule -> rule = [ p; n ]) rules then
              p :: rectified rules (n :: rest)
            else n :: rectified rules (p :: rest))

let rec count_rectified rules updates =
  match updates with
  | [] -> 0
  | update :: rest ->
      (if is_valid_update rules update then 0
       else
         let rect = rectified rules update in
         (*print_endline (String.concat "," (List.map string_of_int rect));*)
         middle_value rect)
      + count_rectified rules rest

let () =
  (* Import the data *)
  print_endline "Where should I read the rules and updates ? [stdin/<filename>]";
  let source =
    match read_line () with "stdin" -> stdin | filename -> open_in filename
  in

  let rules = rules source in
  let updates = updates source in

  print_int (count_valid rules updates);
  print_newline ();
  print_int (count_rectified rules updates)
