/*

    It is a Unity project that display how to build the avatar equipment system in Unity.
    Equipment system is very important in the Game, specially in MMO Game.

    Normally, equipment system contains tow important parts. 
    Since the appearance of equipments are different(the mesh are different), so to merge these meshes together is necessary. 
    Second, after merge meshes, the new mesh contains many materials(in this project, it has 4 material), that means it has at least 4 drawcalls(depends in the shader).
    So to merge materials together will reduce drawcalls and improve game performance.

    Auther: ZouChunyi
    E-mail: zmafly@163.com

*/

using UnityEngine;
using System.Collections;

/// <summary>
/// A simple framework of the game.
/// </summary>
public class App
{
	private static App app = new App();

	public static App Game { get { return app; } }

	private UCharacterMgr characterMgr = new UCharacterMgr ();
	public UCharacterMgr CharacterMgr { get { return characterMgr; } }

	public void Update ()
	{
		characterMgr.Update ();
	}
}

public class Main : MonoBehaviour {

	private readonly string[] index = new string[]{ "004", "006", "008" };
    /// <summary>
    /// Config default equipment informations.
    /// </summary>
	private const int DEFAULT_WEAPON = 0;
	private const int DEFAULT_HEAD = 2;
	private const int DEFAULT_CHEST = 0;
	private const int DEFAULT_HAND = 0;
	private const int DEFAULT_FEET = 1;
	private const bool DEFAULT_COMBINEMATERIAL = true;
	
    /// <summary>
    /// Use this for GUI display.
    /// </summary>
	private bool combine = DEFAULT_COMBINEMATERIAL;
	private bool[] weapon_list = new bool[3];
	private bool[] head_list = new bool[3];
	private bool[] chest_list = new bool[3];
	private bool[] hand_list = new bool[3];
	private bool[] feet_list = new bool[3];
    
    /// <summary>
    /// The avatar in the scene.
    /// </summary>
	private UCharacterController character = null;

	// Use this for initialization
	void Start () {

        // for GUI display
		weapon_list [DEFAULT_WEAPON] = true;
		head_list [DEFAULT_HEAD] = true;
		chest_list [DEFAULT_CHEST] = true;
		hand_list [DEFAULT_HAND] = true;
		feet_list [DEFAULT_FEET] = true;

        // create an avatar
		character = App.Game.CharacterMgr.Generatecharacter (
			"ch_pc_hou", 
			"ch_we_one_hou_" + index[DEFAULT_WEAPON],
			"ch_pc_hou_" + index[DEFAULT_HEAD] + "_tou", 
			"ch_pc_hou_" + index[DEFAULT_CHEST] + "_shen", 
			"ch_pc_hou_" + index[DEFAULT_HAND] + "_shou", 
			"ch_pc_hou_" + index[DEFAULT_FEET] + "_jiao",
			combine);
		character.Instance.transform.position = new Vector3 (0, -1, -5);
		character.Instance.transform.eulerAngles = new Vector3 (0, 180, 0);
	}
	
	// Update is called once per frame
	void Update () {
	
		App.Game.Update();
	}

	void OnGUI () {

		GUI.Button (new Rect (0, 0, 100, 30),   "Euipments 1");
		GUI.Button (new Rect (100, 0, 100, 30), "Euipments 2");
		GUI.Button (new Rect (200, 0, 100, 30), "Euipments 3");

		for (int i = 0; i < weapon_list.Length; i++) {
			
			if (GUI.Button (new Rect (i * 100, 30, 100, 50), "Weapon" + (weapon_list[i] ? "(√)" : ""))) {
				
				if (!weapon_list [i]) {
					for (int j = 0; j < weapon_list.Length; j++) {
						weapon_list [j] = false;
					}
					weapon_list [i] = true;
					
					character.ChangeWeapon ("ch_we_one_hou_" + index[i]);
				}
			}
		}

		for (int i = 0; i < head_list.Length; i++) {

			if (GUI.Button (new Rect (i * 100, 80, 100, 50), "Head" + (head_list[i] ? "(√)" : ""))) {

				if (!head_list [i]) {
					for (int j = 0; j < head_list.Length; j++) {
						head_list [j] = false;
					}
					head_list [i] = true;

					character.ChangeHeadEquipment ("ch_pc_hou_" + index[i] + "_tou", combine);
				}
			}
		}

		for (int i = 0; i < chest_list.Length; i++) {

			if (GUI.Button (new Rect (i * 100, 130, 100, 50), "Chest" + (chest_list[i] ? "(√)" : ""))) {

				if (!chest_list [i]) {
					for (int j = 0; j < chest_list.Length; j++) {
						chest_list [j] = false;
					}
					chest_list [i] = true;

					character.ChangeChestEquipment ("ch_pc_hou_" + index[i] + "_shen", combine);
				}
			}
		}

		for (int i = 0; i < hand_list.Length; i++) {

			if (GUI.Button (new Rect (i * 100, 180, 100, 50), "Hand" + (hand_list[i] ? "(√)" : ""))) {

				if (!hand_list [i]) {
					for (int j = 0; j < hand_list.Length; j++) {
						hand_list [j] = false;
					}
					hand_list [i] = true;

					character.ChangeHandEquipment("ch_pc_hou_" + index[i] + "_shou", combine);
				}
			}
		}

		for (int i = 0; i < feet_list.Length; i++) {

			if (GUI.Button (new Rect (i * 100, 230, 100, 50), "Feet" + (feet_list[i] ? "(√)" : ""))) {

				if (!feet_list [i]) {
					for (int j = 0; j < feet_list.Length; j++) {
						feet_list [j] = false;
					}
					feet_list [i] = true;

					character.ChangeFeetEquipment("ch_pc_hou_" + index[i] + "_jiao", combine);
				}
			}
		}

		if (GUI.Button(new Rect(Screen.width - 100,0,100,50),character.animationState == 0 ? "Attack" : "Stand"))
		{
			if (character.animationState == 0)
			{
				character.PlayAttack();
			}else
			{
				character.PlayStand();
			}
		}

		if (GUI.Button(new Rect(Screen.width - 100,50,100,50),character.rotate ? "Static" : "Rotate"))
		{
			if (character.rotate)
			{
				character.rotate = false;
			}else
			{
				character.rotate = true;
			}
		}

        if (GUI.Button(new Rect(Screen.width - 150, 100, 150, 50), combine ? "Merge materials(√)" : "Merge materials"))
        {
            combine = !combine;
        }
    }

}
