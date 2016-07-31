using UnityEngine;
using System.Collections;

public class Test : MonoBehaviour {

    private UCombineSkinnedMgr skinnedMgr = new UCombineSkinnedMgr();

    // Use this for initialization
    void Start () {

		SkinnedMeshRenderer[] meshes = this.GetComponentsInChildren<SkinnedMeshRenderer> ();
		skinnedMgr.CombineObject(this.gameObject, meshes, false);
		for (int i = 0; i < meshes.Length; i++) {

			GameObject.Destroy (meshes [i]);
		}
    }
	
	// Update is called once per frame
	void Update () {
	
	}
}
