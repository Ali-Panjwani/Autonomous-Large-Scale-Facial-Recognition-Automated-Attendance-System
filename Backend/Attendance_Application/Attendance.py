import cv2
import numpy as np
import time
from sklearn.decomposition import PCA
from sklearn.feature_selection import VarianceThreshold
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import cross_val_score
import AttendanceFunctions as AttFunc

start = time.time()

AllStudentsList = ['K190365', 'K191289', 'K191251', 'K191251', 'Mubashir', 'Shakoor', 'Shubair', 'Haris']

filepath = 'C:\\Users\\ALI\\Desktop\\fyp_dataset\\data'

images, facelabels = AttFunc.getAllStudentsImage(filepath, AllStudentsList)

facematrix = np.array([img.flatten() for img in images])

knn = KNeighborsClassifier()

# Load the test image
test_img = cv2.imread("C:\\Users\\ALI\\Desktop\\fyp_dataset\\test1.jpg", cv2.IMREAD_GRAYSCALE)

# Detect all faces in the test image
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
faces = face_cascade.detectMultiScale(test_img, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

predictions = np.array(list([]))

reality = 0

for i in range(3):

    # Transform face-matrix to new reduced feature space
    pca = PCA(n_components=AttFunc.getOptimalComponentsCount(facematrix))

    if i == 1:
        pca = PCA(n_components=int(AttFunc.getOptimalComponentsCount(facematrix) - (len(facelabels) * 0.1)))

    if i == 2:
        pca = PCA(n_components=int(AttFunc.getOptimalComponentsCount(facematrix)))

    if i == 3:
        pca = PCA(n_components=int(AttFunc.getOptiomalComponentsCount(facematrix) + (len(facelabels) * 0.1)))

    facematrix_reduced = pca.fit_transform(facematrix)

    # Define KNN Classifier and perform cross-validation to find optimal n_neighbors
    optimal_n = AttFunc.getOptimalN(knn, facematrix_reduced, facelabels)

    # Train KNN Classifier with optimal n_neighbors and reduced feature space
    knn.n_neighbors = optimal_n
    knn.fit(facematrix_reduced, facelabels)

    # Resize and flatten each detected face and apply PCA
    test_face_vectors = []
    for (x, y, w, h) in faces:
        face = cv2.resize(test_img[y:y + h, x:x + w], (128, 128))
        face_vector = face.flatten()
        face_vector_reduced = pca.transform([face_vector])
        test_face_vectors.append(face_vector_reduced[0])

        if reality == 1:
            label = knn.predict(face_vector_reduced)[0]

            # Draw a rectangle around the detected face and show the predicted label
            cv2.rectangle(test_img, (x, y), (x + w, y + h), (0, 255, 0), 2)
            cv2.putText(test_img, str(label), (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

    if reality == 1:
        # Show the test image with bounding boxes around the detected faces
        cv2.imshow('Test Image', test_img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

    print(knn.predict(test_face_vectors))
    predictions = np.concatenate((predictions, knn.predict(test_face_vectors)))

print(predictions)
# Count the number of unique labels in the predictions
predictions = np.array(list(set(predictions)))
print(predictions)

end = time.time()

print(end - start)
