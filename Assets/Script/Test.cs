using UnityEngine;
using System.Collections;

public class Test : MonoBehaviour {

    private UCombineSkinnedMgr skinnedMgr = new UCombineSkinnedMgr();

    // Use this for initialization
    void Start () {
        skinnedMgr.CombineObject(this.gameObject, this.GetComponentsInChildren<SkinnedMeshRenderer>(), false);
    }
	
	// Update is called once per frame
	void Update () {
	
	}
}
