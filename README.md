## Aparc+aseg dividr

# overview
The aparc+aseg atlas is a probabilistic computational atlas produced by the program [Freesurfer](https://surfer.nmr.mgh.harvard.edu/). A powerful feature of this atlas is that it identifies brain regions taking into account the specific anatomical idiosyncracies of an individual's brain. However, a limitation of the atlas is that its indexed brain regions cover relatively large sections of the brain. The purpose of the program is to compute a more finegrained parcelation of cortical and subcortical areas taking the aparc+aseg atlas as its starting point. This program divides each of the 87 gray matter regions from the aparc+aseg atlas into 27 new equally sized sections, leading to a new atlas that contains a total number of 2349 brain regions. The new atlas may be integrated into downstream analyses and may lead to more precise localization of anatomical or functional brain measures.

![hippo](https://github.com/iamnielsjanssen/aparcDividr/blob/master/aparc_dividr_loop.gif)

# usage
requires:
* Linux
* R
* Freesurfer installed in /usr/local/freesurfer (the program reads the FreeSurferColorLut.txt file)

To run the program type
./aparc_dividr.R <aparc+aseg.nii.gz file>

This will output a new aparc+aseg_dividr.nii.gz file as well as a aparc+aseg_labels.txt that lists each label number with its corresponding aparc+aseg label name.

# details
