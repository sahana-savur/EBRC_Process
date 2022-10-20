from PIL import Image
import pytesseract
import numpy as np
filename = r'C:\Users\Sandeep Bhat\Downloads\cap.png'
img1 = np.array(Image.open(filename))
text = pytesseract.image_to_string(img1)
print(text)