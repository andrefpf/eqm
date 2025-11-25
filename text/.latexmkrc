# Set jobname and output directory
$out_dir = './.temp';  # replace with your desired output directory
$jobname = 'exemplo-tcc-i';    # replace with your desired jobname

# Set TEXINPUTS environment variable
$ENV{'TEXINPUTS'} = '../modules/ecl-references:../modules/ufsc-thesis:';

# Optional: specify other settings for latexmk if needed
$pdf_mode = 1; # Enable PDF output mode

# Use the -jobname and -output-directory options
$pdflatex = "pdflatex -shell-escape -jobname=$jobname -output-directory=$out_dir %O %S";
$bibtex_use = 2;  # This tells latexmk to use biber instead of bibtex

# Configure biber with correct paths
$biber = "biber --output-directory=$out_dir --input-directory=../modules/ecl-references $jobname";

# Specify custom cleanup rule for biber files
$clean_ext = 'bbl blg bcf run.xml';

$success_cmd = "cp $out_dir/$jobname.pdf ./";


add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('nyg', 'nyi', 0, 'run_makeglossaries');

sub run_makeglossaries {
	my ($base_name, $path) = fileparse( $_[0] );
   	pushd $path;
    if ($silent) {
    	my $return = system("makeglossaries -q $base_name");
    } else{
        my $return = system("makeglossaries $base_name");
    }
    popd;
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'nyg', 'nyi', 'not';
$clean_ext .= ' %R.ist %R.xdy';

return $return;





