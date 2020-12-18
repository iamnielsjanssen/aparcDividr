## Aparc+aseg dividr

# overview
The aparc+aseg atlas is a probabilistic computational atlas produced by the program [Freesurfer](https://surfer.nmr.mgh.harvard.edu/). A powerful feature of this atlas is that it identifies brain regions taking into account the specific idiosyncracies of an individual's brain. However, a limitation of the atlas in the relative gross parcelation into brain regions that cover relatively large sections of the brain. The purpose of the program is to compute a more finegrained parcelation of cortical and subcortical areas taking the aparc+aseg atlas as the starting point. This program divides each of the 87 gray matter regions from the aparc+aseg atlas into 27 new equally sized sections, producing a total number of 2349 sections. The new atlas can then be integrated into the downstream analysis pipeline and may lead to more precise localization of anatomical or functional brain measures.

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
