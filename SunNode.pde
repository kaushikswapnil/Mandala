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
        int growthFrameCount = (int)(m_MaxRadius * 10.0f);
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
         PVector radialVector = m_Position.copy();
         radialVector.normalize();
         
         float driftDist = random(0.005f * m_Parent.GetScaledWidth()/m_Radius);
         m_Position.add(PVector.mult(radialVector, driftDist));
      }
      
      boolean IsDead()
      {
         float distFromCenter = m_Position.mag();
         float parentRadius = m_Parent.GetScaledWidth()/2;
         float maxDist = parentRadius + (random(parentRadius/8, parentRadius/1.7));
         
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
      
      pushMatrix();
      translate(m_Position.x, m_Position.y);
      rotate(m_Angle);
      
      for (SurfaceParticle part : m_SurfaceParticles)
      {
         part.Display();
      }
      popMatrix();
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
      
      float scaledDiameter = GetScaledWidth();
      int maxParticles = (int)max(80, 170 * scaledDiameter/40);
      if (m_SurfaceParticles.size() < maxParticles && random(1) < 0.03)
      {
         int numToAdd = (int)random(30, 100); 
         float minRadius = scaledDiameter/80;
         float maxRadius = scaledDiameter/35;
         for (int iter = 0; iter < numToAdd; ++iter)
         {
            int gColor = (int)random(0, 255);
            PVector randomPos = PVector.random2D();
            randomPos.mult(random(scaledDiameter/2));
            //randomPos.add(m_Position);
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
