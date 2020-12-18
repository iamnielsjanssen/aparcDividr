#!/usr/bin/Rscript
# Create dividr!
# Cut the aparc+aseg rois into 27 smaller pieces
#
# Niels Janssen, DEC 2020

rm(list=ls(all=TRUE)) 

args = commandArgs(trailingOnly=TRUE)

##args is now a list of character vectors
## First check to see if arguments are passed.
## Then cycle through each element of the list and evaluate the expressions.
if(length(args)==0){
    print("aparc+aseg dividr - Niels Janssen December 2020")
    print("Cut each cortical and subcortical roi in aparc+aseg atlas into 27 pieces")
    print("Usage: ")
    print("./aparc_dividr.R <aparc+aseg.nii.gz>")
    print("Output <aparc+aseg_dividr.nii.gz> in the same folder")
    quit(save="no")
}

pkgTest <- function(x){
    if (!require(x,character.only = TRUE))
    {
      install.packages(x,dep=TRUE)
        if(!require(x,character.only = TRUE)) stop("Package not found")
    }
}

pkgTest("RNifti")

# set in- and output files
infile=args[1]
if (!file.exists(infile)){
  cat("File:",infile,"not found!\n")
  quit(save="no")
}

# strip extension and set output name (assume path/to/file.nii.gz)
outfile=basename(tools::file_path_sans_ext(tools::file_path_sans_ext(infile)))
outnifti=paste(outfile,"_dividr.nii.gz",sep="")
outlabs=paste(outfile,"_labels.txt",sep="")

# we only want subcortical and cortical rois (no CC, ventricles, etc)
roinums=c(8,10,11,12,13,16,17,18,26,28,47,49,50,51,52,53,54,58,60,1001:1003,1005:1035,2001:2003,2005:2035)
fslut = read.table("/usr/local/freesurfer/FreeSurferColorLUT.txt")


# load the aparc from a specific subject
cat("Reading file:",infile,"\n")
aparc = readNifti(infile)

# determine which ROIs are actually present
roipres = unique(as.numeric(aparc))
roinums = roinums[roinums %in% roipres]
labs = fslut[fslut$V1 %in% roinums,]

# copy and remove all unwanted rois
newaparc = aparc
newaparc[]=0L

# do work
cat("Dividing Rois\n")
globallabel=0
for (rn in roinums){
  cat("roinum:", rn,"\n")
  roi = aparc
  roi[roi!=rn]=0
  roi[roi==rn]=1

  # divide the shape in 9 equal pieces
  coords = as.data.frame(which(roi==1, arr.ind=TRUE))
  colnames(coords)=c("x","y","z")
  
  sizex = c(min(coords$x),max(coords$x))
  sizey = c(min(coords$y),max(coords$y))
  sizez = c(min(coords$z),max(coords$z))
  
  dx = round(seq(sizex[1],sizex[2],length.out = 4),0)
  dy = round(seq(sizey[1],sizey[2],length.out = 4),0)
  dz = round(seq(sizez[1],sizez[2],length.out = 4),0)
  
  # create grid
  mat = array(0,dim=dim(roi))
  
  # x-direction grid
  mat[dx[1]:dx[2],dy[1]:dy[4],dz[1]:dz[4]]=1+globallabel
  mat[dx[2]:dx[3],dy[1]:dy[4],dz[1]:dz[4]]=2+globallabel
  mat[dx[3]:dx[4],dy[1]:dy[4],dz[1]:dz[4]]=3+globallabel
  
  # y-direction grid
  mat[dx[1]:dx[4],dy[1]:dy[2],dz[1]:dz[4]]=mat[dx[1]:dx[4],dy[1]:dy[2],dz[1]:dz[4]]+0
  mat[dx[1]:dx[4],(dy[2]+1):dy[3],dz[1]:dz[4]]=mat[dx[1]:dx[4],(dy[2]+1):dy[3],dz[1]:dz[4]]+3
  mat[dx[1]:dx[4],(dy[3]+1):dy[4],dz[1]:dz[4]]=mat[dx[1]:dx[4],(dy[3]+1):dy[4],dz[1]:dz[4]]+6
  
  # z-direction grid
  mat[dx[1]:dx[4],dy[1]:dy[4],dz[1]:dz[2]]=mat[dx[1]:dx[4],dy[1]:dy[4],dz[1]:dz[2]]+0
  mat[dx[1]:dx[4],dy[1]:dy[4],(dz[2]+1):dz[3]]=mat[dx[1]:dx[4],dy[1]:dy[4],(dz[2]+1):dz[3]]+9
  mat[dx[1]:dx[4],dy[1]:dy[4],(dz[3]+1):dz[4]]=mat[dx[1]:dx[4],dy[1]:dy[4],(dz[3]+1):dz[4]]+18
  
  # apply the grid to the roi
  newroi = roi * mat
  
  # concatenate each label with the current roinum
  # newroi[newroi>1] = as.numeric(paste(rn,newroi[newroi>1],sep=""))
  
  newaparc = newaparc + newroi
  globallabel=globallabel+27
}

# Some output
maxlab = max(as.numeric(newaparc))
cat("New labels run from 1 to", maxlab,"(check file",outlabs,"for details)\n")

# save new aparc+aseg file
cat("Writing new nifti:",outnifti,"\n")
writeNifti(newaparc, file=outnifti)

# construct and save label file
labrep = paste(gl(length(labs$V2),27,labels=labs$V2),1:27,sep="")
labtot = paste(gl(length(labs$V2),27,labels=labs$V2),1:globallabel,sep="")
labs = data.frame(labrep = labrep, labtot = labtot)
cat("Writing label file:",outlabs,"\n")
write.table(labs, file=outlabs, row.names = FALSE, col.names = FALSE)
