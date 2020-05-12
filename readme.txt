Environment Requirement:
please visit https://github.com/picrust/picrust2/blob/master/INSTALL.md to install PICRUSt2 with conda and activate the conda environment before running the pipelines.

Pipeline:
1. Run bimapseq.m in matlab to get the basis matrix and coefficient matrix, which will be saved in folder "outputs/". Two files will be saved for each sample, {sample_name}.basis.mat.txt is the basis matrix and {sample_name}.coef.mat.txt is the coefficient matrix. (Matlab R2020a is recommended)
2. Run prepare.for.picrusst.R in R to prepare for the standard input for PICRUSt2. This will create a folder "picrust2-2.3.0-b/mapseq.input/" and save all the required files in it.
3. Run run.picrust.sh in bash shell to perform the PICRUSt2, the output files will be saved under "picrust2-2.3.0-b/{sample_name}.out/"
4. To reproduce the figures in the paper, run draw.bernoulli.mf.mxLH.R, top10.metagenome.R and top10.pathways.R. The figures will be saved in folder "bernoulli.mf.plots/{sample_name}/".
