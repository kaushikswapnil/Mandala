class SunNode extends EllipseNode
{
   ArrayList<PVector> m_SurfaceParticles;
   
   SunNode(float radius)
   {
      super(radius, new PVector(255, 103, 0), new PVector(255, 103, 0));
      m_Fill = true;
      m_Stroke = true;
      m_SurfaceParticles = new ArrayList<PVector>();
   }
   
   void Update()
   {
      super.Update();
      MaintainSurfaceParticles();
      UpdateSurfaceParticles();
   }
   
   void Display()
   {
      super.Display();
      for (PVector partPos : m_SurfaceParticles)
      {
         fill(255, 103, 0);
         noStroke();
         ellipse(partPos.x, partPos.y, 2, 2);
      }
   }
   
   Shape Copy()
   {
      return new SunNode(m_Width/2); 
   }
   
   void MaintainSurfaceParticles()
   {
      for(int iter = m_SurfaceParticles.size() - 1; iter >=0; --iter)
      {
        PVector partPos = m_SurfaceParticles.get(iter);
        if (partPos.dist(m_Position) > ((m_Width/2) + random(5.0f, 9.0f)))
        {
           m_SurfaceParticles.remove(iter); 
        }
      }
      
      if (random(1) < 0.05)
      {
         int numToAdd = (int)random(40, 80); 
         for (int iter = 0; iter < numToAdd; ++iter)
         {
            PVector randomPos = PVector.random2D();
            randomPos.mult((m_Width/2));
            randomPos.add(m_Position);
            m_SurfaceParticles.add(randomPos);
         }
      }
   }
   
   void UpdateSurfaceParticles()
   {
      for (PVector particle : m_SurfaceParticles)
      {
         PVector radialVector = PVector.sub(particle, m_Position);
         radialVector.normalize();
         
         float driftDist = random(0.05f);
         particle.add(PVector.mult(radialVector, driftDist));
      }
   }
}
