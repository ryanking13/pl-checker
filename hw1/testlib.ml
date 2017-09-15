let correctSymbol =
    "\x1b[32m✓\x1b[37m"

let wrongSymbol =
    "\x1b[31m✗\x1b[37m"

let string_of_case (n: int) =
    "Case " ^ (string_of_int n)

let string_of_frac (a, b) =
    (string_of_int a) ^ " / " ^ (string_of_int b)

let res_string (cor: bool) (n: int) =
    let sym = if cor then correctSymbol else wrongSymbol in
        sym ^ " " ^ (string_of_case n)

let rate_of_result res =
    (List.length (List.filter (fun x -> x) res), List.length res)

let print_result res =
    let rec print_result_ res pass total =
        match res with
        | [] -> print_endline ("Passed " ^ (string_of_frac (pass, total)))
        | h::res' ->
                let _ = print_endline (res_string h (total+1))
                in if h then print_result_ res' (pass+1) (total+1)
                else print_result_ res' pass (total+1)
    in print_result_ res 0 0

let print_summary rs num =
    let rec print_summary_ rs num =
        match rs with
        | [] -> ()
        | h::t ->
                match rate_of_result h with
                | (a, b) ->
                        let _ =
                            if a = b then print_endline correctSymbol
                            else print_string wrongSymbol
                        in print_summary_ t (num+1)
    in print_summary_ rs 1
