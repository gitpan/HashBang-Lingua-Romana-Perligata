use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'HashBang::Lingua::Romana::Perligata',
    VERSION => '0.10',
    PREREQ_PM => {hashbang => '0.10',
                  'Lingua::Romana::Perligata' => '0.50'
                 },
    PL_FILES => {'bin/perligata.PERL' => 'bin/perligata.pl'},
    EXE_FILES => ['bin/perligata.pl'],
    clean => { FILES => 'config bin/perligata.pl' },
);

sub MY::postamble {
    <<'END';
pure_install ::
	ln -fs ${INSTALLSCRIPT}/hashbang ${INSTALLSCRIPT}/perligata
END
}
