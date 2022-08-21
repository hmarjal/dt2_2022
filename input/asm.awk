BEGIN {
    opcodes["MOVA"] = "0000000";
    opcodes["INC"] = "0000001";
    opcodes["ADD"] = "0000010";
    opcodes["MUL"] = "0000011";
    opcodes["SRA"] = "0000100";
    opcodes["SUB"] = "0000101";
    opcodes["DEC"] = "0000110";
    opcodes["SLA"] = "0000111";
    opcodes["AND"] = "0001000";
    opcodes["OR"] = "0001001";
    opcodes["XOR"] = "0001010";
    opcodes["NOT"] = "0001011";
    opcodes["MOVB"] = "0001100";
    opcodes["SHR"] = "0001101";
    opcodes["SHL"] = "0001110";
    opcodes["CLR"] = "0001111";
    opcodes["LDI"] = "1001100";
    opcodes["ADI"] = "1000010";
    opcodes["LD"] = "0010000";
    opcodes["ST"] = "0100000";
    opcodes["BRZ"] = "1100000";
    opcodes["BRN"] = "1100001";
    opcodes["JMP"] = "1110000";
    opcodes["HAL"] = "1111111";
    opcodes["XXL"] = "1111110";
    opcodes["IOR"] = "0010001";
    opcodes["IOW"] = "0100001";

    regs["R0"] = "000"
    regs["R1"] = "001"
    regs["R2"] = "010"
    regs["R3"] = "011"
    regs["R4"] = "100"
    regs["R5"] = "101"
    regs["R6"] = "110"
    regs["R7"] = "111"
    regs["r0"] = "000"

    op["0"] = "000"
    op["1"] = "001"
    op["2"] = "010"
    op["3"] = "011"
    op["4"] = "100"
    op["5"] = "101"
    op["6"] = "110"
    op["7"] = "111"


    admsb["-32"] = "100"
    admsb["-31"] = "100"
    admsb["-30"] = "100"
    admsb["-29"] = "100"
    admsb["-28"] = "100"
    admsb["-27"] = "100"
    admsb["-26"] = "100"
    admsb["-25"] = "100"
    admsb["-24"] = "101"
    admsb["-23"] = "101"
    admsb["-22"] = "101"
    admsb["-21"] = "101"
    admsb["-20"] = "101"
    admsb["-19"] = "101"
    admsb["-18"] = "101"
    admsb["-17"] = "101"
    admsb["-16"] = "110"
    admsb["-15"] = "110"
    admsb["-14"] = "110"
    admsb["-13"] = "110"
    admsb["-12"] = "110"
    admsb["-11"] = "110"
    admsb["-10"] = "110"
    admsb["-9"] = "110"
    admsb["-8"] = "111"
    admsb["-7"] = "111"
    admsb["-6"] = "111"
    admsb["-5"] = "111"
    admsb["-4"] = "111"
    admsb["-3"] = "111"
    admsb["-2"] = "111"
    admsb["-1"] = "111"
    admsb["0"] = "000"
    admsb["1"] = "000"
    admsb["2"] = "000"
    admsb["3"] = "000"
    admsb["4"] = "000"
    admsb["5"] = "000"
    admsb["6"] = "000"
    admsb["7"] = "000"
    admsb["8"] = "001"
    admsb["9"] = "001"
    admsb["10"] = "001"
    admsb["11"] = "001"
    admsb["12"] = "001"
    admsb["13"] = "001"
    admsb["14"] = "001"
    admsb["15"] = "001"
    admsb["16"] = "010"
    admsb["17"] = "010"
    admsb["18"] = "010"
    admsb["19"] = "010"
    admsb["20"] = "010"
    admsb["21"] = "010"
    admsb["22"] = "010"
    admsb["23"] = "010"
    admsb["24"] = "011"
    admsb["25"] = "011"
    admsb["26"] = "011"
    admsb["27"] = "011"
    admsb["28"] = "011"
    admsb["29"] = "011"
    admsb["30"] = "011"
    admsb["31"] = "011"

    adlsb["-32"] = "000"
    adlsb["-31"] = "001"
    adlsb["-30"] = "010"
    adlsb["-29"] = "011"
    adlsb["-28"] = "100"
    adlsb["-27"] = "101"
    adlsb["-26"] = "110"
    adlsb["-25"] = "111"
    adlsb["-24"] = "000"
    adlsb["-23"] = "001"
    adlsb["-22"] = "010"
    adlsb["-21"] = "011"
    adlsb["-20"] = "100"
    adlsb["-19"] = "101"
    adlsb["-18"] = "110"
    adlsb["-17"] = "111"
    adlsb["-16"] = "000"
    adlsb["-15"] = "001"
    adlsb["-14"] = "010"
    adlsb["-13"] = "011"
    adlsb["-12"] = "100"
    adlsb["-11"] = "101"
    adlsb["-10"] = "110"
    adlsb["-9"] = "111"
    adlsb["-8"] = "000"
    adlsb["-7"] = "001"
    adlsb["-6"] = "010"
    adlsb["-5"] = "011"
    adlsb["-4"] = "100"
    adlsb["-3"] = "101"
    adlsb["-2"] = "110"
    adlsb["-1"] = "111"
    adlsb["0"] = "000"
    adlsb["1"] = "001"
    adlsb["2"] = "010"
    adlsb["3"] = "011"
    adlsb["4"] = "100"
    adlsb["5"] = "101"
    adlsb["6"] = "110"
    adlsb["7"] = "111"
    adlsb["8"] = "000"
    adlsb["9"] = "001"
    adlsb["10"] = "010"
    adlsb["11"] = "011"
    adlsb["12"] = "100"
    adlsb["13"] = "101"
    adlsb["14"] = "110"
    adlsb["15"] = "111"
    adlsb["16"] = "000"
    adlsb["17"] = "001"
    adlsb["18"] = "010"
    adlsb["19"] = "011"
    adlsb["20"] = "100"
    adlsb["21"] = "101"
    adlsb["22"] = "110"
    adlsb["23"] = "111"
    adlsb["24"] = "000"
    adlsb["25"] = "001"
    adlsb["26"] = "010"
    adlsb["27"] = "011"
    adlsb["28"] = "100"
    adlsb["29"] = "101"
    adlsb["30"] = "110"
    adlsb["31"] = "111"


    syntax["MOVA"] = "MOVA RD RA"
    syntax["INC"] = "INC RD RA"
    syntax["ADD"] = "ADD RD RA"
    syntax["MUL"] = "MUL RD RA"
    syntax["SRA"] = "SRA RD RA"
    syntax["SUB"] = "SUB RD RA"
    syntax["DEC"] = "DEC RD RA"
    syntax["SLA"] = "SLA RD RA"
    syntax["AND"] = "AND RD RA"
    syntax["OR"] = "OR RD RA"
    syntax["XOR"] = "XOR RD RA"
    syntax["NOT"] = "NOT RD RA"
    syntax["MOVB"] = "MOVB RD RB"
    syntax["SHR"] = "SHR RD RA"
    syntax["SHL"] = "SHL RD RA"
    syntax["CLR"] = "CLR RD "
    syntax["LDI"] = "LDI RD OP"
    syntax["ADI"] = "ADI RD RA"
    syntax["LD"] = "LD RD RA"
    syntax["ST"] = "ST RA RB"
    syntax["BRZ"] = "BRZ RA AD"
    syntax["BRN"] = "BRN RA AD"
    syntax["JMP"] = "JMP RA "
    syntax["HAL"] = "HAL  "
    syntax["XXL"] = "XXL  "
    syntax["IOR"] = "IOR RD RA"
    syntax["IOW"] = "IOW RA RB"

    lines = 0
}

{

    first = substr($1, 0, 1)
    if (first == ";" || NF == 0) {
	next
    }

    mnemonic = toupper($1)
    a1 = toupper($2)
    a2 = toupper($3)
    a3 = toupper($4)
    numa1 = $2
    numa2 = $3
    numa3 = $4

    if (lines != 0)
	printf ",\n"

    print "// " mnemonic " " a1 " " a2 " " a3

    switch (mnemonic) {

    case "HAL":
	if (NF != 1) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 0)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], "000", "000", "000"
	break

    case "XXL":
	if (NF != 1) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 0)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], "000", "000", "000"
	break

    case "CLR":
	if (NF != 2) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 1)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}
	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], regs[a1], "000", "000"
	break;

    case "MOVA":
    case "INC":
    case "DEC":
    case "SRA":
    case "SLA":
    case "SHR":
    case "SHL":
    case "NOT":
    case "LD":
    case "IOR":
	if (NF != 3) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 2)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}
	if (regs[a2] == "") {
	    print "Error: Illegal register name " a2 ", Valid names are R0 - R7."
	    exit(0);
	}
	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], regs[a1], regs[a2], "000"
	break;

    case "ADD":
    case "MUL":
    case "SUB":
    case "AND":
    case "OR":
    case "XOR":
	if (NF != 4) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 3)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}
	if (regs[a2] == "") {
	    print "Error: Illegal register name " a2 ", Valid names are R0 - R7."
	    exit(0);
	}
	if (regs[a3] == "") {
	    print "Error: Illegal register name " a3 ", Valid names are R0 - R7."
	    exit(0);
	}

	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], regs[a1], regs[a2], regs[a3]
	break;


    case "MOVB":
	if (NF != 3) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 2)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}
	if (regs[a2] == "") {
	    print "Error: Illegal register name " a2 ", Valid names are R0 - R7."
	    exit(0);
	}

	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], regs[a1], "000", regs[a2]
	break;

    case "ST":
    case "IOW":
	if (NF != 3) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 2)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}
	if (regs[a2] == "") {
	    print "Error: Illegal register name " a2 ", Valid names are R0 - R7."
	    exit(0);
	}

	printf "16'b%s_%s_%s_%s",  opcodes[mnemonic], "000", regs[a1], regs[a2]
	break;


    case "LDI":
	if (NF != 3) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 2)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}

	if (numa2 < 0 || numa2 > 7) {
	    print "Error: OP value must be in range [0,7]."
	    exit(1)
	}
	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], regs[a1], "000", op[a2]
	break;

    case "ADI":
	if (NF != 4) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 3)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}
	if (regs[a2] == "") {
	    print "Error: Illegal register name " a2 ", Valid names are R0 - R7."
	    exit(0);
	}

	if (numa3 < 0 || numa3 > 7) {
	    print "Error: OP value must be in range [0,7]."
	    exit(1)
	}
	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], regs[a1], regs[a2], op[numa3]
	break;

    case "BRZ":
    case "BRN":
	if (NF != 3) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 2)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}

	if ((numa2 < -32) || (numa2 > 31)) {
	    print "Error: AD value must be in range [-32,31]."
	    exit(1)
	}
	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], admsb[numa2], regs[a1], adlsb[numa2]
	break;

    case "JMP":
	if (NF != 2) {
	    print "Error: Wrong number of argumens (" NF-1 ") for instruction " mnemonic " (expected 1)."
	    print "       The syntax is: " syntax[mnemonic]
	    exit(1)
	}
	if (regs[a1] == "") {
	    print "Error: Illegal register name " a1 ", Valid names are R0 - R7."
	    exit(0);
	}

	printf "16'b%s_%s_%s_%s", opcodes[mnemonic], "000", regs[a1], "000"
	break;

    default:

	print "Error: Illegal instruction: " mnemonic
	print "       The syntax is: " syntax[mnemonic]
	exit(1)
	break;

    }

    lines = lines + 1;
}
END {
    printf "\n"
}
