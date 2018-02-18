using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PenguinScript : MonoBehaviour {

	private GameObject beer;
	private GameObject penguinHead;
	private GameObject spine;
	private Quaternion initialHeadRotation;

	// Use this for initialization
	void Start () {
		beer = GameObject.Find ("Beer");
		penguinHead = GameObject.Find ("head");
		spine = GameObject.Find ("spine");
		initialHeadRotation = penguinHead.transform.rotation;
	}
	
	// Update is called once per frame
	void Update () {
		Quaternion headRotation = Quaternion.LookRotation((beer.transform.position - penguinHead.transform.position).normalized, spine.transform.up);
		penguinHead.transform.rotation = headRotation * initialHeadRotation;
	}
}
