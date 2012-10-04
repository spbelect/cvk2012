#!/usr/bin/perl

sub k82tr
    { ($_)=@_;

#
# Fonetic correct translit
#

s/��/S\'h/; s/��/s\'h/; s/��/S\'H/;
s/�/Sh/g; s/�/sh/g;

s/���/Sc\'h/; s/���/sc\'h/; s/���/SC\'H/;
s/�/Sch/g; s/�/sch/g;

s/��/C\'h/; s/��/c\'h/; s/��/C\'H/;
s/�/Ch/g; s/�/ch/g;

s/��/J\'a/; s/��/j\'a/; s/��/J\'A/;
s/�/Ja/g; s/�/ja/g;

s/��/J\'o/; s/��/j\'o/; s/��/J\'O/;
s/�/Jo/g; s/�/jo/g;

s/��/J\'u/; s/��/j\'u/; s/��/J\'U/;
s/�/Ju/g; s/�/ju/g;

s/�/E\'/g; s/�/e\'/g;
s/�/E/g; s/�/e/g;

s/��/Z\'h/g; s/��/z\'h/g; s/��/Z\'H/g;
s/�/Zh/g; s/�/zh/g;

tr/
������������������������������������������������/
abvgdzijklmnoprstufhc\"y\'ABVGDZIJKLMNOPRSTUFHC\"Y\'/;

return $_;

}

print "name, curia, block, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25\n";
@curias = qw(common lib left naz);
$curia = -1;
while(<>){
	if (/h2.(.*)..h2/){
		$curia++;
	}
 	if (/<div class=.dna.><\/div>/){
 		print $name.", ".$curias[$curia].", ".$block.", ".$compass."\n";
 	}
 	if (/account_candidate_PrintShort/){
 		$block = "";
 		$name = "";
 		$compass = "";
 	}
 	if (/bloki\/(.*?)\//){
		$block = $1;
	}
 	if (/<span class=.title.>/){
 		$_ = <>;
 		/^\s+(.*)\s+$/;
 		$name = k82tr($1);
 		@ps = split(/[\s()]+/, $_);
 		$name = join(" ", @ps[0,1]);
 	}
 	if (/candidate_compass_data.>\[(.*)\]/){
 		$compass = $1;
 	}
}


