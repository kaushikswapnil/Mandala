class SkyNode extends Shape
{
  int GeneralTime_Dawn = 0;
  int GeneralTime_Morning = 1;
  int GeneralTime_Noon = 2;
  int GeneralTime_Evening = 3;
  int GeneralTime_Dusk = 4;
  int GeneralTime_Night = 5;
  int GeneralTime_Count = 6;
  
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

       PVector skyCol = GetColorFor(GetGeneralTime(time), GetStrengthOfGeneralTime(time));
       fill(skyCol.x, skyCol.y, skyCol.z);
       
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
      else
      {
       retVal = 5; //Night 
      }
      
      return retVal;
     }
     
     float GetStrengthOfGeneralTime(float time)
     {
       float gradientRange = 1.0f/GeneralTime_Count;
       float relStrength = time % gradientRange;
       return relStrength;
     }
     
     PVector GetColorFor(int generalTime, float relStrength)
     {
       PVector retColor;
       
       switch(generalTime)
       {
        case 0: //Dawn
        retColor = new PVector(255, 153, 204);
        break;
        
        case 1: //Morning
        retColor = new PVector(0, 255, 255);
        break;
        
        case 2: //Noon
        retColor = new PVector(255, 255, 102);
        break;
        
        case 3: //Evening
        retColor = new PVector(102, 178, 255);
        break;
        
        case 4: //Dusk
        retColor = new PVector(255, 128, 0);
        break;
        
        case 5: //Night        
        retColor = new PVector(0, 0, 102);
        break;
        
        default:
        
        retColor = new PVector(0, 0, 0);
        break;
       }
       
       return retColor;
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
    float layerTimeIncrement = 1.0f/(GeneralTime_Count*m_Layers.size());
    for (Layer layer : m_Layers) //<>//
    {
       layer.Display(layerTime); 
       layerTime = (layerTime+layerTimeIncrement)%1.0f;
    }
    
    popMatrix();
  }
  
  void GenerateLayers()
  {
    m_Layers = new ArrayList<Layer>();
    
    int numLayers = 3;
    
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
     m_Layers.add(new Layer(innerR, outerR));  //<>//
    }
  }
  
  float GetTime()
  {
    float time = (((float)(frameCount-m_CycleStart)/m_CycleLength) + m_InitialTime)%1.0f;
    return time; //<>//
  }
}
