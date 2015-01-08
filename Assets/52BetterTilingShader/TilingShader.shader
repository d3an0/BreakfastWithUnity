Shader "TilingShader" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_UVMultiplier ("Second Layer UV Scale", Range(-1,-16)) = -7
		_Desaturate ("Second Layer Desaturation Percentage", Range(0,1)) = 0.25
		_Brightness ("Brightness Adjustment", Range(1,4)) = 2
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		float _UVMultiplier;
		float _Brightness;
		float _Desaturate;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c1 = tex2D (_MainTex, IN.uv_MainTex);
			half4 c2 = tex2D (_MainTex, IN.uv_MainTex/_UVMultiplier);
			c1 *= _Brightness;
			c2 *= _Brightness;
			
			o.Albedo = lerp(c2.rgb,Luminance(c2.rgb),_Desaturate) * c1;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
