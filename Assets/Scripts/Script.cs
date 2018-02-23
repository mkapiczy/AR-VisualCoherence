using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Vuforia;
using OpenCVForUnity;

public class Script : MonoBehaviour {

	Mat cameraImageMat;
	Mat cameraImageMatBlur = new Mat();

	void Start () {

	}

	// Update is called once per frame
	void Update () {
		MatDisplay.SetCameraFoV (41.5f);
		Image cameraImage = CameraDevice.Instance.GetCameraImage (Image.PIXEL_FORMAT.RGBA8888);
		if (cameraImage != null) {
			if (cameraImageMat == null) {
				cameraImageMat = new Mat (cameraImage.Height, cameraImage.Width, CvType.CV_8UC4);
			}

			cameraImageMat.put (0, 0, cameraImage.Pixels);

			MatDisplay.DisplayMat (cameraImageMat, MatDisplaySettings.FULL_BACKGROUND);
//			Imgproc.blur(cameraImageMat, cameraImageMatBlur, new Size (16,16));
//			MatDisplay.DisplayMat (cameraImageMatBlur, MatDisplaySettings.BOTTOM_LEFT	);
		}

	}

}
