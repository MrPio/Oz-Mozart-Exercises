from time import sleep
import pyautogui
import numpy as np
import cv2
from playsound import playsound

# === CONFIG ===
TARGET_COLOR = "#5fffb5"  # Hex color to detect
COLOR_TOLERANCE = 20  # Max per-channel diff (0-255)
MIN_CLUSTER_SIZE = 25  # Minimum number of pixels in a cluster
DELAY=2 # sec

wav_found ="wav/beep_in_01.wav"
wav_not_found = "wav/beep_out_01.wav"


# Convert hex to BGR
def hex_to_bgr(hex_color):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i : i + 2], 16) for i in (4, 2, 0))  # R,G,B → B,G,R


def find_clusters(image, target_bgr, tolerance):
    target_array = np.full_like(image, target_bgr)
    diff = cv2.absdiff(image, target_array)
    mask = np.all(diff <= tolerance, axis=2).astype(np.uint8) * 255

    num_labels, labels, stats, centroids = cv2.connectedComponentsWithStats(mask, connectivity=8)

    # Filter small clusters
    clusters = [
        (area, tuple(map(int, centroids[i])))
        for i, area in enumerate(stats[1:, cv2.CC_STAT_AREA], start=1)
        if area >= MIN_CLUSTER_SIZE
    ]
    return clusters

def main():
    time=0
    i=0
    a=993
    scoid=3335
    
    i+=1
    time=0

    while True:
        sleep(DELAY)
        time+=DELAY
        
        screenshot = pyautogui.screenshot()
        img = cv2.cvtColor(np.array(screenshot), cv2.COLOR_RGB2BGR)
        clusters = find_clusters(img, hex_to_bgr(TARGET_COLOR), COLOR_TOLERANCE)

        if clusters:
            playsound(wav_found)
            smallest = max(clusters, key=lambda x: x[0])
            _, (x, y) = smallest
            pyautogui.click(x, y)

        if time>8*60:
            time=0
            pyautogui.hotkey('ctrl','t')
            sleep(0.5)
            pyautogui.write(f"https://learn.univpm.it/mod/scorm/player.php?a={a+i}&currentorg=prac&scoid={scoid+i*2}")
            sleep(0.5)
            pyautogui.hotkey('enter')
            sleep(0.5)
            i+=1
            

if __name__ == "__main__":
    main()
