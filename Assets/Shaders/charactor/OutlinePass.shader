Shader "Otome/Charactor/Outline" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_MainTexAphle ("Base (A)", 2D) = "white" {}
	_Cutoff( "Cutoff", Range (0,1)) = 0.5
	_LineSize ("Outline" ,float)=0.0002
	_LineColor ("Color", Color)=(1,1,1,1)

	////////////////////////////////////////////////
	//usage : 
	//usepass "Otome/Charactor/Outline/OTOMEOUTLINE"

}

SubShader {

	
	Pass{
			Name "OTOMEOUTLINE"
			//Tags{"LightMode"="Always"}
			Cull front
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma multi_compile OUTLINE_OFF OUTLINE_ON
	
			#include "UnityCG.cginc"
			float _LineSize;
			float4 _LineColor;
			fixed _Cutoff;
			sampler2D _MainTexAphle;
			float4 _MainTexAphle_ST;
			uniform int _OUTLINE_ENABLE;
			uniform float _OUTLINE_FOV_SCALE;

			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				
				//#ifdef OUTLINE_ON
				half flag = sign(_LineSize*_OUTLINE_ENABLE);		
				//#else
				//half flag = 0;
				//#endif
				
				o.pos = mul(UNITY_MATRIX_MV, v.vertex)*flag; 
				float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				norm.z = -0.5;
				o.pos = o.pos + float4(normalize(norm),0)*_OUTLINE_FOV_SCALE*_LineSize*_OUTLINE_ENABLE;
				o.pos = mul(UNITY_MATRIX_P,o.pos)*flag;
				
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex); 
				//float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				//float2 offset = TransformViewToProjection(norm.xy);
				//o.pos.xy += offset * _LineSize*_OUTLINE_ENABLE*_OUTLINE_FOV_SCALE;
				
				o.color = _LineColor;
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTexAphle);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = tex2D(_MainTexAphle, i.uv);
				clip(c.r - _Cutoff);
				//return i.color*c;
				return i.color;
			}
			ENDCG
		}
		
		Pass{
			Name "OTOMEOUTLINEMASK"
			//Tags{"LightMode"="Always"}
			Cull front
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma multi_compile OUTLINE_OFF OUTLINE_ON
			#include "UnityCG.cginc"
			float _LineSize;
			float4 _LineColor;
			fixed _Cutoff;
			sampler2D _MainTexMask;
			float4 _MainTexMask_ST;
			uniform int _OUTLINE_ENABLE;
			uniform float _OUTLINE_FOV_SCALE;

			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				//#ifdef OUTLINE_ON
				half flag = sign(_LineSize*_OUTLINE_ENABLE);		
				//#else
				//half flag = 0;
				//#endif		
				o.pos = mul(UNITY_MATRIX_MV, v.vertex)*flag; 
				float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				norm.z = -0.5;
				o.pos = o.pos + float4(normalize(norm),0)*_OUTLINE_FOV_SCALE*_LineSize*_OUTLINE_ENABLE;
				o.pos = mul(UNITY_MATRIX_P,o.pos)*flag;
				
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex); 
				//float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				//float2 offset = TransformViewToProjection(norm.xy);
				//o.pos.xy += offset * _LineSize*_OUTLINE_ENABLE*_OUTLINE_FOV_SCALE;
				o.color = _LineColor;
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTexMask);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = tex2D(_MainTexMask, i.uv);
				clip(c.r - _Cutoff);
				return i.color*c;
			}
			ENDCG
		}

			Pass{
			Name "OTOMEOUTLINENOALPHA"
			//Tags{"LightMode"="Always"}
			Cull front
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma multi_compile OUTLINE_OFF OUTLINE_ON
			#include "UnityCG.cginc"
			float _LineSize;
			float4 _LineColor;
			fixed _Cutoff;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			uniform int _OUTLINE_ENABLE;
			uniform float _OUTLINE_FOV_SCALE;

			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				//#ifdef OUTLINE_ON
				half flag = sign(_LineSize*_OUTLINE_ENABLE);		
				//#else
				//half flag = 0;
				//#endif		
				o.pos = mul(UNITY_MATRIX_MV, v.vertex)*flag; 
				float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				norm.z = -0.5;
				o.pos = o.pos + float4(normalize(norm),0)*_OUTLINE_FOV_SCALE*_LineSize*_OUTLINE_ENABLE;
				o.pos = mul(UNITY_MATRIX_P,o.pos)*flag;
				
				//o.pos = mul(UNITY_MATRIX_MVP, v.vertex); 
				//float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				//float2 offset = TransformViewToProjection(norm.xy);
				//o.pos.xy += offset * _LineSize*_OUTLINE_ENABLE*_OUTLINE_FOV_SCALE;
				o.color = _LineColor;
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = tex2D(_MainTex, i.uv);
				clip(c.r - _Cutoff);
				//return i.color*c;
				return i.color;
			}
			ENDCG
		}
}
}
