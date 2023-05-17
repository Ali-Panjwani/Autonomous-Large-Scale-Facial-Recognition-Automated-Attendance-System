import collections as c
import os
import cv2
from sklearn.decomposition import PCA
from sklearn.model_selection import cross_val_score


def getAllStudentsImage(filepath, AllStudentsList):
    images = []
    facelabel = []

    for i in AllStudentsList:
        for j in os.listdir(filepath + "\\" + i):
            img = cv2.imread(os.path.join(filepath, i, j), cv2.IMREAD_GRAYSCALE)
            img = cv2.resize(img, (128, 128))
            images.append(img)
            facelabel.append(i)

    return images, facelabel


def showDetectedFaces(faces, test_img):
    # Draw bounding boxes around the detected faces and show the image
    for (x, y, w, h) in faces:
        cv2.rectangle(test_img, (x, y), (x + w, y + h), (0, 255, 0), 2)

    cv2.imshow('Test Image', test_img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


def getOptimalComponentsCount(facematrix):
    # Perform PCA on facematrix
    pca = PCA().fit(facematrix)
    var_ratios = pca.explained_variance_ratio_

    # Find optimal number of components
    total_var = sum(var_ratios)
    var_exp = 0
    threshold = None
    for i, r in enumerate(var_ratios):
        var_exp += r
        if var_exp / total_var >= 0.95:
            threshold = i + 1
            break

    # If threshold not found, default to using 95% of variance
    if threshold is None:
        threshold = 0.95 * len(var_ratios)

    return int(threshold)


def getOptimalN(knn, facematrix_reduced, facelabels):
    k_scores = []
    for n in range(1, 21):
        knn.n_neighbors = n
        scores = cross_val_score(knn, facematrix_reduced, facelabels, cv=min(c.Counter(facelabels).values()))
        k_scores.append(scores.mean())

    return (k_scores.index(max(k_scores)) + 1)
