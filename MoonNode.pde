class MoonNode extends EllipseNode
{
  class Spot
  {
     PVector m_Position;
     float m_Radius;
     
     Spot(PVector pos, float radius)
     {
        m_Position = pos;
        m_Radius = radius;
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
     noStroke();
     fill(0, 0, 0);
     for (Spot spot : m_Spots)
     {
        ellipse(spot.m_Position.x, spot.m_Position.y, spot.m_Radius*2, spot.m_Radius*2); 
     }
     
     popMatrix();
  }
  
  void Update()
  {
    super.Update();
  }
  
  void GenerateSpots()
  {
    m_Spots = new ArrayList<Spot>();
   
    int numSpots = (int)random(m_Width/8) + 1;
    
    for (int iter = 0; iter < numSpots; ++iter) //<>//
    {
      float radius = random(0.1f, 0.35f) * m_Width;
      PVector randomPos = PVector.random2D();
      randomPos.mult(random(m_Width/2) - radius);
      m_Spots.add(new Spot(randomPos, radius)); 
    }
  }
}
