# LinearUnmixing
MATLAB codes to linearly unmix 4d images (xyz and colour)

## Requirements
mnl_Load4Dimage - available here, https://github.com/mleiwe/QDyeFinder/tree/main/Subcodes
Bioformats toolbox - 

## Functions
There are three versions of the same program

sf_unmixing_20xG_3HyD_220823ref.m - Unmixing the data obtained by Leica SP8 with 20X multi-immersion objectives, Glycerine immersion and 3 HyD detectors.

sf_unmixing_20xG_220821ref.m - Unmixing the data obtained by Leica SP8 with 20X multi-immersion objectives, Glycerine immersion and a single HyD detector. 

sf_unmixing_63x_220823ref.m - Unmixing the data obtained by Leica SP8 with 63X oil-immersion objectives, oil immersion and a single HyD detector. 

The structure of these codes is the same, but the parameters (ref405, ref488 and ref552) used as the references are different for each imaging condition.

## How to run these codes
Type sf_unmixing_20xG_3HyD_220823ref("filename") in the command window
  
