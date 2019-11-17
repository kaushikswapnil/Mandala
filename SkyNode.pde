class SkyNode extends Shape
{
  int GeneralTime_Dawn = 0;
  int GeneralTime_Morning = 1;
  int GeneralTime_Noon = 2;
  int GeneralTime_Evening = 3;
  int GeneralTime_Dusk = 4;
  int GeneralTime_EarlyNight = 5;
  int GeneralTime_MidNight = 6;
  int GeneralTime_LateNight = 7;
  int GeneralTime_Count = 8;
  
  class Layer
  {
     float m_InnerRadius, m_OuterRadius;
     
     Layer(float innerR, float outerR)
     {
        m_InnerRadius = innerR;
        m_OuterRadius = outerR;
     }
     
     void Display(float time)
     {
       float diameter = m_OuterRadius *2;
       
       noStroke();

       //PVector skyCol = GetColorFor(GetGeneralTime(time), GetStrengthOfGeneralTime(time));
       //fill(skyCol.x, skyCol.y, skyCol.z);
       
       fill(GetColorFor(GetGeneralTime(time), GetStrengthOfGeneralTime(time)));
       
       ellipse(0, 0, diameter, diameter);
     }
     
     void Update()
     {
       
     }
     
     int GetGeneralTime(float time)
     {
      int retVal;
      
      float increment = 1.0/GeneralTime_Count;
      
      if (time < increment)
      {
       retVal = 0; //Dawn 
      }
      else if (time < 2*increment)
      {
       retVal = 1; //Morning 
      }
      else if (time < 3*increment)
      {
       retVal = 2; //Noon 
      }
      else if (time < 4*increment)
      {
       retVal = 3; //Evening 
      }
      else if (time < 5*increment)
      {
       retVal = 4; //Dusk 
      }
      else if (time < 6*increment)
      {
       retVal = 5; //EarlyNight 
      }
      else if (time < 7*increment)
      {
       retVal = 6; //MidNight 
      }
      else
      {
       retVal = 7; //LateNight 
      }
      
      return retVal;
     }
     
     float GetStrengthOfGeneralTime(float time)
     {
       float gradientRange = 1.0f/GeneralTime_Count;
       float relStrength = map(time % gradientRange, 0, gradientRange, 0.0f, 1.0f);
       return relStrength; //<>//
     }

     int GetColorFor(int generalTime, float relStrength)
     {
       float hA = 0.0f, hB = 0.0f;
       float sA = 1.0f, sB = 1.0f;
       float bA = 1.0f, bB = 1.0f;
       
       switch(generalTime)
       {
        case 0: //Dawn
        if (relStrength < 0.5f)
        {
          hA = 300/360.0f;
          hB = 1.0f;
          sA = 0.33f;
          sB = 0.5f;
          bA = 0.8f;
          bB = 1.0f;
        }
        else
        {
          hA = 0.0f;
          hB = 57/360.0f;
          sA = 0.5f;
          sB = 1.0f;
        }
        break;
        
        case 1: //Morning
        hA = 57/360.0f;
        hB = 50/360.0f;
        sA = 0.7f;
        sB = 0.0f;
        break;
        
        case 2: //Noon
        hA = 180/360.0f;
        hB = 183/360.0f;
        sA = 0.0f;
        sB = 1.0f;
        break;
        
        case 3: //Evening
        hA = 183/360.0f;
        hB = 257/360.0f;
        break;
        
        case 4: //Dusk
        if (relStrength < 0.5f)
        {
          hA = 257/360.0f;
          hB = 347/360.0f;
        }
        else
        {
          hA = 347/360.0f;
          hB = 232/360.f;
          bA = 1.0f;
          bB = 0.3f;
        }
        break;
        
        case 5: //EarlyNight
        hA = 232/360.0f;
        hB = 251/360.0f;
        bA = 0.3f;
        bB = 0.1f;
        break;
        
        case 6: //MidNight
        if (relStrength < 0.5f)
        {
          hA = 251/360.0f;
          hB = hA;
          bA = 0.1f;
          bB = 0.0;
        }
        else
        {
          hA = 251/360.0f;
          hB = 240/360.0f;
          bA = 0.0f;
          bB = 0.1f;
        }
        break;
        
        case 7: //LateNight
        if (relStrength < 0.33f)
        {
          hA = 240/360.0f;
          hB = 240/360.0f;
          bA = 0.0f;
          bB = 0.05f;
        }
        else if (relStrength < 0.66f)
        {
          hA = 240/360.0f;
          hB = 253/360.0f;
          bA = 0.05f;
          bB = 0.4f;
        }
        else if (relStrength < 0.86f)
        {
          hA = 253/360.0f;
          hB = hA;
          bA = 0.4f;
          bB = 0.6f;
          sA = 1.0f;
          sB = 0.33f;
        }
        else
        {
          hA = 253/360.0f;
          hB = 300/360.0f;
          sA = 0.33f;
          sB = 0.7f;
          bA = 0.6f;
          bB = 0.8f;
        }
        break;
        
        default:
        break;
       }
       
       float h = lerp(hA, hB, relStrength);
       float s = lerp(sA, sB, relStrength);
       float b = lerp(bA, bB, relStrength);
       
       return HSBtoRGB(h, s, b);
     }
  }
  
  float m_InitialTime;
  int m_CycleLength, m_CycleStart, m_CycleEnd;
  float m_InnerR, m_OuterR;
  
  ArrayList<Layer> m_Layers;
  
  SkyNode(float innerR, float outerR, int cycleLength)
  {
   this(innerR, outerR, 0.0f, cycleLength); 
  }
  
  SkyNode(float innerR, float outerR, float startTime, int cycleLength)
  {
    super(outerR*2, outerR*2);
    
    m_Position = g_Center;
    
    m_InnerR = innerR;
    m_OuterR = outerR;
    
    m_InitialTime = startTime;
    m_CycleLength = cycleLength;
    
    m_CycleStart = m_CycleEnd = MAX_INT;
    
    GenerateLayers();
  }
  
  Shape Copy()
  {
   return new SkyNode(m_InnerR, m_OuterR, m_InitialTime, m_CycleLength); 
  }
  
  void Update()
  {
     super.Update();
     
     if (m_CycleStart == MAX_INT || frameCount > m_CycleEnd)
     {
       m_CycleStart = frameCount;
       m_CycleEnd = m_CycleStart + m_CycleLength;
     }
     
     for (Layer layer : m_Layers)
     {
      layer.Update(); 
     }
  }
  
  void Display()
  {
    pushMatrix();
    translate(m_Position.x, m_Position.y);
    rotate(m_Angle);
    
    float curTime = GetTime();
    float layerTime = curTime;
    float layerTimeIncrement = 1.0f/(GeneralTime_Count*m_Layers.size()/2);
    for (Layer layer : m_Layers)
    {
       layer.Display(layerTime); 
       layerTime = (layerTime+layerTimeIncrement)%1.0f;
    }
    
    popMatrix();
  }
  
  void GenerateLayers()
  {
    m_Layers = new ArrayList<Layer>();
    
    int numLayers = 10;
    
    float maxRadius = m_OuterR;
    float minRadius = m_InnerR;
    
    float radiusRange = maxRadius - minRadius;
    
    float radiusDecrement = radiusRange/numLayers;
    
    float lastInnerR = maxRadius;
    
    for (int iter = 0; iter < numLayers; ++iter)
    {
     float outerR = lastInnerR;
     float innerR = lastInnerR - radiusDecrement;
     lastInnerR = innerR;
     m_Layers.add(new Layer(innerR, outerR)); 
    }
  }
  
  float GetTime()
  {
    float time = (((float)(frameCount-m_CycleStart)/m_CycleLength) + m_InitialTime)%1.0f;
    return time;
  }
}
