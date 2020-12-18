## Aparc+aseg dividr

# overview
This program divides each area from the aparc+aseg atlas into 27 new equally sized regions. The purpose of the program is to provide a more finegrained parcelation of cortical and subcortical areas that are specific to each individual brain. The new atlas can then be integrated into the analysis pipeline and may be used to extract more precise anatomical or functional information from each area. 

![hippo](https://github.com/iamnielsjanssen/aparcDividr/blob/master/aparc_dividr_loop.gif)

# usage
requires:
* Linux
* R
* Freesurfer installed in /usr/local/freesurfer

To run the program type
./aparc_dividr.R <aparc+aseg.nii.gz file>

This will output a new aparc+aseg_dividr.nii.gz file as well as a aparc+aseg_labels.txt that lists each label number with its corresponding aparc+aseg label name.

# details
