import os
import readline { read_line }

fn main() {

	if !os.is_writable("/usr/local/bin") {
		println("You must be a superuser");
		exit(1);
	}

	install_folder := "/usr/local/bin"
	src_dir := os.abs_path(".") + "/src/"

	if !os.exists(install_folder) {
		os.mkdir(install_folder)!;
		if !os.exists(install_folder) {
			println("Error in acces ${install_folder}")
			exit(1)
		}
	}
	print("Compile files in ${src_dir} and copy result to ${install_folder}\n");

	if read_line("It's ok? [y/N]")! != "y" {
		println("Aborted by user...")
		exit(1)
	}

	print("Compiling...")
	os.execute("v -prod ${src_dir} -o /tmp/lr.bin")
	print("[Ok]\nMaking executable...[1/2]")
	if os.execute("cp /tmp/lr.bin /usr/local/bin/lr").exit_code != 0 {
		println("\rMaking executable...[Er] \nError while installing file...")
		exit(1)
	}
	print("\rMaking executable...[2/2]")
	os.chmod(install_folder+"/lr", 0o777) or {
		println("\rMaking executable...[Er] \nCan't permit executable rights");
		exit(1);
	};
	println("\rMaking executable...[Ok] ")

}