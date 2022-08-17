
function  [ Opts]   =    HSSE_Deblock_Set(   I, JPEG_Quality, lamada, mu1,  c1, c2)

randn ('seed',0);

Opts.I         =   double(I);

Opts.Iter      =   100;

Opts.step      =   4;         

Opts.patch     =  7;   

Opts.Sim       =  40;  


if JPEG_Quality <= 1
      
    Opts.lamada    =  lamada;   
    
    Opts. mu      =  mu1;    
    
    Opts. c1       =   c1;   

    Opts. c2        =   c2;    
    
elseif JPEG_Quality <= 5
    
    Opts.lamada    =  lamada;   
    
    Opts. mu      =  mu1;    
    
    Opts. c1       =   c1;   
       
    Opts. c2        =   c2;    
     
    
elseif JPEG_Quality <= 10
    
    Opts.lamada    =  lamada;   
    
    Opts. mu      =  mu1;    
    
    Opts. c1       =   c1;   
    
    Opts. c2        =   c2;     
    
    
 elseif JPEG_Quality <= 20
    
    Opts.lamada    =  lamada;   
    
    Opts. mu      =  mu1;    
    
    Opts. c1       =   c1;   
    
    Opts. c2        =   c2;    
    
elseif JPEG_Quality <= 30
    
    Opts.lamada    =  lamada;   
    
    Opts. mu      =  mu1;    
    
    Opts. c1       =   c1;   

    Opts. c2        =   c2;    

elseif JPEG_Quality <= 40
    
     Opts.lamada    =  lamada;   
    
    Opts. mu      =  mu1;    
    
    Opts. c1       =   c1;   
    
    Opts. c2        =   c2;     
    
else
    
    Opts.lamada    =  lamada;   
    
    Opts. mu      =  mu1;    
    
    Opts. c1       =   c1;   
    
    Opts. c2        =   c2;    
end


end

