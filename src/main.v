module main

import os

fn main() {

	for i in os.args[1..] {
		list_folder(i, "")
	}

}

fn list_folder(napath string, indent string) {
	mut path := os.abs_path(napath)

	if (os.ls(path) or {[]}).len == 0 {
		println(indent+"Directory ${napath} is empty")
		return
	}

	println(indent+"=> ${path} contains:")
	for i in ( os.ls(path) or {[]} ) {
		print(indent+"/${i}")
		if os.is_dir("${path}/${i}") {
			println(" <= Which is a directory")
			list_folder("${path+"/"+i}", indent+" ")
		} else {
			println("")
		}
	}
}