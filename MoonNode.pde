class MoonNode extends EllipseNode
{
  class Spot
  {
     PVector m_Position;
     int m_GreyScale;
     float m_Radius;
     
     Spot(PVector pos, float radius)
     {
        m_Position = pos;
        m_Radius = radius;
        m_GreyScale = (int)random(140,230);
     }
  }
  
  int m_CycleDuration;
  int m_CurCycleStart;
  int m_CurCycleEnd;
  
  ArrayList<Spot> m_Spots;
  
  MoonNode(float radius, int cycleDuration)
  {
     super(radius, new PVector(255,255,255), new PVector(255,255,255));
     m_Fill = true;
     m_Stroke = false;
     
     m_CycleDuration = cycleDuration;
     m_CurCycleStart = m_CurCycleEnd = MAX_INT;
     
     GenerateSpots();
  }
  
  void Display()
  {
     super.Display();
     
     pushMatrix();
     translate(m_Position.x, m_Position.y);
     rotate(m_Angle);
     
     DisplayMoonSpots();
     DisplayDarkSide();
     
     popMatrix();
  }
  
  void DisplayMoonSpots()
  {
     noStroke();

     for (Spot spot : m_Spots)
     {
        fill(spot.m_GreyScale, spot.m_GreyScale, spot.m_GreyScale);
        ellipse(spot.m_Position.x, spot.m_Position.y, spot.m_Radius*2, spot.m_Radius*2); 
     }
  }
  
  void DisplayDarkSide()
  {
    float phase = GetPhase();
    
    
  }
  
  void Update()
  {
    super.Update();
    
    if (m_CurCycleStart == MAX_INT || frameCount > m_CurCycleEnd)
    {
       m_CurCycleStart = frameCount;
       m_CurCycleEnd = m_CurCycleStart + m_CycleDuration;
    }
  }
  
  void GenerateSpots()
  {
    m_Spots = new ArrayList<Spot>();
   
    int numSpots = (int)random(m_Width/10) + 1;
    
    for (int iter = 0; iter < numSpots; ++iter)
    {
      float radius = random(0.05f, 0.15f) * m_Width;
      PVector randomPos = PVector.random2D();
      randomPos.mult(random(m_Width/2) - radius);
      m_Spots.add(new Spot(randomPos, radius)); 
    }
  }
  
  float GetPhase()
  {
    float phase = (frameCount - m_CurCycleStart) / (m_CycleDuration);
    return phase;
  }
  
  Shape Copy()
  {
    MoonNode node = new MoonNode(m_Width/2, m_CycleDuration);
    return node;
  }
  
  void ApplyEffect(IEffect effect)
  {
    effect.Apply(this);
  }
}
