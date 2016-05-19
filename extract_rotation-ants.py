#!/usr/bin/env python

import sys
import numpy as np

if __name__ == '__main__':
    txtAffineTransform = sys.argv[1]
    txtRotatedDirs = sys.argv[2]

    # load text transform file
    tra = np.loadtxt(txtAffineTransform)
    gDirs = np.loadtxt(txtRotatedDirs)

    print( "Input Affine Transformation:")
    print( tra )
    print( "Input Gradient Direction:")
    print(gDirs)

    #removes the translation
    aff = np.matrix(tra[0:3,0:3])

    # computes the finite strain of aff to get the rotation
    rot = aff*aff.T

    # Compute the square root of rot
    [el, ev] = np.linalg.eig(rot)
    eL = np.identity(3)*np.sqrt(el)
    sq = ev*eL*ev.I

    # finally the rotation is defined as
    rot = sq.I*aff

    #newdir = np.dot(rot,gDirs[:])
    newdir = np.dot(rot,gDirs)

    print( "Extracted Rotation:")
    print( rot )
    print( "Corrected Gradient Direction:")
    print( newdir )
