function  [filename, JPEG_Quality,  lambda, mu1,  JPEG_Inital,  PSNR_Final,FSIM_Final,SSIM_Final, iter, diff, Time_s]     = ...
    HSSE_Deblock_Test (filename, JPEG_Quality,  lambda, mu1,  c1, c2, QF)
 
                randn ('seed',0);

                time0            =   clock;
                 
                fn               =     [filename, '.jpg'];

                I                =     imread(fn);
                
           %     I                =   imresize(I, [256, 256]);
              
         [ww, hh, kk]        =     size (I);
         
              I                   =    imresize (I, [ww-1, hh-1]);      
     
                colorI           =     I;

              if kk==3
    
                     I           =      rgb2gray (I);
          
                     y_yuv       =      rgb2ycbcr(colorI);                     
                     
                x_2_yuv(:,:,2)   =       y_yuv(:,:,2); % Copy U Componet
                  
                x_2_yuv(:,:,3)   =       y_yuv(:,:,3); % Copy V Componet                   
              end 
              
              
                                   
            [Opts]              =    HSSE_Deblock_Set ( I, JPEG_Quality, lambda, mu1,  c1, c2);

 %-------------------------------------JPEG Operator------------------------------------------%     
                           jpeg_name  = [filename '_jeg_q' num2str(JPEG_Quality)];
                           
                           imwrite(I, [jpeg_name '.jpg'], 'Quality',  JPEG_Quality);
                           
                           JPEG_info = imfinfo([jpeg_name '.jpg']);
 
                           JPEG_image = imread([jpeg_name '.jpg']);
 
                          
              Opts.nim                    =                          double (JPEG_image);
              
              
              JPEG_Inital                 =                           csnr ( Opts.nim, Opts.I, 0,0)
  
               [W, H]                    =                          size(I);
        
               bpp                       =                          JPEG_info.FileSize*8/(W*H);       
              
              JPEG_header_info           =                          jpeg_read([jpeg_name '.jpg']);
              
              Opts.QTable                 =                          JPEG_header_info.quant_tables{1}; 
        
              Opts.blockSize              =                          8;
              
              Opts.C_q                    =                          blkproc(Opts.nim , [8 8], 'dct2'); 
        
              meanQuant                  =                          mean(mean(Opts.QTable(1:3,1:3)));
              
          %   Par.nSig                   =                          1.195.*meanQuant.^0.6394 + 0.9673; %文献公式6
         
              Opts.nSig                   =                           sqrt(0.69*meanQuant^1.3); %噪声估计文献公式 6 
                            
              Opts.Qfactor                =                          QF;
              
          %    Par.Qfactor                =                          AA;

        
 %--------------------------JPEG Operator------------------------------------------%             
                     
              
               
            [im, iter, diff]             =                     HSSE_Deblocking_Main( Opts.nim, Opts, JPEG_Quality);    
             
             Time_s                      =                          (etime(clock,time0));                          
                
              PSNR_Final                 =                          csnr (im, double(I), 0, 0);

              SSIM_Final                 =                          cal_ssim (im, double(I), 0, 0);
              
              FSIM_Final                 =                          FeatureSIM (im, double(I));       
              
              
              
              
            if kk  ==3
              
               x_2_yuv(:,:,1)            =                          uint8(im);
               
            SSR_QC_Re                  =                          ycbcr2rgb(uint8(x_2_yuv));   
            end      
                    
              
              

if JPEG_Quality==1
    

Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');


if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_1_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_1_Result/',Final_Optsisng));

end




elseif JPEG_Quality==5

Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_5_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_5_Result/',Final_Optsisng));

end


elseif JPEG_Quality==10

Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_10_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_10_Result/',Final_Optsisng));

end


elseif JPEG_Quality==15

Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_15_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_15_Result/',Final_Optsisng));

end


elseif JPEG_Quality==20
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_20_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_20_Result/',Final_Optsisng));

end

elseif JPEG_Quality==30
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_30_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_30_Result/',Final_Optsisng));

end


elseif JPEG_Quality==40
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_40_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_40_Result/',Final_Optsisng));

end

elseif JPEG_Quality==50
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_50_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_50_Result/',Final_Optsisng));

end


elseif JPEG_Quality==60
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_60_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_60_Result/',Final_Optsisng));

end


elseif JPEG_Quality==70
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_70_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_70_Result/',Final_Optsisng));

end


elseif JPEG_Quality==80
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_80_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_80_Result/',Final_Optsisng));

end



else
    
    
    
Final_Optsisng= strcat(filename,'_HSSE','_JQ_',num2str(JPEG_Quality),'_PSNR_',num2str(PSNR_Final),'_FSIM_',num2str(FSIM_Final), '_SSIM_',num2str(SSIM_Final),'.png');

if kk==3

imwrite(uint8(SSR_QC_Re),strcat('./JQ_90_Result/',Final_Optsisng));

else
imwrite(uint8(im),strcat('./JQ_90_Result/',Final_Optsisng));

end




end              
              
end

