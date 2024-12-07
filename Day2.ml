let rec reports source =
  try
    let report = input_line source in
    if report = "" then []
    else
      List.map int_of_string (String.split_on_char ' ' report) :: reports source
  with End_of_file -> []

let rec safe report =
  let rec without_last_elem l =
    match l with
    | [] -> raise (Invalid_argument "empty set")
    | hd :: [] -> []
    | hd :: tl -> hd :: without_last_elem tl
  in
  match report with
  | [] | _ :: [] -> true
  | s :: remainder ->
      let diff =
        List.map2
          (fun bef aft -> bef - aft)
          (without_last_elem report) remainder
      in
      print_endline (String.concat " " (List.map string_of_int diff));
      List.for_all (fun x -> 1 <= abs x && abs x <= 3) diff
      && List.for_all
           (if List.hd diff > 0 then fun x -> x > 0 else fun x -> x < 0)
           diff

let () =
  (* Import the data *)
  print_endline "Where should I read the reports ? [stdin/<filename>]";
  let source =
    match read_line () with "stdin" -> stdin | filename -> open_in filename
  in

  let reports = reports source in
  print_int (List.length (List.filter safe reports))
