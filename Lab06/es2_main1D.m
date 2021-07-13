function [errors,solutions,femregion,Dati]=es2_main1D(TestName,nRef)
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
 


addpath ..\FEM4MI\Assembly
addpath ..\FEM4MI\BoundaryConditions
addpath ..\FEM4MI\Errors
addpath ..\FEM4MI\MeshGeneration
addpath ..\FEM4MI\FESpace
addpath ..\FEM4MI\Postprocessing


%==========================================================================
% LOAD DATA FOR TEST CASE
%==========================================================================

Dati = es2_dati(TestName);
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


A = full(A);                    % ricordando che A è sparsa
x0 = zeros(size(b));
P = eye(size(A));               % P = I 
tol = 1e-12; nmax = 1e4;

% a) implementazione col metodo di richardson
alpha_opt = 2/( min(eig(A)) + max(eig(A)) );
[uh, k] = richardson( A, b, P, x0, tol, nmax, alpha_opt );
fprintf('\n');

%==========================================================================
% CONDIZIONE SUFFICIENTE PER LA CONVERGENZA DEL METODO DEL GRADIENTE
%==========================================================================

% A sdp => il metodo del gradiente converga

if isequal( A, A' )
    if all( eig(A) > 0 )
        disp('A è una matrice sdp');
    end
else
    disp('A non è una matrice sdp');
end

% d) implementazione col metodo del gradiente
[uh, k] = gradiente( A, b, P, x0, tol, nmax );

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