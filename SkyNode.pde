class SkyNode extends EllipseNode
{
  float m_Time;
  int m_CycleLength, m_CycleStart, m_CycleEnd;
  
  class SkyLayer
  {
     float m_InnerRadius, m_OuterRadius;
     
     SkyLayer(float innerR, float outerR)
     {
        m_InnerRadius = innerR;
        m_OuterRadius = outerR;
     }
     
     void Display(float time)
     {
       
     }
  }
  
  SkyNode(float radius, float startTime, int cycleLength)
  {
    super(radius, new PVector(), new PVector());
    m_Time = startTime;
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
    
  }
}
