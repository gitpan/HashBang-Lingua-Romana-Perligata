use Config;
use File::Basename qw(basename dirname);

chdir(dirname($0));
($file = basename($0)) =~ s/\.PERL$/\.pl/;

open OUT,">$file" or die "Can't create $file: $!";
chmod(0755, $file);
print "Extracting $file (with variable substitutions)\n";

my $prog = join '', <<"!GROK!THIS!", <<'!NO!SUBS!'; $prog =~ s/\<\%parrot\%\>/$parrot/g; print OUT $prog;
$Config{'startperl'} -w

!GROK!THIS!

require Lingua::Romana::Perligata;

open SOURCE, shift or die $!;
my $perligata = <SOURCE>;
$perligata = '' if $perligata =~ /^#!/;
{
    local $/;
    $perligata .= <SOURCE>;
}

package Lingua::Romana::Perligata;
my $tokens = tokenize($perligata);
my @commands;
push @commands, conn_command($tokens,'END') while @$tokens;
$_ = join ";\n", map { $_->translate } @commands;

package main;
eval;
!NO!SUBS!

#vim :set ft=perl
