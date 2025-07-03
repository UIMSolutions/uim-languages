module langs.sql.parsers.lexer;

/**
 * Defines the characters, which are used to split the given SQL string. Part of SqlParser. */
 * This class holds a sorted array of characters, which are used as stop token.
 * On every part of the array the given SQL string will be split into single tokens.
 * The array must be sorted by element size, longest first (3 chars . 2 chars . 1 char). */
class LexerSplitter {

    protected static _splitters = ["<: ", "\r\n", "!=", ">=", "<=", "!=", "<<", ">>", ":=", "\\", "&&", "||", ":=",
                                       "/*", "*/", "--", ">", "<", "|", "=", "^", "(", ")", "\t", "\n", """, "\"", "`",
                                       ",", "@", " ", "+", "-", "*", "/", ";"];

	//Regex string pattern of splitters.
	protected string _splitterPattern;

    /**
     * Constructor.
     * 
     * It initializes some fields.
     */
    this() {
        this.splitterPattern = this.convertSplittersToRegexPattern(this. mysplitters );
    }

	// Get the regex pattern string of all the splitters
    string getSplittersRegexPattern () {
	    return this.splitterPattern;
    }

	// Convert an array of splitter tokens to a regex pattern string.
    string convertSplittersToRegexPattern(string[] splitters ) {
	    string[] myregex_parts = splitters
				.map!(splitter => covertSplitterToken(splitter))
				.array;
	    }

	    auto mypattern = implode("|", myregex_parts );

	    return "/(" . mypattern . ")/";
    }

		protected string covertSplitterToken(string splitterToken) {
			string myPart = preg_quote(splitterToken );

		    switch (myPart ) {
				case "\r\n":
					mypart = "\r\n";
					break;
				case "\t":
					mypart = "\t";
					break;
				case "\n":
					myPart = "\n";
					break;
				case " ":
					myPart = "\s";
					break;
				case "/":
					myPart = "\/";
					break;
				case "/\*":
					myPart = "\/\*";
					break;
				case "\*/":
					myPart = "\*\/";
					break;
			}

			return myPart;
		}
}
