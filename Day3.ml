let rec parse instructions =
  let prefix = "mul(" in
  if instructions = "" then 0
  else if not (String.starts_with ~prefix instructions) then
    parse (String.sub instructions 1 (String.length instructions - 1))
  else
    let without_mul =
      String.sub instructions (String.length prefix)
        (String.length instructions - String.length prefix)
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

let () =
  try
    let instructions = Sys.argv.(1) in
    print_endline instructions;
    print_int (parse instructions)
  with Invalid_argument _ ->
    print_endline "Please provide the string as an argument"
