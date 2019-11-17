class SkyNode extends Shape
{
  int GeneralTime_Dawn = 0;
  int GeneralTime_Morning = 1;
  int GeneralTime_Noon = 2;
  int GeneralTime_Evening = 3;
  int GeneralTime_Dusk = 4;
  int GeneralTime_Night = 5;
  
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
       fill(50, 103, 200);
       
       ellipse(0, 0, diameter, diameter);
     }
  }
  
  float m_InitialTime;
  int m_CycleLength, m_CycleStart, m_CycleEnd;
  float m_InnerR, m_OuterR;
  
  ArrayList<Layer> m_Layers;
  
  SkyNode(float outerR, float startTime, int cycleLength)
  {
    super(outerR*2, outerR*2);
    
    m_Position = g_Center;
    
    m_InitialTime = startTime;
    m_CycleLength = cycleLength;
    
    m_CycleStart = m_CycleEnd = MAX_INT;
  }
  
  void Update()
  {
     super.Update();
     
     if (m_CycleStart == MAX_INT || frameCount > m_CycleEnd)
     {
       m_CycleStart = frameCount;
       m_CycleEnd = m_CycleStart + m_CycleLength;
     }
  }
  
  void Display()
  {
    pushMatrix();
    translate(m_Position.x, m_Position.y);
    rotate(m_Angle);
    
    for (Layer layer : m_Layers)
    {
       layer.Display(GetTime()); 
    }
    
    popMatrix();
  }
  
  void GenerateSkyLayers()
  {
      
  }
  
  float GetTime()
  {
    float time = ((float)(frameCount-m_CycleStart)/m_CycleLength);
    return time;
  }
}
