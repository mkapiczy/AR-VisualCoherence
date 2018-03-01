Shader "Custom/AdaptiveThreshold" {
Properties{
		_MainTex ("Texture", 2D) = "white" { } 
       _NoiseTex ("Texture", 2D) = "white" { } 
        _SpeedX("Speed along X", Range(0, 100)) = 1
        _SpeedY("Speed along Y", Range(0, 100)) = 1 
    }

    SubShader {
    	Pass {
    	CGPROGRAM
    		#pragma vertex vertexShader
    		#pragma fragment fragmentShader

    		#include "UnityCG.cginc"

    		struct appData {
    			float3 position: POSITION;
    			float3 normal : NORMAL;
    		};

    		struct vertexToFragment {
    			float4 position: SV_POSITION;
    			float3 normal : NORMAL;
    			float3 worldPosition : TEXCOORD0;
    		};

    		vertexToFragment vertexShader(appData IN) {
    			vertexToFragment OUT;
    			OUT.position = UnityObjectToClipPos(IN.position);
    			OUT.normal = UnityObjectToWorldNormal(IN.normal);
    			OUT.worldPosition = mul(UNITY_MATRIX_M, IN.position); // from object coordinates to world coordinates
    			return OUT;
    		}

    		sampler2D _MainTex;
    		sampler2D _NoiseTex;
            float _SpeedX;
            float _SpeedY;

             float random(half2 uv)
            {
				// Pseudorandom noise
                return frac(sin(dot(uv, float2(45.5432, 78.233))) * 43758.5453);
            }

    		half4 fragmentShader(vertexToFragment IN) : SV_TARGET {
    			half2 uv = IN.worldPosition;

    			float3 cameraPos = _WorldSpaceCameraPos;
    			float3 direction = normalize(cameraPos - IN.worldPosition);
    			float dotProduct = dot(direction, IN.normal);
    			float result;
    			if(dotProduct < 0.4) result = 0;
    			else result = 1;

			
    			half noiseVal = tex2D(_NoiseTex, uv).r;

    			// offset
                uv.x = uv.x + noiseVal /_SpeedX + random(uv)/_SpeedX;
                uv.y = uv.y + noiseVal / _SpeedY + random(uv)/_SpeedY; 
 
        		half4 texcol = tex2D(_MainTex, uv);
    			texcol.rgb = dot(texcol.rgb, float3(result, result, result));

                return texcol;
    		}

		ENDCG
    	}
	}
} 


