#!/bin/bash

script_copyright_message() {
	echo ""
	THISYEAR=$(date +'%Y')
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "+ The MIT License (MIT)                                                                                 +"
	echo "+ Copyright (c) 2015-${THISYEAR} Sander W. van der Laan                                                        +"
	echo "+                                                                                                       +"
	echo "+ Permission is hereby granted, free of charge, to any person obtaining a copy of this software and     +"
	echo "+ associated documentation files (the \"Software\"), to deal in the Software without restriction,         +"
	echo "+ including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, +"
	echo "+ and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, +"
	echo "+ subject to the following conditions:                                                                  +"
	echo "+                                                                                                       +"
	echo "+ The above copyright notice and this permission notice shall be included in all copies or substantial  +"
	echo "+ portions of the Software.                                                                             +"
	echo "+                                                                                                       +"
	echo "+ THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT     +"
	echo "+ NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                +"
	echo "+ NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES  +"
	echo "+ OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN   +"
	echo "+ CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                            +"
	echo "+                                                                                                       +"
	echo "+ Reference: http://opensource.org.                                                                     +"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                                             SNPTEST_PLOTTER"
echo "                                  PLOTTING OF SNPTEST ANALYSIS RESULTS"
echo ""
echo " Version    : v1.1.3"
echo ""
echo " Last update: 2017-07-07"
echo " Written by : Sander W. van der Laan (s.w.vanderlaan-2@umcutrecht.nl)."
echo ""
echo " Testers    : - Saskia Haitjema (s.haitjema@umcutrecht.nl)"
echo "              - Aisha Gohar (a.gohar@umcutrecht.nl)"
echo "              - Jessica van Setten (j.vansetten@umcutrecht.nl)"
echo ""
echo " Description: Plotting of a SNPTEST analysis: making Manhattan, Z-P, and QQ plots."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

### START of if-else statement for the number of command-line arguments passed ###
if [[ $# -lt 2 ]]; then 
	echo "Oh, computer says no! Argument not recognised: $(basename "${0}") error! You must supply [2] argument:"
	echo "- Argument #1 is path_to the output directory."
	echo "- Argument #2 is name of the phenotype."
	echo ""
	echo "An example command would be: snptest_pheno_wrapper.v1.sh [arg1: path_to_output_dir] [arg2: [PHENOTYPE] ] "
	echo ""
  	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  	# The wrong arguments are passed, so we'll exit the script now!
  	exit 1
else
	echo "All arguments are passed. These are the settings:"
	# set input-data
	OUTPUT_DIR=${1} # depends on arg1
	cd ${OUTPUT_DIR}
	PHENOTYPE=${2} # depends on arg2
	echo "The output directory is...................: ${OUTPUT_DIR}"
	echo "The phenotypes is.........................: ${PHENOTYPE}"
	echo ""	
	# PLOT GWAS RESULTS
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "                                    PLOTTING SNPTEST ANALYSIS RESULTS"
	echo ""
	echo "Please be patient...this can take a long time depending on the number of files."
	echo "We started at: "$(date)
	echo ""
	SCRIPTS=/hpc/local/CentOS7/dhl_ec/software/GWASToolKit/SCRIPTS
	echo ""
	echo "Plotting reformatted UNFILTERED data. Processing the following dataset: "
	# what is the basename of the file?
	RESULTS=${OUTPUT_DIR}/*.summary_results.txt.gz
	FILENAME=$(basename ${RESULTS} .txt.gz)
	echo "The basename is: "${FILENAME}
	echo ""
	
	### COLUMN NAMES & NUMBERS
	###     1    2   3  4            5            6              7    8      9     10     11     12  13  14  15  16 17  18 19
	### ALTID RSID CHR BP OtherAlleleA CodedAlleleB AvgMaxPostCall Info all_AA all_AB all_BB TotalN MAC MAF CAF HWE P BETA SE
	
	### QQ-plot including 95%CI and compute lambda [P]
	echo "Making QQ-plot including 95%CI and compute lambda..."
	zcat ${RESULTS} | tail -n +2 | awk ' { print $17 } ' | grep -v NA > ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_CI.txt
		Rscript ${SCRIPTS}/plotter.qq.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_CI.txt -o ${OUTPUT_DIR} -s PVAL -f PDF
		Rscript ${SCRIPTS}/plotter.qq.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_CI.txt -o ${OUTPUT_DIR} -s PVAL -f PNG
	echo ""
	
	### QQ-plot stratified by effect allele frequency [P, EAF]
	echo "QQ-plot stratified by effect allele frequency..."
	zcat ${RESULTS} | tail -n +2 | awk ' { print $17, $15 } ' | grep -v NA > ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_EAF.txt
		Rscript ${SCRIPTS}/plotter.qq_by_caf.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_EAF.txt -o ${OUTPUT_DIR} -s PVAL -f PDF
		Rscript ${SCRIPTS}/plotter.qq_by_caf.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_EAF.txt -o ${OUTPUT_DIR} -s PVAL -f PNG
	echo ""
	
	## QQ-plot stratified by imputation quality (info -- imputation quality) [P, INFO]
	echo "QQ-plot stratified by imputation quality..."
	zcat ${RESULTS} | tail -n +2 | awk ' { print $17, $8 } ' | grep -v NA > ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_INFO.txt
		Rscript ${SCRIPTS}/plotter.qq_by_info.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_INFO.txt -o ${OUTPUT_DIR} -s PVAL -f PDF
		Rscript ${SCRIPTS}/plotter.qq_by_info.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_INFO.txt -o ${OUTPUT_DIR} -s PVAL -f PNG
	echo ""
	
	### Plot the imputation quality (info) in a histogram [INFO]
	echo "Plot the imputation quality (info) in a histogram..."
	zcat ${RESULTS} | tail -n +2 | awk ' { print $8 } ' > ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_INFO.txt 
		Rscript ${SCRIPTS}/plotter.infoscore.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_INFO.txt -o ${OUTPUT_DIR} -f PDF
		Rscript ${SCRIPTS}/plotter.infoscore.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_INFO.txt -o ${OUTPUT_DIR} -f PNG
	echo ""
	
	### Plot the BETAs in a histogram [BETA]
	echo "Plot the BETAs in a histogram..."
	zcat ${RESULTS} | tail -n +2 | awk ' { print $18 } ' > ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_BETA.txt 
		Rscript ${SCRIPTS}/plotter.infoscore.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_BETA.txt -o ${OUTPUT_DIR} -f PDF
		Rscript ${SCRIPTS}/plotter.infoscore.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_BETA.txt -o ${OUTPUT_DIR} -f PNG
	echo ""
	
	### Plot the Z-score based p-value (calculated from beta/se) and P [BETA, SE, P]
	echo "Plot the Z-score based p-value (calculated from beta/se) and P..."
	zcat ${RESULTS} | tail -n +2 | awk ' { print $18, $19, $17 } ' > ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.PZ_Plot.txt 
		Rscript ${SCRIPTS}/plotter.p_z.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.PZ_Plot.txt -o ${OUTPUT_DIR} -s 500000 -f PDF
		Rscript ${SCRIPTS}/plotter.p_z.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.PZ_Plot.txt -o ${OUTPUT_DIR} -s 500000 -f PNG
	echo ""
	
	### Manhattan plot for quick inspection (truncated upto -log10(p-value)) [CHR, BP, P]
	echo "Manhattan plot for quick inspection (truncated upto -log10(p-value)=2)..."
	zcat ${RESULTS} | tail -n +2 | awk ' { print $3, $4, $17 } ' > ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Manhattan_forQuickInspect.txt
		Rscript ${SCRIPTS}/plotter.manhattan.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Manhattan_forQuickInspect.txt -o ${OUTPUT_DIR} -c QC -f PDF -t ${FILENAME}
		Rscript ${SCRIPTS}/plotter.manhattan.R -p ${OUTPUT_DIR} -r ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Manhattan_forQuickInspect.txt -o ${OUTPUT_DIR} -c QC -f PNG -t ${FILENAME}
	echo ""
	
	echo "Finished plotting, zipping up and re-organising intermediate files!"
	rm -v ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_CI.txt
	rm -v ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_EAF.txt
	rm -v ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.QQplot_INFO.txt
	rm -v ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_INFO.txt
	rm -v ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Histogram_BETA.txt
	rm -v ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.PZ_Plot.txt
	rm -v ${OUTPUT_DIR}/${PHENOTYPE}.${FILENAME}.Manhattan_forQuickInspect.txt
	echo ""

### END of if-else statement for the number of command-line arguments passed ###
fi

script_copyright_message