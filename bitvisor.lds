ENTRY(entry)
virt = 0x40100000;
phys = 0x00100000;
PHDRS {
	hdrs PT_PHDR PHDRS AT (phys);
	all PT_LOAD;
}
SECTIONS {
	. = virt;
	head = .;
	. = virt + SIZEOF_HEADERS;
	.text : AT (phys + (code - head)) {
		code = .;
		*(.entry)
		*(.text)
		codeend = .;
	} :all
	.data : AT (phys + (data - head)) {
		data = .;
		*(.data)
		. = ALIGN (8);
                __initfunc_start = .;
                *(.initfunc)
                __initfunc_end = .;
		__process_builtin = .;
		*(.processes)
		__process_builtin_end = .;
	/* }
	.bss : AT (phys + (bss - head)) { */
		bss = .;
		*(.bss)
		*(COMMON)
		. = ALIGN (4096);
	}
	end = .;
	/DISCARD/ : {
		*(.gomi)
	}
}
