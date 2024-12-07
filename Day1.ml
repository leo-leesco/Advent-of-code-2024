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

let rec reduce sorted =
  match sorted with
  | [] -> []
  | small :: tail -> (
      match reduce tail with
      | (largest_yet, count) :: rest when largest_yet = small ->
          (small, count + 1) :: rest
      | reduced -> (small, 1) :: reduced)

let debug_reduced reduced =
  List.iter
    (fun (v, c) ->
      print_endline (string_of_int v ^ " : " ^ string_of_int c ^ " times"))
    reduced

let rec similarity left_reduced right_reduced =
  match (left_reduced, right_reduced) with
  | [], _ | _, [] -> 0
  | (left, lcount) :: l_reduced, (right, rcount) :: r_reduced ->
      (*print_string*)
      (*  ("left:" ^ string_of_int left ^ " : " ^ string_of_int lcount ^ " times");*)
      (*print_endline*)
      (*  ("/right:" ^ string_of_int right ^ " : " ^ string_of_int rcount*)
      (* ^ " times");*)
      if left = right then
        (left * lcount * rcount) + similarity l_reduced r_reduced
      else if left > right then similarity left_reduced r_reduced
      else similarity l_reduced right_reduced

let () =
  (* Import the data *)
  print_endline "Where should I read the lists ? [stdin/<filename>]";
  let source =
    match read_line () with "stdin" -> stdin | filename -> open_in filename
  in
  let left, right = lists source in

  (* Sanitize, this is of complexity O(log n) *)
  let left = List.sort compare left in
  let right = List.sort compare right in

  (* This is of complexity O(n) so the total runtime is O(n + log n) = O(n) *)
  let distance =
    List.fold_left2 (fun dist l r -> dist + abs (l - r)) 0 left right
  in
  print_endline ("Distance : " ^ string_of_int distance);

  let left_red = reduce left in
  let right_red = reduce right in
  print_endline ("Similarity : " ^ string_of_int (similarity left_red right_red))
