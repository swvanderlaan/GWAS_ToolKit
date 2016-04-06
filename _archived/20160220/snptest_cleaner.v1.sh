#!/bin/bash

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                                             SNPTEST_CLEANER.v1"
echo "                                    CLEANS UP SNPTEST ANALYSIS RESULTS"
echo ""
echo " You're here: "`pwd`
echo " Today's: " `date`
echo ""
echo " Version: SNPTEST_CLEANER.v1.20160220"
echo ""
echo " Last update: February 20th, 2016"
echo " Written by:  Sander W. van der Laan (s.w.vanderlaan-2@umcutrecht.nl);"
echo ""
echo " Description: Cleaning up all files from a SNPTEST analysis into one file for ease "
echo "              of downstream (R) analyses."
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

### START of if-else statement for the number of command-line arguments passed ###
if [[ $# -lt 5 ]]; then 
	echo "Oh, computer says no! Argument not recognised: $(basename "${0}") error! You must supply [5] argument:"
	echo "- Argument #1 indicates the type of analysis [GWAS/REGION/GENES]."
	echo "- Argument #2 which study type [AEGS/AAAGS/CTMM]."
	echo "- Argument #3 which reference."
	echo "- Argument #4 is path_to the output directory."
	echo "- Argument #5 which phenotype was analysed."
	echo ""
	echo "An example command would be: snptest_cleaner.v1.sh [arg1: [GWAS/REGION/GENES] ] [arg2: AEGS/AAAGS/CTMM] [arg3: reference_to_use [1kGp3v5GoNL5/1kGp1v3/GoNL4] ] [arg4: path_to_output_dir]  [arg5: some_phenotype ]"
  	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  	# The wrong arguments are passed, so we'll exit the script now!
  	date
  	exit 1
else
	echo "All arguments are passed. These are the settings:"
	# set input-data
	ANALYSIS_TYPE=${1}
	STUDY_TYPE=${2}
	REFERENCE=${3}
	OUTPUT_DIR=${4} 
	cd ${OUTPUT_DIR}	
	PHENOTYPE=${5}
	echo "The following analysis type will be run.....................: ${ANALYSIS_TYPE}"
	echo "The following dataset will be used..........................: ${STUDY_TYPE}"
	echo "The reference used..........................................: ${REFERENCE}"
	echo "The output directory is.....................................: ${OUTPUT_DIR}"
	echo "The following phenotype was analysed and is wrapped up......: ${PHENOTYPE}"
	
	### Starting of the script
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "                                CLEANING UP SNPTEST ANALYSIS RESULTS"
	echo ""
	echo "Please be patient...this can take a long time depending on the number of files."
	echo "We started at: `date`"
	echo ""
	
	echo "Moving scripts and logs..."
	mkdir -v ${OUTPUT_DIR}/_scriptlogs
	mv -v ${OUTPUT_DIR}/${STUDY_TYPE}*.${REFERENCE}.${PHENOTYPE}.*.sh ${OUTPUT_DIR}/_scriptlogs/
	mv -v ${OUTPUT_DIR}/${STUDY_TYPE}*.${REFERENCE}.${PHENOTYPE}.*.output ${OUTPUT_DIR}/_scriptlogs/
	gzip -v ${OUTPUT_DIR}/_scriptlogs/*.output
	echo ""
	echo "Moving raw results..."
	mkdir -v ${OUTPUT_DIR}/_rawresults
	mv -v ${OUTPUT_DIR}/${STUDY_TYPE}*.${REFERENCE}.${PHENOTYPE}.*.log ${OUTPUT_DIR}/_rawresults/
	mv -v ${OUTPUT_DIR}/${STUDY_TYPE}*.${REFERENCE}.${PHENOTYPE}.*.out ${OUTPUT_DIR}/_rawresults/
	gzip -v ${OUTPUT_DIR}/_rawresults/*.log
	gzip -v ${OUTPUT_DIR}/_rawresults/*.out
	echo ""
	echo "Checking errors-files and zapping them if empty..."
	if [[ -s ${OUTPUT_DIR}/${STUDY_TYPE}*.${REFERENCE}.${PHENOTYPE}.*.errors ]]; then
		echo "* ERROR FILE NOT EMPTY: The error file has some data. We'll keep it there for review."
	else
		echo "The error file is empty."
	    rm -v ${OUTPUT_DIR}/${STUDY_TYPE}*.${REFERENCE}.${PHENOTYPE}.*.errors
	fi
	
	echo ""
	echo "All cleaned up."
	echo ""
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

### END of if-else statement for the number of command-line arguments passed ###
fi

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "+ The MIT License (MIT)                                                                                 +"
echo "+ Copyright (c) 2016 Sander W. van der Laan                                                             +"
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

