## Aparc+aseg dividr

# overview
This program divides each of the 87 gray matter regions from the aparc+aseg atlas into 27 new equally sized sections, producing a total number of 2349 sections. The purpose of the program is to provide a more finegrained parcelation of cortical and subcortical areas provided by the aparc+aseg atlas that are specific to each individual brain. The new atlas can then be integrated into the downstream analysis pipeline and may lead to more precise localization of anatomical or functional brain measures.

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
