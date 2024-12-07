let rec parse instructions =
  let mul_pre = "mul(" in

  if instructions = "" then 0
  else if not (String.starts_with ~prefix:mul_pre instructions) then
    parse (String.sub instructions 1 (String.length instructions - 1))
  else
    let without_mul =
      String.sub instructions (String.length mul_pre)
        (String.length instructions - String.length mul_pre)
    in
    match
      (String.index_opt without_mul ',', String.index_opt without_mul ')')
    with
    | Some comma, Some paren when comma < paren -> (
        match
          ( int_of_string_opt (String.sub without_mul 0 comma),
            int_of_string_opt
              (String.sub without_mul (comma + 1) (paren - (comma + 1))) )
        with
        | Some n, Some m ->
            (n * m)
            + parse
                (String.sub without_mul (paren + 1)
                   (String.length without_mul - (paren + 1)))
        | _ -> parse without_mul)
    | _ -> parse without_mul

let rec parse_refined instructions ?(enabled = true) () =
  let mul_pre = "mul(" in
  let do_pre = "do()" in
  let dont_pre = "don't()" in

  if instructions = "" then 0
  else if String.starts_with ~prefix:do_pre instructions then
    parse_refined
      (String.sub instructions (String.length do_pre)
         (String.length instructions - String.length do_pre))
      ()
  else if String.starts_with ~prefix:dont_pre instructions then
    parse_refined
      (String.sub instructions (String.length dont_pre)
         (String.length instructions - String.length dont_pre))
      ~enabled:false ()
  else if enabled && String.starts_with ~prefix:mul_pre instructions then
    let without_mul =
      String.sub instructions (String.length mul_pre)
        (String.length instructions - String.length mul_pre)
    in
    match
      (String.index_opt without_mul ',', String.index_opt without_mul ')')
    with
    | Some comma, Some paren when comma < paren -> (
        match
          ( int_of_string_opt (String.sub without_mul 0 comma),
            int_of_string_opt
              (String.sub without_mul (comma + 1) (paren - (comma + 1))) )
        with
        | Some n, Some m ->
            (n * m)
            + parse_refined
                (String.sub without_mul (paren + 1)
                   (String.length without_mul - (paren + 1)))
                ~enabled:true ()
        | _ -> parse_refined without_mul ())
    | _ -> parse_refined without_mul ()
  else
    parse_refined
      (String.sub instructions 1 (String.length instructions - 1))
      ~enabled ()

let () =
  try
    let instructions = Sys.argv.(1) in
    print_int (parse instructions);
    print_newline ();
    print_int (parse_refined instructions ())
  with Invalid_argument _ ->
    print_endline "Please provide the string as an argument"
