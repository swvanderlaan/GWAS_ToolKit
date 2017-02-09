#!/bin/bash

### MESSAGE FUNCTIONS
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
script_arguments_error() {
	echo "$1" # ERROR MESSAGE
	echo "- Argument #1  indicates whether you want to analyse a list of variants, a region, or do a GWAS [VARIANT/REGION/GWAS]."
	echo "               Depending on the choice you additional arguments are expected:"
	echo "               - for GWAS: the standard 11 arguments in total."
	echo "               - for VARIANT: additional argument, namely a [FILE] containing the list of variants and the chromosome."
	echo "               - for REGION: additional arguments, namely the [CHR], [REGION_START] and [REGION_END] in numerical fashion."
	echo "               - for GENES: additional arguments, namely the [GENES] list and [RANGE] in numerical fashion."
	echo "- Argument #2  the study to use, AEGS, AAAGS, or CTMM."
	echo "- Argument #3  is input data to use, i.e. where the [imputed] genotypes reside: [1kGp3v5GoNL5/1kGp1v3/GoNL4]."
	echo "- Argument #4  is the name of the SNPTEST method used [score/expected]."
	echo "- Argument #5  is exclusion-list to be used, can be either:"
	echo "               [EXCL_DEFAULT]   * exclusion_nonCEA.list            - excludes all non-CEA samples, THIS IS THE DEFAULT"
	echo "               [EXCL_FEMALES]   * exclusion_nonCEA_Females.list    - excludes all non-CEA samples and all females"
	echo "               [EXCL_MALES]     * exclusion_nonCEA_Males.list      - excludes all non-CEA samples and all males"
	echo "               [EXCL_CKD]       * exclusion_nonCEA_CKD.list        - excludes all non-CEA samples and with CKD"
	echo "               [EXCL_NONCKD]    * exclusion_nonCEA_nonCKD.list     - excludes all non-CEA samples and without CKD"
	echo "               [EXCL_T2D]       * exclusion_nonCEA_T2D.list        - excludes all non-CEA samples and who have type 2 diabetes"
	echo "               [EXCL_NONT2D]    * exclusion_nonCEA_nonT2D.list     - excludes all non-CEA samples and who *do not* have type 2 diabetes"
	echo "               [EXCL_SMOKER]    * exclusion_nonCEA_SMOKER.list     - excludes all non-CEA samples and who are smokers "
	echo "               [EXCL_NONSMOKER] * exclusion_nonCEA_nonSMOKER.list  - excludes all non-CEA samples and who are non-smokers"
	echo "               [EXCL_PRE2007]   * exclusion_nonCEA_pre2007.list    - excludes all non-CEA samples and who were included before 2007; AE exclusive"
	echo "               [EXCL_POST2007]  * exclusion_nonCEA_post2007.list   - excludes all non-CEA samples and who were included after 2007; AE exclusive"
	echo "- Argument #6  is path_to to the phenotype-file [refer to readme for list of available phenotypes]."
	echo "- Argument #7  is path_to to the covariates-file [refer to readme for list of available covariates]."
	echo "- Argument #8  is path_to the project [name] directory, where the output should be stored."
	echo "- Argument #9  is the amount of Gigabytes of memory you want to use on the HPC (GWAS require more than 8 hours per chromosome)."
	echo "- Argument #10 is the amount of time you want to use the HPC for"
	echo "- Argument #11 is your e-mail address; you'll get an email when the jobs have ended or are aborted/killed."
	echo "- Argument #12 are you mail setting; you can get an email if jobs begin (b), end (e), actually start (s), abort (a), or do not want an email (n)."
	echo ""
	echo "For GWAS:"
	echo "- Argument #13 indicates the type of trait, quantitative or binary [QUANT/BINARY] | QUANT IS THE DEFAULT."
	echo ""
	echo "An example command would be: snptest_pheno.v1.sh [arg1: VARIANT/REGION/GWAS] [arg2: AEGS/AAAGS/CTMM] [arg3: reference_to_use [1kGp3v5GoNL5/1kGp1v3/GoNL4] ] [arg4: SCORE/EXPECTED] [arg5: which_exclusion_list] [arg6: path_to_phenotype_file ] [arg7: path_to_covariates_file ] [arg8: path_to_project] [arg9: job_memory] [arg10: job_time] [arg11: your_email@domain.com] [arg12: mailsettings] [arg13: trait_type [QUANT/BINARY]]"
  	echo ""
  	echo "For per-VARIANT ANALYSES:"
	echo "- Argument #13 you are running an individual variant list analysis, thus we expect a path_to to the variant-list-file which includes three columns: SNP CHR BP (e.g. rs12345 5 1234)."
	echo "- Argument #14 indicates the type of trait, quantitative or binary [QUANT/BINARY] | QUANT IS THE DEFAULT."
	echo ""
	echo "An example command would be: snptest_pheno.v1.sh [arg1: VARIANT/REGION/GWAS] [arg2: AEGS/AAAGS/CTMM] [arg3: reference_to_use [1kGp3v5GoNL5/1kGp1v3/GoNL4] ] [arg4: SCORE/EXPECTED] [arg5: which_exclusion_list] [arg6: path_to_phenotype_file ] [arg7: path_to_covariates_file ] [arg8: path_to_project] [arg9: job_memory] [arg10: job_time] [arg11: your_email@domain.com] [arg12: mailsettings] [arg13: path_to_variant_list] [arg14: trait_type [QUANT/BINARY]]"
	echo ""
  	echo "For REGIONAL ANALYSES:"
	echo "- Argument #13 you are running a regional analysis, thus we expect here [CHR] (e.g. 1-22 or X; NOTE: GoNL4 doesn't include information for chromosome X)."
	echo "- Argument #14 you are running a regional analysis, thus we expect here [REGION_START] (e.g. 12345)"
	echo "- Argument #15 you are running a regional analysis, thus we expect here [REGION_END] (e.g. 678910)"
	echo "- Argument #16 indicates the type of trait, quantitative or binary [QUANT/BINARY] | QUANT IS THE DEFAULT."
	echo ""
	echo "An example command would be: snptest_pheno.v1.sh [arg1: VARIANT/REGION/GWAS] [arg2: AEGS/AAAGS/CTMM] [arg3: reference_to_use [1kGp3v5GoNL5/1kGp1v3/GoNL4] ] [arg4: SCORE/EXPECTED] [arg5: which_exclusion_list] [arg6: path_to_phenotype_file ] [arg7: path_to_covariates_file ] [arg8: path_to_project] [arg9: job_memory] [arg10: job_time] [arg11: your_email@domain.com] [arg12: mailsettings] [arg13: chromosome] [arg14: region_start] [arg15: region_end] [arg16: trait_type [QUANT/BINARY]]"
	echo ""
  	echo "For per-GENE ANALYSES:"
  	echo "- Argument #12 you are running a per-gene analysis using a list of genes, thus we expect here path_to_a_list_of [GENES]."
	echo "- Argument #13 you are running a per-gene analysis, thus we expect here [RANGE]."
	echo "- Argument #14 indicates the type of trait, quantitative or binary [QUANT/BINARY] | QUANT IS THE DEFAULT."
	echo ""
	echo "An example command would be: snptest_pheno.v1.sh [arg1: VARIANT/REGION/GWAS] [arg2: AEGS/AAAGS/CTMM] [arg3: reference_to_use [1kGp3v5GoNL5/1kGp1v3/GoNL4] ] [arg4: SCORE/EXPECTED] [arg5: which_exclusion_list] [arg6: path_to_phenotype_file ] [arg7: path_to_covariates_file ] [arg8: path_to_project] [arg9: job_memory] [arg10: job_time] [arg11: your_email@domain.com] [arg12: mailsettings] [arg13: chromosome] [arg14: range] [arg15: trait_type [QUANT/BINARY]]"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  	# The wrong arguments are passed, so we'll exit the script now!
  	date
  	exit 1
}
script_arguments_error_studytype() {
			echo "$1" 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [AEGS/AAAGS/CTMM] -- for use of imputed data of Athero-Express Genomics Study 1 & 2 (AEGS, n = 1,526), "
			echo "                        Abdominal Aortic Aneurysm Express Genomics Study (AAAGS, n = 479), or CTMM (n = )."
			echo "                        Please note that for AAAGS and CTMM only 1000G (phase 3, version 5, "
			echo "                        \"Final release\") plus GoNL5 imputed data is available."
			echo "                        For AEGS also 1000G (phase 1, version 3) and GoNL4 imputed data is available."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
}
script_arguments_error_normalization() {
			echo "$1" 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [STANDARDIZE/RAW] -- SNPTEST can either use the raw trait data or standardize it on the fly."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
}
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "                                               SNPTEST_PHENO"
echo "          INDIVIDUAL VARIANT, PER-GENE, REGIONAL OR GENOME-WIDE ASSOCIATION STUDY ON A PHENOTYPE"
echo ""
echo " Version    : v1.2.6"
echo ""
echo " Last update: 2016-12-18"
echo " Written by : Sander W. van der Laan (s.w.vanderlaan-2@umcutrecht.nl)."
echo ""
echo " Testers    : - Saskia Haitjema (s.haitjema@umcutrecht.nl)"
echo "              - Aisha Gohar (a.gohar@umcutrecht.nl)"
echo "              - Jessica van Setten (j.vansetten@umcutrecht.nl)"
echo ""
echo " Description: Perform individual variant, regional or genome-wide association "
echo "              analysis on some phenotype(s). It will do the following:"
echo "              - Run GWAS using SNPTESTv2.5.2 and 1000G (phase 1), GoNL4, or "
echo "                1000G (phase 3) + GoNL5 data per chromosome."
echo "              - Collect results in one file upon completion of jobs."
echo ""
echo " REQUIRED: "
echo " * A high-performance computer cluster with a qsub system."
echo " * Imputed genotype data with 1000G[p1/p3]/GoNL[4/5] as reference."
echo " * SNPTEST v2.5+"
echo " * R v3.2+"
echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

### Set the analysis type.
ANALYSIS_TYPE=${1}

### Set the analysis type.
STUDY_TYPE=${2}

### START of if-else statement for the number of command-line arguments passed ###
if [[ ${ANALYSIS_TYPE} = "GWAS" && $# -lt 14 ]]; then 
	echo "Oh, computer says no! Number of arguments found "$#"."
	script_arguments_error "You must supply at least [14] arguments when running a *** GENOME-WIDE ANALYSIS ***!"
	
elif [[ ${ANALYSIS_TYPE} = "VARIANT" && $# -lt 14 ]]; then 
	echo "Oh, computer says no! Number of arguments found "$#"."
	script_arguments_error "You must supply [14] arguments when running a *** VARIANT ANALYSIS ***!"
	
elif [[ ${ANALYSIS_TYPE} = "REGION" && $# -lt 16 ]]; then 
	echo "Oh, computer says no! Number of arguments found "$#"."
	script_arguments_error "You must supply [16] arguments when running a *** REGIONAL ANALYSIS ***!"
	
elif [[ ${ANALYSIS_TYPE} = "GENES" && $# -lt 14 ]]; then 
	echo "Oh, computer says no! Number of arguments found "$#"."
	script_arguments_error "You must supply [14] arguments when running a *** GENE ANALYSIS ***!"
	
else
	
	### CHECKING ARGUMENTS ###
	### Set location of [imputed] genotype data
	REFERENCE=${3} # depends on arg3  [1kGp3v5GoNL5/1kGp1v3/GoNL4] 
	
	### Determine which reference and thereby input data to use, arg1 [1kGp3v5GoNL5/1kGp1v3/GoNL4] 
	if [[ ${STUDY_TYPE} = "AEGS" ]]; then
		if [[ ${REFERENCE} = "1kGp3v5GoNL5" ]]; then
			IMPUTEDDATA=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/aegs_combo_1kGp3GoNL5_RAW_chr
			HG19_GENES=/hpc/local/CentOS7/dhl_ec/software/GWASToolKit/glist-hg19
		elif [[ ${REFERENCE} = "1kGp1v3" ]]; then
			IMPUTEDDATA=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/aegs_combo_1000g_RAW_chr
			HG19_GENES=/hpc/local/CentOS7/dhl_ec/software/GWASToolKit/glist-hg19
		elif [[ ${REFERENCE} = "GoNL4" ]]; then
			IMPUTEDDATA=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_GoNL4/aegs_combo_gonl4_RAW_chr
			HG19_GENES=/hpc/local/CentOS7/dhl_ec/software/GWASToolKit/glist-hg19
		else
		### If arguments are not met then this error message will be displayed
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [1kGp3v5GoNL5] -- for use of data imputed using 1000G (phase 3, version 5, \"Final release\") plus GoNL5."
			echo " * [1kGp1v3]      -- for use of data imputed using 1000G (phase 1, version 3)."
			echo " * [GoNL4]        -- for use of data imputed using GoNL4, note that this data *does not* include chromosome X."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
		fi
	elif [[ ${STUDY_TYPE} = "AAGS" ]]; then
		if [[ ${REFERENCE} = "1kGp3v5GoNL5" ]]; then
			IMPUTEDDATA=/hpc/dhl_ec/data/_aaa_originals/AAAGS_IMPUTE2_1000Gp3_GoNL5/aaags_1kGp3GoNL5_RAW_chr
			HG19_GENES=/hpc/local/CentOS7/dhl_ec/software/GWASToolKit/glist-hg19
		else
		### If arguments are not met then this error message will be displayed 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [1kGp3v5GoNL5] -- for use of data imputed using 1000G (phase 3, version 5, \"Final release\") plus GoNL5."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
		fi
	elif [[ ${STUDY_TYPE} = "CTMM" ]]; then
		if [[ ${REFERENCE} = "1kGp3v5GoNL5" ]]; then
			IMPUTEDDATA=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/ctmm_1kGp3GoNL5_RAW_chr
			HG19_GENES=/hpc/local/CentOS7/dhl_ec/software/GWASToolKit/glist-hg19
		else
		### If arguments are not met then this error message will be displayed 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [1kGp3v5GoNL5] -- for use of data imputed using 1000G (phase 3, version 5, \"Final release\") plus GoNL5."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
		fi
	else
		### If arguments are not met then this error message will be displayed
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [AEGS/AAAGS/CTMM] -- for use of imputed data of Athero-Express Genomics Study 1 & 2 (AEGS, n = 1,526), "
			echo "                        Abdominal Aortic Aneurysm Express Genomics Study (AAAGS, n = 479), or CTMM (n = )."
			echo "                        Please note that for AAAGS and CTMM only 1000G (phase 3, version 5, "
			echo "                        \"Final release\") plus GoNL5 imputed data is available."
			echo "                        For AEGS also 1000G (phase 1, version 3) and GoNL4 imputed data is available."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
	fi
	
	### Set location of [imputed] genotype data
	METHOD_CHECK=${4} # depends on arg4
	
	### Determine which reference and thereby input data to use, arg1 [1kGp3v5GoNL5/1kGp1v3/GoNL4] 
		if [[ ${METHOD_CHECK} = "SCORE" ]]; then
			METHOD=score
		elif [[ ${METHOD_CHECK} = "EXPECTED" ]]; then
			METHOD=expected
		else
		### If arguments are not met then this error message will be displayed 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [SCORE]         -- uses the method score."
			echo " * [EXPECTED]      -- uses the method expected."
			echo ""
			echo " Please refer to the website of SNPTEST: https://mathgen.stats.ox.ac.uk/genetics_software/snptest/snptest.html."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
		fi
	
	### Set location of exclusion list
	EXCLUSION=${5} # depends on arg4
	
	### AVAILABLE EXCLUSION LISTS:
	### * exclusion_nonAEGS.list           -- excludes all non-AEGS samples | for use with extended .sample file (actually hardly ever used)
	### * exclusion_nonFemales.list        -- excludes all male samples | for use with extended .sample file (actually hardly ever used)
	### * exclusion_nonMales.list          -- excludes all female samples | for use with extended .sample file (actually hardly ever used)
	### * exclusion_nonCEA_AEGS.list       -- excludes all non-AEGS samples & non-CEA samples | for use with extended .sample file (actually hardly ever used)
	### * exclusion_nonCEA.list            -- excludes all non-CEA samples | THIS IS THE DEFAULT
	### * exclusion_nonCEA_Females.list    -- excludes all non-CEA samples & all females
	### * exclusion_nonCEA_Males.list      -- excludes all non-CEA samples & all males
	### * exclusion_nonCEA_CKD.list        -- excludes all non-CEA samples & with CKD
	### * exclusion_nonCEA_nonCKD.list     -- excludes all non-CEA samples & without CKD
	### * exclusion_nonCEA_T2D.list        -- excludes all non-CEA samples & who have type 2 diabetes
	### * exclusion_nonCEA_nonT2D.list     -- excludes all non-CEA samples & who don't have type 2 diabetes
	### * exclusion_nonCEA_SMOKER.list     -- excludes all non-CEA samples & who are smokers 
	### * exclusion_nonCEA_nonSMOKER.list  -- excludes all non-CEA samples & who are non-smokers
	### * exclusion_nonCEA_pre2007.list    -- excludes all non-CEA samples & who were included before 2007
	### * exclusion_nonCEA_post2007.list   -- excludes all non-CEA samples & who were included after 2007
	
	### Required input exclusion-list format:
	### SampleID123X
	### SampleID123Y
	### SampleID123Z
	
	### Determine which reference and thereby input data to use, arg1 [1kGp3v5GoNL5/1kGp1v3/GoNL4] 
	if [[ ${STUDY_TYPE} = "AEGS" ]]; then
		if [[ ${EXCLUSION} = "EXCL_DEFAULT" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA.list
		elif [[ ${EXCLUSION} = "EXCL_FEMALES" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_Females.list
		elif [[ ${EXCLUSION} = "EXCL_MALES" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_Males.list
		elif [[ ${EXCLUSION} = "EXCL_CKD" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_CKD.list
		elif [[ ${EXCLUSION} = "EXCL_NONCKD" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_nonCKD.list	
		elif [[ ${EXCLUSION} = "EXCL_T2D" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_T2D.list
		elif [[ ${EXCLUSION} = "EXCL_NONT2D" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_nonT2D.list
		elif [[ ${EXCLUSION} = "EXCL_SMOKER" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_SMOKER.list
		elif [[ ${EXCLUSION} = "EXCL_NONSMOKER" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_nonSMOKER.list
		elif [[ ${EXCLUSION} = "EXCL_PRE2007" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_pre2007.list
		elif [[ ${EXCLUSION} = "EXCL_POST2007" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCEA_post2007.list
		else
		### If arguments are not met then this error message will be displayed 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " [EXCL_DEFAULT]   * exclusion_nonCEA.list            -- excludes all non-CEA samples | THIS IS THE DEFAULT"
			echo " [EXCL_FEMALES]   * exclusion_nonCEA_Females.list    -- excludes all non-CEA samples & all females"
			echo " [EXCL_MALES]     * exclusion_nonCEA_Males.list      -- excludes all non-CEA samples & all males"
			echo " [EXCL_CKD]       * exclusion_nonCEA_CKD.list        -- excludes all non-CEA samples & with CKD"
			echo " [EXCL_NONCKD]    * exclusion_nonCEA_nonCKD.list     -- excludes all non-CEA samples & without CKD"
			echo " [EXCL_T2D]       * exclusion_nonCEA_T2D.list        -- excludes all non-CEA samples & who have type 2 diabetes"
			echo " [EXCL_NONT2D]    * exclusion_nonCEA_nonT2D.list     -- excludes all non-CEA samples & who *do not* have type 2 diabetes"
			echo " [EXCL_SMOKER]    * exclusion_nonCEA_SMOKER.list     -- excludes all non-CEA samples & who are smokers "
			echo " [EXCL_NONSMOKER] * exclusion_nonCEA_nonSMOKER.list  -- excludes all non-CEA samples & who are non-smokers"
			echo " [EXCL_PRE2007]   * exclusion_nonCEA_pre2007.list    -- excludes all non-CEA samples & who were included before 2007; AE exclusive"
			echo " [EXCL_POST2007]  * exclusion_nonCEA_post2007.list   -- excludes all non-CEA samples & who were included after 2007; AE exclusive"
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			exit 1
		fi
	elif [[ ${STUDY_TYPE} = "AAGS" ]]; then
		#if [[ ${EXCLUSION} = "EXCL_DEFAULT" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA.list
		#elif [[ ${EXCLUSION} = "EXCL_FEMALES" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_Females.list
		#elif [[ ${EXCLUSION} = "EXCL_MALES" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_Males.list
		#elif [[ ${EXCLUSION} = "EXCL_CKD" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_CKD.list
		#elif [[ ${EXCLUSION} = "EXCL_NONCKD" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_nonCKD.list	
		#elif [[ ${EXCLUSION} = "EXCL_T2D" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_T2D.list
		#elif [[ ${EXCLUSION} = "EXCL_NONT2D" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_nonT2D.list
		#elif [[ ${EXCLUSION} = "EXCL_SMOKER" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_SMOKER.list
		#elif [[ ${EXCLUSION} = "EXCL_NONSMOKER" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_nonSMOKER.list
		#elif [[ ${EXCLUSION} = "EXCL_PRE2007" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_pre2007.list
		#elif [[ ${EXCLUSION} = "EXCL_POST2007" ]]; then
		#	EXCLUSION_LIST=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_BBMRI_1000Gp1v3/exclusion_nonCEA_post2007.list
		#else
			echo ""
			echo " THIS OPTION IS NOT YET AVAILABLE"
			echo ""
			### If arguments are not met then this error message will be displayed 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " [EXCL_DEFAULT]   * exclusion_nonAAAGS.list            -- excludes all non-AAAGS samples | THIS IS THE DEFAULT"
			echo " [EXCL_FEMALES]   * exclusion_nonAAAGS_FEMALES.list    -- excludes all non-AAAGS samples & all females"
			echo " [EXCL_MALES]     * exclusion_nonAAAGS_MALES.list      -- excludes all non-AAAGS samples & all males"
			echo " [EXCL_CKD]       * exclusion_nonAAAGS_CKD.list        -- excludes all non-AAAGS samples & with CKD"
			echo " [EXCL_NONCKD]    * exclusion_nonAAAGS_nonCKD.list     -- excludes all non-AAAGS samples & without CKD"
			echo " [EXCL_T2D]       * exclusion_nonAAAGS_T2D.list        -- excludes all non-AAAGS samples & who have type 2 diabetes"
			echo " [EXCL_NONT2D]    * exclusion_nonAAAGS_nonT2D.list     -- excludes all non-AAAGS samples & who *do not* have type 2 diabetes"
			echo " [EXCL_SMOKER]    * exclusion_nonAAAGS_SMOKER.list     -- excludes all non-AAAGS samples & who are smokers "
			echo " [EXCL_NONSMOKER] * exclusion_nonAAAGS_nonSMOKER.list  -- excludes all non-AAAGS samples & who are non-smokers"
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			exit 1
  		#fi
	elif [[ ${STUDY_TYPE} = "CTMM" ]]; then
		if [[ ${EXCLUSION} = "EXCL_DEFAULT" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCTMM.list
		elif [[ ${EXCLUSION} = "EXCL_FEMALES" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCTMM_FEMALES.list
		elif [[ ${EXCLUSION} = "EXCL_MALES" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCTMM_MALES.list
		elif [[ ${EXCLUSION} = "EXCL_T2D" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCTMM_T2D.list
		elif [[ ${EXCLUSION} = "EXCL_NONT2D" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCTMM_nonT2D.list
		elif [[ ${EXCLUSION} = "EXCL_SMOKER" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCTMM_SMOKER.list
		elif [[ ${EXCLUSION} = "EXCL_NONSMOKER" ]]; then
			EXCLUSION_LIST=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/exclusion_nonCTMM_nonSMOKER.list
		else
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " [EXCL_DEFAULT]   * exclusion_nonCTMM.list            -- excludes all non-CTMM samples | THIS IS THE DEFAULT"
			echo " [EXCL_FEMALES]   * exclusion_nonCTMM_FEMALES.list    -- excludes all non-CTMM samples & all females"
			echo " [EXCL_MALES]     * exclusion_nonCTMM_MALES.list      -- excludes all non-CTMM samples & all males"
			#echo " [EXCL_CKD]       * exclusion_nonCEA_CKD.list        -- excludes all non-CTMM samples & with CKD"
			#echo " [EXCL_NONCKD]    * exclusion_nonCEA_nonCKD.list     -- excludes all non-CTMM samples & without CKD"
			echo " [EXCL_T2D]       * exclusion_nonCTMM_T2D.list        -- excludes all non-CTMM samples & who have type 2 diabetes"
			echo " [EXCL_NONT2D]    * exclusion_nonCTMM_nonT2D.list     -- excludes all non-CTMM samples & who *do not* have type 2 diabetes"
			echo " [EXCL_SMOKER]    * exclusion_nonCTMM_SMOKER.list     -- excludes all non-CTMM samples & who are smokers "
			echo " [EXCL_NONSMOKER] * exclusion_nonCTMM_nonSMOKER.list  -- excludes all non-CTMM samples & who are non-smokers"
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			exit 1
  		fi
	else
		### If arguments are not met then this error message will be displayed 
			script_arguments_error_studytype
	fi
		
	echo "All arguments are passed and correct. These are the settings:"
	### Set location of SNPTEST v2.5.2 & the method to be used.
	SNPTEST=/hpc/local/CentOS7/dhl_ec/software/snptest_v2.5.2_CentOS6.5_x86_64_static/snptest_v2.5.2
	
	### Set input-data
	
	### Required input phenotype-list format: -- should be 'binary' OR 'continuous'
	### TRAIT1
	### TRAIT2
	### TRAIT3
	
	### Required input covariate-list format:
	### COVA COVB COVC
	
	PHENOTYPE_FILE=${6} 
	COVARIATE_FILE=${7} 
	PHENOTYPES=$(cat "$PHENOTYPE_FILE") # which phenotypes to investigate anyway
	COVARIATES=$(cat "$COVARIATE_FILE") # covariate list
	
	### Set the project directory
	PROJECT=${8}
	
	### Set the BASH qsub queue.
	QMEM=${9}
	QTIME=${10}
	
	### Set your email address.
	YOUREMAIL=${11}
	MAILSETTINGS=${12} 
	
	### Set location of the individual, regional and GWAS scripts
	GWAS_SCRIPTS=/hpc/local/CentOS7/dhl_ec/software/GWASToolKit
	
	### Report back these variables
	if [[ ${ANALYSIS_TYPE} = "GWAS" ]]; then
		TRAIT_TYPE=${13} # depends on arg11
		STANDARDIZE=${14} # depends on arg14
		echo "SNPTEST is located here.................................................: ${SNPTEST}"
		echo "The analysis scripts are located here...................................: ${GWAS_SCRIPTS}"
		echo "The following dataset will be used......................................: ${STUDY_TYPE}"
		echo "The reference used, either 1kGp3v5+GoNL5, 1kGp1v3, GoNL4................: ${REFERENCE}"
		echo "The analysis will be run using the following method.....................: ${METHOD}"
		echo "The analysis will be run using the following exclusion list.............: ${EXCLUSION_LIST}"
		echo "The analysis will be run using the following phenotypes.................: "
		for PHENOTYPE in ${PHENOTYPES}; do
			echo "     * ${PHENOTYPE}"
		done
		echo "The type of phenotypes..................................................: ${TRAIT_TYPE}"
		echo "The analysis will be run using the following covariates.................: ${COVARIATES}"
		echo "The project directory is................................................: ${PROJECT}"
		echo "The following e-mail address will be used for communication.............: ${YOUREMAIL}"
		echo "These are you mailsettings..............................................: ${MAILSETTINGS}"
		echo "The following analysis type will be run.................................: ${ANALYSIS_TYPE}"
		### Starting of the script
		echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		echo "                                     SUBMIT ACTUAL GENOME-WIDE ANALYSIS"
		echo ""
		echo "Please be patient as we are creating jobs to submit genome-wide analysis of each phenotype..."
		echo "We started at: "$(date)
		echo ""
	elif [[ ${ANALYSIS_TYPE} = "VARIANT" ]]; then
		### Setting variant list
		VARIANTLIST=${13}
		#CHR=${13}
		TRAIT_TYPE=${14}
		echo "SNPTEST is located here.................................................: ${SNPTEST}"
		echo "The analysis scripts are located here...................................: ${GWAS_SCRIPTS}"
		echo "The following dataset will be used......................................: ${STUDY_TYPE}"
		echo "The reference used, either 1kGp3v5+GoNL5, 1kGp1v3, GoNL4................: ${REFERENCE}"
		echo "The analysis will be run using the following method.....................: ${METHOD}"
		echo "The analysis will be run using the following exclusion list.............: ${EXCLUSION_LIST}"
		echo "The analysis will be run using the following phenotypes.................: "
		for PHENOTYPE in ${PHENOTYPES}; do
			echo "     * ${PHENOTYPE}"
		done
		echo "The type of phenotypes..................................................: ${TRAIT_TYPE}"
		echo "The analysis will be run using the following covariates.................: ${COVARIATES}"
		echo "The project directory is................................................: ${PROJECT}"
		echo "The following e-mail address will be used for communication.............: ${YOUREMAIL}"
		echo "These are you mailsettings..............................................: ${MAILSETTINGS}"
		echo "The following analysis type will be run.................................: ${ANALYSIS_TYPE}"
		echo "The following list of variants will be used.............................: ${VARIANTLIST} on chromosome ${CHR}"
		### Starting of the script
		echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		echo "                                    SUBMIT ACTUAL INDIVIDUAL VARIANT ANALYSIS"
		echo ""
		echo "Please be patient as we are creating jobs to submit individual variant analysis of each phenotype..."
		echo "We started at: "$(date)
		echo ""
	elif [[ ${ANALYSIS_TYPE} = "REGION" ]]; then
		### Setting variant list
		CHR=${13}
		REGION_START=${14}
		REGION_END=${15}
		TRAIT_TYPE=${16}
		echo "SNPTEST is located here.................................................: ${SNPTEST}"
		echo "The analysis scripts are located here...................................: ${GWAS_SCRIPTS}"
		echo "The following dataset will be used......................................: ${STUDY_TYPE}"
		echo "The reference used, either 1kGp3v5+GoNL5, 1kGp1v3, GoNL4................: ${REFERENCE}"
		echo "The analysis will be run using the following method.....................: ${METHOD}"
		echo "The analysis will be run using the following exclusion list.............: ${EXCLUSION_LIST}"
		echo "The analysis will be run using the following phenotypes.................: "
		for PHENOTYPE in ${PHENOTYPES}; do
			echo "     * ${PHENOTYPE}"
		done
		echo "The type of phenotypes..................................................: ${TRAIT_TYPE}"
		echo "The analysis will be run using the following covariates.................: ${COVARIATES}"
		echo "The project directory is................................................: ${PROJECT}"
		echo "The following e-mail address will be used for communication.............: ${YOUREMAIL}"
		echo "These are you mailsettings..............................................: ${MAILSETTINGS}"
		echo "The following analysis type will be run.................................: ${ANALYSIS_TYPE}"
		echo "The chromosomal region will be analysed.................................: chromosome ${CHR}:${REGION_START}-${REGION_END}"
		### Starting of the script
		echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		echo "                                      SUBMIT ACTUAL REGIONAL ANALYSIS"
		echo ""
		echo "Please be patient as we are creating jobs to submit regional analysis of each phenotype..."
		echo "We started at: "$(date)
		echo ""
	elif [[ ${ANALYSIS_TYPE} = "GENES" ]]; then
		### Setting variant list
		GENES_FILE=${13}
		GENES=$(cat ${GENES_FILE})
		RANGE=${14}
		TRAIT_TYPE=${15}
		echo "SNPTEST is located here.................................................: ${SNPTEST}"
		echo "The analysis scripts are located here...................................: ${GWAS_SCRIPTS}"
		echo "The following dataset will be used......................................: ${STUDY_TYPE}"
		echo "The reference used, either 1kGp3v5+GoNL5, 1kGp1v3, GoNL4................: ${REFERENCE}"
		echo "The analysis will be run using the following method.....................: ${METHOD}"
		echo "The analysis will be run using the following exclusion list.............: ${EXCLUSION_LIST}"
		echo "The analysis will be run using the following phenotypes.................: "
		for PHENOTYPE in ${PHENOTYPES}; do
			echo "     * ${PHENOTYPE}"
		done
		echo ""
		echo "The type of phenotypes..................................................: ${TRAIT_TYPE}"
		echo "The analysis will be run using the following covariates.................: ${COVARIATES}"
		echo "The project directory is................................................: ${PROJECT}"
		echo "The following e-mail address will be used for communication.............: ${YOUREMAIL}"
		echo "These are you mailsettings..............................................: ${MAILSETTINGS}"
		echo "The following analysis type will be run.................................: ${ANALYSIS_TYPE}"
		echo "The following genes will be analysed....................................: "
		for GENE in ${GENES}; do
			echo "     * ${GENE}"
		done
		echo ""
		echo "The following range around genes will be taken..........................: ${RANGE}"
		echo "The following gene list will be used....................................: ${HG19_GENES}"
		### Starting of the script
		echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		echo "                                      SUBMIT ACTUAL PER-GENE ANALYSIS"
		echo ""
		echo "Please be patient as we are creating jobs to submit regional analysis of each phenotype..."
		echo "We started at: "$(date)
		echo ""
	else
		### If arguments are not met then this error message will be displayed 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [GWAS]         -- uses a total of 10 arguments | THIS IS THE DEFAULT."
			echo " * [VARIANT]      -- uses 12 arguments, and should indicate a variant-list and the chromosome."
			echo " * [REGION]       -- uses 13 arguments, and should indicate the chromosomal range."
			echo ""
			echo " Please refer to instruction above."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			exit 1
	fi
	
	### Set the phenotype file:
	if [[ ${STUDY_TYPE} = "AEGS" ]]; then
		SAMPLE_FILE=/hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_IMPUTE2_1000Gp3_GoNL5/aegscombo_cov_pheno.sample
	
	elif [[ ${STUDY_TYPE} = "AAGS" ]]; then
		SAMPLE_FILE=/hpc/dhl_ec/data/_aaa_originals/AAAGS_IMPUTE2_1000Gp3_GoNL5/aagsphenocov.sample
		echo ""
		echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
		echo ""
		echo " Unfortunately using ${STUDY_TYPE} as a 'STUDY_TYPE' is not an option yet -- we have to create the pheno-cov file!"
		echo ""
		echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		exit 1
	
	elif [[ ${STUDY_TYPE} = "CTMM" ]]; then
		SAMPLE_FILE=/hpc/dhl_ec/data/_ctmm_originals/CTMMAxiomTX_IMPUTE2_1000Gp3_GoNL5/ctmmphenocov.sample
	
	else
		### If arguments are not met then this error message will be displayed
			script_arguments_error_studytype
	fi
	

	### Make and/or set the output directory
	if [ ! -d ${PROJECT}/snptest_results ]; then
  		echo "The output directory does not exist. Making and setting it."
  		mkdir -v ${PROJECT}/snptest_results
  		OUTPUT_DIR=${PROJECT}/snptest_results
	else
  		echo "The output directory already exists. Setting it."
  		OUTPUT_DIR=${PROJECT}/snptest_results
	fi

	if [[ ${ANALYSIS_TYPE} = "GWAS" ]]; then
		echo "Submit jobs to perform GWAS on your phenotype(s)..."
		### Run SNPTEST for each phenotype
		for PHENOTYPE in ${PHENOTYPES}; do
		### Make and/or set the output directory
			if [ ! -d ${OUTPUT_DIR}/${PHENOTYPE} ]; then
  				echo "The output directory does not exist. Making and setting it."
  				mkdir -v ${OUTPUT_DIR}/${PHENOTYPE}
  				PHENO_OUTPUT_DIR=${OUTPUT_DIR}/${PHENOTYPE}
			else
  				echo "The output directory already exists. Setting it."
  				PHENO_OUTPUT_DIR=${OUTPUT_DIR}/${PHENOTYPE}
			fi
		echo "Analysing the phenotype ${PHENOTYPE}."
			for CHR in $(seq 1 22) X; do
				echo "Processing the following chromosome ${CHR}."
				#if [[ ${STUDY_TYPE} = "AEGS" && ${REFERENCE} = "1kGp1v3" || ${REFERENCE} = "1kGp3v5GoNL5" || ${REFERENCE} = "GoNL4" ]]; then 
				if [[ ${STUDY_TYPE} = "AEGS" ]]; then 
					if [[ ${STANDARDIZE} = "STANDARDIZE" ]]; then
						echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.bgen ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
						qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
					elif [[ ${STANDARDIZE} = "RAW" ]]; then
						echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.bgen ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
						qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
					else
						### If arguments are not met then this error message will be displayed
						script_arguments_error_normalization
					fi

				elif [[ ${STUDY_TYPE} = "AAGS" ]]; then
					if [[ ${STANDARDIZE} = "STANDARDIZE" ]]; then
						echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
						qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
					elif [[ ${STANDARDIZE} = "RAW" ]]; then
						echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
						qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
					else
						### If arguments are not met then this error message will be displayed
						script_arguments_error_normalization
					fi
				
				elif [[ ${STUDY_TYPE} = "CTMM" ]]; then
					if [[ ${STANDARDIZE} = "STANDARDIZE" ]]; then
						echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.bgen ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
						qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
					elif [[ ${STANDARDIZE} = "RAW" ]]; then
						echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.bgen ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
						qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}.sh
					else
						### If arguments are not met then this error message will be displayed
						script_arguments_error_normalization
					fi
				
				else
					### If arguments are not met then this error message will be displayed
					script_arguments_error_studytype
				fi
				echo ""
				echo "/////////////////////////////////////////////////////////////////////////////////////////////////////////"
				echo ""
			done
			### Create wrap-up bash-script to send to qsub
			echo "${GWAS_SCRIPTS}/snptest_pheno_wrapper.v1.sh ${PHENO_OUTPUT_DIR} ${TRAIT_TYPE} ${ANALYSIS_TYPE} ${STUDY_TYPE} ${REFERENCE} ${PHENOTYPE} " > ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.sh
			### Submit wrap-up script
			### The option '-hold_jid' indicates that the following qsub will not start until all jobs with '-N AEGS_GWAS' are finished
			qsub -S /bin/bash -N WRAP_UP.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -hold_jid ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.log -e ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.errors -l ${QMEM} -l ${QTIME} -M ${YOUREMAIL} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.sh
			
			echo ""
		done
	elif [[ ${ANALYSIS_TYPE} = "VARIANT" ]]; then
		echo "Submit jobs to perform individual variant analysis on your phenotype(s)..."
		### Run SNPTEST for each phenotype
		for PHENOTYPE in ${PHENOTYPES}; do
		### Make and/or set the output directory
			if [ ! -d ${OUTPUT_DIR}/${PHENOTYPE} ]; then
  				echo "The output directory does not exist. Making and setting it."
  				mkdir -v ${OUTPUT_DIR}/${PHENOTYPE}
  				PHENO_OUTPUT_DIR=${OUTPUT_DIR}/${PHENOTYPE}
			else
  				echo "The output directory already exists. Setting it."
  				PHENO_OUTPUT_DIR=${OUTPUT_DIR}/${PHENOTYPE}
			fi
			while IFS='' read -r VARIANTOFINTEREST || [[ -n "$VARIANTOFINTEREST" ]]; do
				### EXAMPLE VARIANT LIST
				### rs12344 12 9029381
				### rs35467 4 171011538
				
				LINE=${VARIANTOFINTEREST}
				echo "${LINE}"
				VARIANT=$(echo "${LINE}" | awk '{ print $1 }')
				VARIANTFORFILE=$(echo "${LINE}" | awk '{ print $1 }' | sed 's/\:/_/g')
				CHR=$(echo "${LINE}" | awk '{ print $2 }')
				BP=$(echo "${LINE}" | awk '{ print $3 }')
			
				echo "Analysing the phenotype ${PHENOTYPE} for ${VARIANT} on chromosome ${CHR}."
				if [[ ${STUDY_TYPE} = "AEGS" ]]; then
					echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -snpid ${VARIANT} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${VARIANTFORFILE}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${VARIANTFORFILE}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.sh
					qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.sh

				elif [[ ${STUDY_TYPE} = "AAGS" ]]; then
					echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -snpid ${VARIANT} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${VARIANTFORFILE}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${VARIANTFORFILE}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.sh
					qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.sh

				elif [[ ${STUDY_TYPE} = "CTMM" ]]; then
					echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.bgen ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -snpid ${VARIANT} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${VARIANTFORFILE}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${VARIANTFORFILE}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.sh
					qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${VARIANTFORFILE}.chr${CHR}.sh

				else
					### If arguments are not met then this error message will be displayed
					script_arguments_error_studytype
				fi
				echo ""
				echo "/////////////////////////////////////////////////////////////////////////////////////////////////////////"
				echo ""
				### Create wrap-up bash-script to send to qsub
				echo "${GWAS_SCRIPTS}/snptest_pheno_wrapper.v1.sh ${PHENO_OUTPUT_DIR} ${TRAIT_TYPE} ${ANALYSIS_TYPE} ${STUDY_TYPE} ${REFERENCE} ${PHENOTYPE} " > ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.sh
				### Submit wrap-up script
				### The option '-hold_jid' indicates that the following qsub will not start until all jobs with '-N AEGS_GWAS' are finished
				#qsub -S /bin/bash -N WRAP_UP.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -hold_jid ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.log -e ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.errors -l ${QMEM} -l ${QTIME} -M ${YOUREMAIL} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.sh
				
				echo ""
			done < ${VARIANTLIST}
		done
	elif [[ ${ANALYSIS_TYPE} = "REGION" ]]; then
		echo "Submit jobs to perform a regional analysis on your phenotype(s)..."
		### Run SNPTEST for each phenotype
		for PHENOTYPE in ${PHENOTYPES}; do
		### Make and/or set the output directory
			if [ ! -d ${OUTPUT_DIR}/${PHENOTYPE} ]; then
  				echo "The output directory does not exist. Making and setting it."
  				mkdir -v ${OUTPUT_DIR}/${PHENOTYPE}
  				PHENO_OUTPUT_DIR=${OUTPUT_DIR}/${PHENOTYPE}
			else
  				echo "The output directory already exists. Setting it."
  				PHENO_OUTPUT_DIR=${OUTPUT_DIR}/${PHENOTYPE}
			fi
			echo "Analysing the phenotype ${PHENOTYPE} and all variants on the region ${CHR}:{REGION_START}-${REGION_END}."
			if [[ ${STUDY_TYPE} = "AEGS" ]]; then
				echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -range ${REGION_START}-${REGION_END} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.sh
				qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.sh

			elif [[ ${STUDY_TYPE} = "AAGS" ]]; then
				echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -range ${REGION_START}-${REGION_END} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.sh
				qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.sh

			elif [[ ${STUDY_TYPE} = "CTMM" ]]; then
				echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.bgen ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -range ${REGION_START}-${REGION_END} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.chr${CHR}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.chr${CHR}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.sh
				qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.chr${CHR}_${REGION_START}_${REGION_END}.sh

			else
				### If arguments are not met then this error message will be displayed
				script_arguments_error_studytype
			fi
			
			echo ""
			echo "/////////////////////////////////////////////////////////////////////////////////////////////////////////"
			echo ""
			### Create wrap-up bash-script to send to qsub
			echo "${GWAS_SCRIPTS}/snptest_pheno_wrapper.v1.sh ${PHENO_OUTPUT_DIR} ${TRAIT_TYPE} ${ANALYSIS_TYPE} ${STUDY_TYPE} ${REFERENCE} ${PHENOTYPE} " > ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.sh
			### Submit wrap-up script
			### The option '-hold_jid' indicates that the following qsub will not start until all jobs with '-N AEGS_GWAS' are finished
			qsub -S /bin/bash -N WRAP_UP.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -hold_jid ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION} -o ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.log -e ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.errors -l ${QMEM} -l ${QTIME} -M ${YOUREMAIL} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.sh
			
			echo ""
		done
	elif [[ ${ANALYSIS_TYPE} = "GENES" ]]; then
		echo "Submit jobs to perform a per gene analysis on your phenotype(s)..."
			### EXAMPLE GENE LIST HG19
			### 12 8975149 9029381 A2ML1
			### 4 170981372 171011538 AADAT
			### 15 67493012 67547536 AAGAB
			### 17 74449432 74466199 AANAT
			### 4 57204450 57253674 AASDH
			
			echo ""
			if [ ! -f ${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt ]; then
  				echo "${STUDY_TYPE}GENE_regions_of_interest.txt does not exist. Making and setting it."
  				touch ${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt
			else
  				echo "${STUDY_TYPE}GENE_regions_of_interest.txt already exists; archiving it."
		  		mv -v ${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt ${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt.bak
		  		touch ${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt
			fi
			REGIONS=${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt
			while read GENES; do 
				for GENE in $GENES; do
				echo "* ${GENE} ± ${RANGE}"
				cat ${HG19_GENES} | awk '$4=="'${GENES}'"' | awk '{ print $4, $1, ($2-'${RANGE}'), ($3+'${RANGE}') }' >> ${REGIONS}
				done
			done < ${GENES_FILE}

			echo ""
			echo "Analyzing this list of regions ± {RANGE} basepairs: "
			cat ${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt
			echo "Number of regions: "$(cat ${PROJECT}/${STUDY_TYPE}GENE_regions_of_interest.txt | wc -l)
		
		echo ""
		### Run SNPTEST for each gene and phenotype
		while IFS='' read -r REGIONOFINTEREST || [[ -n "$REGIONOFINTEREST" ]]; do
			LINE=${REGIONOFINTEREST}
			echo "${LINE}"
			GENELOCUS=$(echo "${LINE}" | awk '{print $1}')
			echo "${GENELOCUS}"
			CHR=$(echo "${LINE}" | awk '{print $2}')
			START=$(echo "${LINE}" | awk '{print $3}')
			END=$(echo "${LINE}" | awk '{print $4}')
			
			### Creating directory per gene
			if [ ! -d ${OUTPUT_DIR}/${GENELOCUS} ]; then
  				echo "The output directory does not exist. Making and setting it."
  				mkdir -v ${OUTPUT_DIR}/${GENELOCUS}
  				GENE_OUTPUT_DIR=${OUTPUT_DIR}/${GENELOCUS}
			else
  				echo "The output directory already exists. Setting it."
  				GENE_OUTPUT_DIR=${OUTPUT_DIR}/${GENELOCUS}
			fi
			for PHENOTYPE in ${PHENOTYPES}; do
				
				#### Creating directories per phenotype
				if [ ! -d ${GENE_OUTPUT_DIR}/${PHENOTYPE} ]; then
  					echo "The output directory does not exist. Making and setting it."
  					mkdir -v ${GENE_OUTPUT_DIR}/${PHENOTYPE}
  					PHENO_OUTPUT_DIR=${GENE_OUTPUT_DIR}/${PHENOTYPE}
				else
  					echo "The output directory already exists. Setting it."
  					PHENO_OUTPUT_DIR=${GENE_OUTPUT_DIR}/${PHENOTYPE}
				fi
				
				echo "Analysing the phenotype ${PHENOTYPE} and all variants of the ${GENELOCUS} locus on ${CHR} between ${START} and ${END}..."
				if [[ ${STUDY_TYPE} = "AEGS" ]]; then
					echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -range '${START}'-'${END}' -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${GENELOCUS}_${RANGE}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${GENELOCUS}_${RANGE}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh
					qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh

				elif [[ ${STUDY_TYPE} = "AAGS" ]]; then
					echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.gen.gz ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -range '${START}'-'${END}' -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${GENELOCUS}_${RANGE}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${GENELOCUS}_${RANGE}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh
					qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh

				elif [[ ${STUDY_TYPE} = "CTMM" ]]; then
					echo "${SNPTEST} -data ${IMPUTEDDATA}${CHR}.bgen ${SAMPLE_FILE} -pheno ${PHENOTYPE} -frequentist 1 -method ${METHOD} -use_raw_phenotypes -hwe -lower_sample_limit 50 -cov_names ${COVARIATES} -exclude_samples ${EXCLUSION_LIST} -range '${START}'-'${END}' -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${GENELOCUS}_${RANGE}.out -log ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${GENELOCUS}_${RANGE}.log " > ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh
					qsub -S /bin/bash -N ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE} -o ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.log -e ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.errors -l ${QMEM} -l ${QTIME} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/${STUDY_TYPE}.${ANALYSIS_TYPE}.${REFERENCE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh

				else
					### If arguments are not met then this error message will be displayed
					script_arguments_error_studytype
				fi
				
				echo ""
				echo "/////////////////////////////////////////////////////////////////////////////////////////////////////////"
				echo ""
				### Create wrap-up bash-script to send to qsub
				echo "${GWAS_SCRIPTS}/snptest_pheno_wrapper.v1.sh ${PHENO_OUTPUT_DIR} ${TRAIT_TYPE} ${ANALYSIS_TYPE} ${STUDY_TYPE} ${REFERENCE} ${PHENOTYPE} " > ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh
				### Submit wrap-up script
				### The option '-hold_jid' indicates that the following qsub will not start until all jobs with '-N ${STUDY_TYPE}.${ANALYSIS_TYPE}' are finished
				qsub -S /bin/bash -N WRAP_UP.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE} -hold_jid ${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE} -o ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.log -e ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.errors -l ${QMEM} -l ${QTIME} -M ${YOUREMAIL} -m ${MAILSETTINGS} -wd ${PHENO_OUTPUT_DIR} ${PHENO_OUTPUT_DIR}/wrap_up.${STUDY_TYPE}.${ANALYSIS_TYPE}.${PHENOTYPE}.${EXCLUSION}.${GENELOCUS}_${RANGE}.sh
				
			done
		done < ${REGIONS}
			
	else
		### If arguments are not met then this error message will be displayed 
			echo ""
			echo "      *** ERROR *** ERROR --- $(basename "${0}") --- ERROR *** ERROR ***"
			echo ""
			echo " You must supply the correct argument:"
			echo " * [GWAS]         -- uses a total of 13 arguments | THIS IS THE DEFAULT."
			echo " * [VARIANT]      -- uses 14 arguments, and the last should be a variant-list and the chromosome."
			echo " * [REGION]       -- uses 16 arguments, and the last three should indicate the chromosomal range."
			echo " * [GENES]        -- uses 14 arguments, and the last three should indicate the gene list and the range."
			echo ""
			echo " Please refer to instruction above."
			echo ""
			echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			# The wrong arguments are passed, so we'll exit the script now!
  			date
  			exit 1
	fi
	echo "Man, oh man, I'm done with submitting! That was a lot..."
	echo ""
	echo ""
	echo "All finished. All qsubs submitted, results will be summarised in summary_results.txt.gz."
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

### END of if-else statement for the number of command-line arguments passed ###
fi

script_copyright_message