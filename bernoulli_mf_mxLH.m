function [leftMatrix, rightMatrix] = bernoulli_mf_mxLH(originMat, K, B0, C0)
    % global originMat; %% origin Mat
    % global F; %% number of rows
    % global N; %% number of cols
    % global K; %% number of factors
    F = size(originMat, 1);
    N = size(originMat, 2);
    save('temp.mat', 'F', 'N', 'K', 'originMat', '-v7.3'); 
    function target = target_fun(X, originMat, K) %% target function
        F = size(originMat, 1);
        N = size(originMat, 2);
        Bmat = reshape(X(1:F*K), [F, K]);
        Cmat = reshape(X(F*K+1:F*K+K*N), [K, N]);
        Zmat = Bmat * Cmat;
        loglikelihood = originMat .* log(Zmat) + (1-originMat) .* log(1-Zmat);
        target = -sum(sum(loglikelihood));
    end
    Aeq = zeros(K, F*K+K*N);
    for k = 1:K
        Aeq(k, (k-1)*F+1:k*F) = ones(1, F);
    end
    Beq = ones(K, 1);
    X0 = zeros(F*K+K*N, 1);
    if ~exist('B0','var')
        B0 = rand([F, K]);
        B0 = B0 / diag(sum(B0)); 
    end
    if ~exist('C0','var')
        C0 = rand([K, N]); 
    end
    X0(1:F*K) = B0(:);
    X0(F*K+1:F*K+K*N) = C0(:);
    options = optimoptions(@fmincon,'MaxFunctionEvaluations',100*(F*K+K*N),'MaxIterations',100, 'OptimalityTolerance', 1e-02, 'StepTolerance', 1e-02);
    argmax = fmincon(@(x) target_fun(x, originMat, K), X0, [], [], Aeq, Beq, zeros(size(X0)), [], [], options);
    leftMatrix = reshape(argmax(1:F*K), [F, K]);
    rightMatrix = reshape(argmax(F*K+1:F*K+K*N), [K, N]);
end