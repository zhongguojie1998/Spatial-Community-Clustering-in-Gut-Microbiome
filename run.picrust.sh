#!/bin/bash
cd picrust2-2.3.0-b/
rm -r *.out/
picrust2_pipeline.py -s mapseq.input/table1_otus.fa -i mapseq.input/t2codl.basis.mat.tsv -o t2codl.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/t1codl.basis.mat.tsv -o t1codl.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/sm1si6.basis.mat.tsv -o sm1si6.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/sm1cec.basis.mat.tsv -o sm1cec.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/sm1cod.basis.mat.tsv -o sm1cod.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/sm1cods.basis.mat.tsv -o sm1cods.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/sm2si6.basis.mat.tsv -o sm2si6.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/sm2cec.basis.mat.tsv -o sm2cec.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table2_otus.fa -i mapseq.input/sm2cods.basis.mat.tsv -o sm2cods.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table3_otus.fa -i mapseq.input/lf2t1.basis.mat.tsv -o lf2t1.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table3_otus.fa -i mapseq.input/lf2t2.basis.mat.tsv -o lf2t2.out/ -p 12
picrust2_pipeline.py -s mapseq.input/table3_otus.fa -i mapseq.input/hf1.basis.mat.tsv -o hf1.out/ -p 12
cd ../
