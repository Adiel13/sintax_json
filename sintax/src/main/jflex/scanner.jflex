package udv.compi;

import java.io.*;
import java.util.ArrayList;
import java_cup.runtime.*;

%%
%public
%class Scanner
%cup
%function next_token 

digit = [0-9]
letter = [a-zA-Z]
Whitespace = [ \t\f] | {LineTerminator}
LineTerminator = \r|\n|\r\n

%{

StringBuffer string = new StringBuffer();

private Symbol symbol(int type){
	return new Symbol(type, yyline, yycolumn);
}

private Symbol symbol(int type, Object value){
	return new Symbol(type, yyline, yycolumn, value);
}

%}

%eofval{
	return symbol(ParserSym.EOF);
%eofval}

%%

<YYINITIAL>{letter}({letter}|{digit})* { return symbol(ParserSym.ID, yytext()); }
<YYINITIAL>"\""({digit}|{letter}|{Whitespace})+"\"" {return symbol(ParserSym.VAL, yytext()); }
<YYINITIAL>"{" { return symbol(ParserSym.LLA, yytext()); }
<YYINITIAL>"}" { return symbol(ParserSym.LLC, yytext()); }
<YYINITIAL>"[" { return symbol(ParserSym.CA, yytext()); }
<YYINITIAL>"]" { return symbol(ParserSym.CC, yytext()); }
<YYINITIAL>":" { return symbol(ParserSym.DP, yytext()); }
<YYINITIAL>"," { return symbol(ParserSym.COMMA, yytext()); }
<YYINITIAL>"\"" { return symbol(ParserSym.COMILLA, yytext()); }
<YYINITIAL>({digit})+ { return symbol(ParserSym.NUM, yytext()); }

<YYINITIAL>{Whitespace} {}

\n {yychar=1;}
. {System.err.println("warning: Unrecognized character '" + yytext()+"' -- ignored" + " at : "+ (yyline+1) + " " + (yycolumn+1) + " " + yychar); }