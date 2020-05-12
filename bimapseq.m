mapseq_files = dir('mapsseq-master/otu_tables/*_filtered.csv');
mkdir('./outputs/');
for i = size(mapseq_files, 1)
    filename = mapseq_files(i).name;
    filename_split = strsplit(filename, '_');
    samplename = filename_split{1}
    mapseq = readtable(join(['mapsseq-master/otu_tables/', filename], ''));
    OTUs = mapseq.Var1;
    mapseq.Var1 = [];
    bimapseq_mat = table2array(mapseq);
    bimapseq_mat(bimapseq_mat > 0) = 1;
    B0 = readmatrix(join(['./outputs/', samplename, '.basis.mat.txt']));
    C0 = readmatrix(join(['./outputs/', samplename, '.coef.mat.txt']));
    [basis_mat, coef_mat] = bernoulli_mf_mxLH(bimapseq_mat, 10, B0, C0);
%     [basis_mat, coef_mat] = bernoulli_mf_mxLH_gradient(bimapseq_mat, 10, 1e-03, 1000);
    writematrix(basis_mat, join(['./outputs/', samplename, '.basis.mat.txt']));
    writematrix(coef_mat, join(['./outputs/', samplename, '.coef.mat.txt']));
end