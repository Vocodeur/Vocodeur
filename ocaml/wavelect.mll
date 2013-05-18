{
open Lexing

let chunk_size = ref 0
let chunk_byte = ref 0
let format = ref 0
let nb_channel = ref 0 
let sampling_rate = ref 0 
let data_rate = ref 0 
let data_block_size = ref 0 
let bits_per_sample = ref 0

let convert_int s = 
	let k = ref 0 in 
	for i = String.length s  -1 downto 0 do
	k := 256 * !k + int_of_char (s.[i]) ;
	done ;
!k

let print_info () = 
	Format.printf "Caracteristiques du fichier :\n chunk size : %d\n bits per sample : %d\n number of channels : %d\n sampling rate : %d\n data rate : %d\n data block size : %d@."
			!chunk_size !chunk_byte !nb_channel !sampling_rate !data_rate !data_block_size

let int_of_byte s = (*convertit la suite de caractère en entier, convention little endian, complément à deux*)
	let k = ref 0 in 
	for i = String.length s -1 downto 0 do 
		k := 256 * !k + int_of_char (s.[i]) ;
	done ;
	let n_max = 1 lsl (8*String.length s -1) in 
	(!k mod (n_max)) - (!k / n_max) * n_max
			
}

let mot = (_ _ _ _) 
let demimot = (_ _)

rule header = parse 
	| "RIFF" (mot as tailles) "WAVEfmt " (mot as chunksizes) (demimot as code_formats) (demimot as nb_channels) 
		(mot as sampling_rates) (mot as data_rates) (demimot as data_block_sizes) (demimot as bits_per_samples)  "data" (mot as chunk_sizes2)
			{
			chunk_size := convert_int tailles +8-44 ;
			assert (!chunk_size = convert_int chunk_sizes2) ;
			chunk_byte := convert_int chunksizes ;
			format := convert_int code_formats ;
			nb_channel := convert_int nb_channels ;
			sampling_rate := convert_int sampling_rates ;
			data_rate := convert_int data_rates ;
			data_block_size := convert_int data_block_sizes ;
			bits_per_sample := convert_int bits_per_samples ;
			}
	| _ {failwith "invalid header"}

and data n = parse (*convention 16 bits, 2 channels retourne une liste de taille n contenant les paires de valeures gauche/droite*)
	| (demimot as left) (demimot as right) {
			if n mod 1000 = 0 then 
				Lexing.flush_input lexbuf ;
			if n > 1 then 
				(int_of_byte left, int_of_byte right)::(data (n-1) lexbuf)
			else 
			[int_of_byte left, int_of_byte right]
			}
	| _ | eof {Lexing.flush_input lexbuf ; data n lexbuf } 
	

{

let draw l = 
	let v = Array.of_list l in 
	Graphics.open_graph "" ;
	for i = 0 to Array.length v -1 do 
		if i mod 600 = 0 then 
			(
			Unix.sleep 1 ;
			Graphics.clear_graph () ;
			Graphics.moveto 0 (400 + v.(i)/256) ;
			)
		else 
		Graphics.lineto (i mod 600) (400 + v.(i)/256) ;
	done

let main() = 
	let file = ref "" in 
	Arg.parse [] (fun s -> file := s) "" ;
	let in_c = open_in !file in 
	let lexbuf = Lexing.from_channel in_c in 
	header lexbuf ; 
	print_info () 
	
let () = main()


}