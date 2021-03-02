function [errors,solutions,femregion,Dati]=es3_main1D(TestName,nRef)
%==========================================================================
% Solution of the Poisson's problem with linear finite elements
% (Dirichlet boundary conditions)
%==========================================================================
%
%    INPUT:
%          TestName    : (string)  identifier of the test (see data file)
%          nRef        : (int)     refinement level
%
%    OUTPUT:
%          errors      : (struct) contains the computed errors
%          solutions   : (sparse) nodal values of the computed and exact
%                        solution
%          femregion   : (struct) infos about finite elements
%                        discretization
%          Dati        : (struct)  see data file
%          
% Example of usage: 
%    [errors,solutions,femregion,Dati] = C_main1D('Test1',3)
 


addpath C:\Users\zhzj\github\labo\Numerica\FEM4MI\Assembly
addpath C:\Users\zhzj\github\labo\Numerica\FEM4MI\BoundaryConditions
addpath C:\Users\zhzj\github\labo\Numerica\FEM4MI\Errors
addpath C:\Users\zhzj\github\labo\Numerica\FEM4MI\MeshGeneration
addpath C:\Users\zhzj\github\labo\Numerica\FEM4MI\FESpace
addpath C:\Users\zhzj\github\labo\Numerica\FEM4MI\Postprocessing


%==========================================================================
% LOAD DATA FOR TEST CASE
%==========================================================================

Dati = es3_dati(TestName);
Dati.nRefinement = nRef;

%==========================================================================
% MESH GENERATION
%==========================================================================

[Region] = C_create_mesh(Dati);

%==========================================================================
% FINITE ELEMENT REGION
%==========================================================================

[femregion] = C_create_femregion(Dati,Region); 

%==========================================================================
% BUILD FINITE ELEMENT MATRICES and RIGHT-HAND SIDE
%==========================================================================

[A_no_bc,b_no_bc] = C_matrix1D(Dati,femregion);

%==========================================================================
% COMPUTE BOUNDARY CONDITIONS -- MODIFICATION OF A an b
%==========================================================================

[A,b,u_g] = C_bound_cond1D(A_no_bc,b_no_bc,femregion,Dati);

%==========================================================================
% SOLVE THE LINEAR SYSTEM
%==========================================================================
% a - fattorizzazione LU

    tic;
    [L,U,P] = lu(A);
    y = fwsub(L, P*b);
    uh = bksub(U, y);
    timeLU = toc
    
% b - fattorizzazione di Choleski
    tic
    R = chol(A);
    y = fwsub(R',b);
    uh = bksub(R,y);
    timeChol = toc
    
% c - metodo analitico
    tic
    uh = A\b;
    timeBackSlash = toc

%==========================================================================
% ASSIGN DIRICHLET BOUNDARY CONDITIONS -- through the lifting ug
%==========================================================================

uh = uh + u_g;

%==========================================================================
% POST-PROCESSING OF THE SOLUTION
%==========================================================================

[solutions] = C_postprocessing(Dati,femregion,uh);

%==========================================================================
% ERROR ANALYSIS
%==========================================================================
errors = [];
if (Dati.plot_errors)
    [errors] = C_compute_errors(Dati,femregion,solutions);
end



