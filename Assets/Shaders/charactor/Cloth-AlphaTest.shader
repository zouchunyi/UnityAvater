Shader "Otome/Charactor/Cloth-AlphaTest" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_MainTexAphle ("Base (A)", 2D) = "white" {}
	_Cutoff( "Cutoff", Range (0,1)) = 0.5
	_LineSize ("Outline" ,float)=0
	_LineColor ("Color", Color)=(1,1,1,1)
	_RimColor ("Rim Color", Color) = (1,1,1,1)
	_RimMin ("Rim min", Range(0,1)) = 0.8
	_RimMax ("Rim max", Range(0,1)) = 1 
}
SubShader {
	usepass "Otome/Charactor/Outline/OTOMEOUTLINE"
	Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="Transparent" }//"Queue"="Transparent"
	LOD 200
	Fog {Mode Off}
	cull off
	
	CGPROGRAM
	#pragma surface surf Lambert noforwardadd
	#pragma multi_compile RIM_OFF RIM_ON
	

	
	sampler2D _MainTex;
	sampler2D _MainTexAphle;
	fixed4 _Color;
	fixed _Cutoff;
	fixed4 _RimColor;
	float _RimMin;
	float _RimMax;
	
	struct Input 
	{
		float3 viewDir;
		float2 uv_MainTex;
	};
	
	
	void surf (Input IN, inout SurfaceOutput o) 
	{
		fixed4 a = tex2D(_MainTexAphle, IN.uv_MainTex);
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
		
		#ifdef RIM_ON
		half d =  dot(normalize(IN.viewDir), o.Normal);
		fixed rim = (1.0f - saturate(d))*step(0,d);
		rim = smoothstep(_RimMin, _RimMax, rim);
		o.Emission = lerp(c.rgb, _RimColor, rim);
		#else
		o.Emission = c.rgb;
		#endif
		clip ( a.r - _Cutoff );
	}
	ENDCG
}

Fallback "VertexLit"
}
