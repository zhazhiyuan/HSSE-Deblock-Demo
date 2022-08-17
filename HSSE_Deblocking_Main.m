function    [im, j, diff]                    =                          HSSE_Deblocking_Main(Im_out, Opts, JPEG_Quality)

   randn ('seed',0);
   
ori_im                      =                        Opts.I; 

n_im                        =                        Im_out; 

[h1, w1]                    =                        size(ori_im); 


d_im                        =                        Im_out;  


v                           =                        Opts.nSig; 


cnt                         =                         1;


All_PSNR                    =                         zeros(1,Opts.Iter);

EN_SSP_Results             =                         cell (1,Opts.Iter);   



if JPEG_Quality <= 1
    
    
    Err_or= 0.00015;
    
elseif JPEG_Quality<=5
    
    Err_or  = 0.00012;
    
elseif JPEG_Quality<=10
    
     Err_or  = 7.95E-05;  
     
elseif JPEG_Quality<=20
    
      Err_or  = 4.47E-05;     
    
elseif JPEG_Quality<=30
    
       Err_or  = 3.32E-05;      
    
elseif JPEG_Quality<=40
    
        Err_or  = 2.60E-05;       
    
else
    
         Err_or  = 2.60E-05;         
end

for j                        =                1 : Opts.Iter
    
 
  
          d_im               =   d_im +    0.1 *(n_im - d_im);
  
  
          dif1                 =                         d_im-n_im;
        
    
          vd                   =                          v^2-(mean(mean(dif1.^2)));
        
        
       if j==1
            
            Opts.nSig             =         sqrt(abs(vd)); 
            
       else
            
             Opts.nSig            =         sqrt(abs(vd))* Opts.lamada  ;
            
       end 
       
       
       
       
            E_Out           =                    Exter_NSS_Main  (d_im, Opts, Opts.nSig);   
          
          
          E_Out_New       =                    (Opts.mu*Opts.nSig^2*Opts.nim + v^2*E_Out)/ (Opts.mu* Opts.nSig^2 + v^2+ eps);
    
   
 
    
         d_im          =                   HSSE_Core  (E_Out_New, Opts);       
       
       
  
        d_im                 =                           BDCT_project_onto_QCS(d_im, Opts.C_q, Opts.QTable, Opts.Qfactor, Opts.blockSize);
    
        
        All_PSNR(j)        =                            csnr( d_im(1:h1,1:w1), ori_im, 0, 0 );
    
      fprintf( 'HSSE  Debloking:  Preprocessing, Iter %d : PSNR = %2.2f\n', cnt,  csnr( d_im(1:h1,1:w1), ori_im, 0, 0 ));
    
         cnt   =  cnt + 1;       
         
           EN_SSP_Results{j}      =                      d_im;
         
         if j>1
             
            diff      =  norm(abs(EN_SSP_Results{j}) - abs(EN_SSP_Results{j-1}),'fro')/norm(abs(EN_SSP_Results{j-1}), 'fro');    
             
             if     diff<= Err_or
                 
                 break;
             end
             
         end
       
      
    
    
end


   %     im               =                 d_im;
        
        im               =                     EN_SSP_Results{j-1};                                      

end

