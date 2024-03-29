## Aparc+aseg dividr

# overview
The aparc+aseg atlas is a probabilistic computational atlas produced by the program [Freesurfer](https://surfer.nmr.mgh.harvard.edu/). A powerful feature of this atlas is that it identifies brain regions taking into account the specific anatomical idiosyncracies of an individual's brain. However, a limitation of the atlas is that its indexed brain regions cover relatively large sections of the brain. The purpose of the program is to compute a more finegrained parcelation of cortical and subcortical areas taking the aparc+aseg atlas as its starting point. This program divides each of the 87 gray matter regions from the aparc+aseg atlas into 27 new equally sized sections, leading to a new atlas that contains a theoretical maximum total number of 2349 brain regions. The new atlas may be integrated into downstream analyses and may lead to more precise localization of anatomical or functional brain measures.

![hippo](https://github.com/iamnielsjanssen/aparcDividr/blob/master/aparc_dividr_loop.gif)

# usage
Requires:
* Linux (tested with Ubuntu 18.04)
* R (tested with v3.6.3)
* Freesurfer installed in /usr/local/freesurfer (the program reads the FreeSurferColorLut.txt file)

To run the program type
./aparc_dividr.R <aparc+aseg.nii.gz file>

This will output a new aparc+aseg_dividr.nii.gz file, as well as a aparc+aseg_labels.txt that lists each label number with its corresponding aparc+aseg label name.

# details
The program first fits a boundary box to each area in the aparc+aseg atlas file. This boundary box is then divided into equally spaced 27 regions using the following scheme:

![hippo](https://github.com/iamnielsjanssen/aparcDividr/blob/master/detail_labels.png)

These labels are increased by 27 for each additional region. For example, for the first area (Left-Cerebellum-Cortex, 8), labels run from 1 to 27. Then for the next structure (Left-Thalamus-Proper, 10), labels run from 28 to 54. And so on for all 87 areas in the atlas. This results in a new aparc+aseg_dividr atlas file where each section has a unique label. Importantly, note that depending on the specific shape of the structure, not all labels may actually be present (thereby reducing the total number of regions present in the new atlas). For example, if a structure has a pyramidal shape, labels in the superior section of the boundary box may not coincide with the shape and may not be present in the final atlas. 

# application example
The resulting file could be used in a FSL processing pipeline using the following code:

`fslmeants -i <file_with_FC_values> -o <FC_values>.txt --label=aparc+aseg_dividr.nii.gz --transpose`

In the resulting file FC_values.txt, the row number would indicate the average value for each label in the aparc+aseg_dividr file. 

# comments
Please send any comments and suggestions to my email address.
