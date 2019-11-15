class SunNode extends EllipseNode
{
   class SurfaceParticle
   {
     PVector m_Position;
     PVector m_Color;
     float m_Radius;
     float m_MaxRadius; 
     
     SunNode m_Parent;
     
     int m_SpawnFrame;
     
     SurfaceParticle(SunNode parent, PVector position, PVector partColor, float radius)
     {
        m_Parent = parent;
       
        m_Position = position;
        m_Color = partColor;
        m_Radius = 0.5f;    
        m_MaxRadius = radius;
        
        m_SpawnFrame = frameCount;
     }
     
      void Display()
      {
        fill(m_Color.x, m_Color.y, m_Color.z);
        noStroke();
        float diameter = 2*m_Radius;
        ellipse(m_Position.x, m_Position.y, diameter, diameter);
      }
      
      void Update()
      {
        Age();
        PhysicsUpdate();
      }
      
      void Age()
      {
        int growthFrameCount = (int)(m_MaxRadius * 5.0f);
        if (frameCount <= m_SpawnFrame + growthFrameCount)
        {
          m_Radius = map(frameCount, m_SpawnFrame, m_SpawnFrame + growthFrameCount, 0.5f, m_MaxRadius);
        }
        else if (m_Radius > 1.0f && random(1) < (0.01f/m_Radius))
        {
           m_Radius *= random(0.7f, 0.95f); 
        }
      }
      
      void PhysicsUpdate()
      {
         PVector radialVector = PVector.sub(m_Position, m_Parent.m_Position);
         radialVector.normalize();
         
         float driftDist = random(0.005f * m_Parent.m_Width/m_Radius);
         m_Position.add(PVector.mult(radialVector, driftDist));
      }
      
      boolean IsDead()
      {
         float distFromCenter = m_Position.dist(m_Parent.m_Position);
         float parentRadius = m_Parent.m_Width/2;
         float maxDist = parentRadius + (random(parentRadius/8, parentRadius/2));
         
         return distFromCenter > maxDist;
      }
   }
   
   ArrayList<SurfaceParticle> m_SurfaceParticles;
   
   SunNode(float radius)
   {
      super(radius, new PVector(255, 103, 0), new PVector(255, 103, 0));
      m_Fill = true;
      m_Stroke = true;
      m_SurfaceParticles = new ArrayList<SurfaceParticle>();
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
      for (SurfaceParticle part : m_SurfaceParticles)
      {
         part.Display();
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
        if (m_SurfaceParticles.get(iter).IsDead())
        {
           m_SurfaceParticles.remove(iter); 
        }
      }
      
      int maxParticles = (int)max(80, 100 * m_Width/40);
      if (m_SurfaceParticles.size() < maxParticles && random(1) < 0.03)
      {
         int numToAdd = (int)random(30, 80); 
         float minRadius = m_Width/80;
         float maxRadius = m_Width/40;
         for (int iter = 0; iter < numToAdd; ++iter)
         {
            int gColor = (int)random(0, 255);
            PVector randomPos = PVector.random2D();
            randomPos.mult(random(m_Width/2));
            randomPos.add(m_Position);
            m_SurfaceParticles.add(new SurfaceParticle(this, randomPos, new PVector(255, gColor, 0), random(minRadius, maxRadius)));
         }
      }
   }
   
   void UpdateSurfaceParticles()
   {
      for (SurfaceParticle particle : m_SurfaceParticles)
      {
         particle.Update();
      }
   }
}
