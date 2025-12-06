module main

import os

fn main() {

	for i in os.args[1..] {
		list_folder(i, "")
	}

}

fn list_folder(napath string, indent string) {
	mut path := os.abs_path(napath)
	println(indent+"=> ${path} contains:")
	for i in ( os.ls(path) or {[]} ) {
		print(indent+"${path}/${i}")
		if os.is_dir("${path}/${i}") {
			println(" <= Which is a directory")
			list_folder("${path}/${i}", indent+"\t")
		} else {
			println("")
		}
	}
}