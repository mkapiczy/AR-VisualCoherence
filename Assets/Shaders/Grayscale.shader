
 Shader "Custom/GreyScale" {
	Properties {
		_MainTex ("Texture", 2D) = "white" { } 
		_NoiseTex ("Texture", 2D) = "white" { } 
        _SpeedX("Speed along X", Range(0, 1000)) = 1
        _SpeedY("Speed along Y", Range(0, 1000)) = 1
	}
	SubShader {
		Pass {
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			// main texture for the noise
			sampler2D _MainTex;
            sampler2D _NoiseTex;
            float _SpeedX;
            float _SpeedY;

			struct v2f {
				float4  pos : SV_POSITION; // Vertex position
				float2  uv : TEXCOORD0; // The first uv coordinate
			};

            float random(half2 uv)
            {
				// Pseudorandom noise
                return frac(sin(dot(uv, float2(45.5432, 78.233))) * 43758.5453);
            }

			float4 _MainTex_ST;
      		v2f vert (appdata_base v) {
        		v2f o;
				// Convert to camera position
        		o.pos = UnityObjectToClipPos (v.vertex);
        		o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
				return o;
      		}

			half4 frag (v2f i) : COLOR {
				half2 uv = i.uv;
                half noiseVal = tex2D(_NoiseTex, uv).r;
                half4 texcol = tex2D(_MainTex, uv);
                fixed4 noise =  (noiseVal + random(i.uv)); 

        		texcol.rgb = dot(dot(texcol.rgb, noise.rgb), float3(0.3, 0.59, 0.11));

                return texcol;
      		}

			ENDCG  
		}
	}
	Fallback "VertexLit"
} 


