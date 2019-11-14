class IEffect
{
   int m_StartFrame, m_EndFrame, m_FrameDuration;
   boolean m_IsLoopable;
   
   IEffect()
   {
      m_FrameDuration = MAX_INT; 
      m_StartFrame = m_EndFrame = 0;
      m_IsLoopable = false;
   }
   
   IEffect(int frameDuration)
   {
      m_FrameDuration = frameDuration; 
      m_StartFrame = m_EndFrame = 0;
      m_IsLoopable = false;
   }
  
   boolean IsComplete()
   {
      if (m_FrameDuration != MAX_INT)
      {
         return (frameCount > m_EndFrame);
      }
      
      return false;
   }
   
   void Start()
   {
      m_StartFrame = frameCount;
      m_EndFrame = m_StartFrame + m_FrameDuration;
   }
   
   void Reprime()
   {
      m_StartFrame = frameCount + 1;
      m_EndFrame = m_StartFrame + m_FrameDuration;
   }

   boolean IsStarted()
   {
      return m_StartFrame != 0; 
   }
   
   boolean IsLoopable()
   {
      return m_IsLoopable; 
   }
   
   void SetLoopable(boolean value)
   {
      m_IsLoopable = value; 
   }
   
   void Apply(IGraphicNode node)
   {
     
   }
    
   void Apply(Shape shape)
   {
     IGraphicNode gNode = (IGraphicNode)(shape);
     Apply(gNode);
   }
   
   void Apply(SimpleShape sShape)
   {
     IGraphicNode gNode = (IGraphicNode)(sShape);
     Apply(gNode);
   }
   
   void Apply(Pattern pattern)
   {
     IGraphicNode gNode = (IGraphicNode)(pattern);
     Apply(gNode);
   }
}

class ScaleEffect extends IEffect
{
   float m_FinalScale;
   float m_InitialScale;
   boolean m_ApplyToSubShapes;
   
   ScaleEffect(float finalScale, int frameDuration)
   {
     super(frameDuration);
     m_FinalScale = finalScale;
     m_InitialScale = MAX_FLOAT;
   }
   
   float GetInterpolatedScale()
  {
     float interpolatedScale = m_InitialScale + ((m_FinalScale - m_InitialScale) * (frameCount - m_StartFrame) / m_EndFrame);
     return interpolatedScale;
  }
   
   void Apply(IGraphicNode node)
   {
     if (m_InitialScale == MAX_FLOAT)
     {
        m_InitialScale = node.m_Scale;  
     }
     
     float interpolatedScale = GetInterpolatedScale(); //<>//
     node.m_Scale = interpolatedScale;
   }
}

class RotateEffect extends IEffect
{
   float m_AngleIncrement;
   
   RotateEffect(float angleIncrement, int frameDuration)
   {
     super(frameDuration);
     m_AngleIncrement = angleIncrement;
   }
   
   void Apply(Shape shape)
   {
     float perFrameAngleIncrement = m_AngleIncrement/m_FrameDuration;
     shape.m_Angle += perFrameAngleIncrement;
   }
   
   void Apply(Pattern pattern)
   {
     float perFrameAngleIncrement = m_AngleIncrement/m_FrameDuration;
     float shapeCenterCircleRadius = (pattern.m_InnerRadius + (pattern.m_OuterRadius*pattern.m_Scale))/2;
     for (Shape shape : pattern.m_Shapes)
     {
         PVector relPos = PVector.sub(shape.m_Position, g_Center);
         relPos.normalize();
         relPos.rotate(perFrameAngleIncrement);
         relPos.mult(shapeCenterCircleRadius);
         shape.m_Position = PVector.add(relPos, g_Center);
     }
   }
}

class PulseScaleEffect extends ScaleEffect
{
  int m_MidFrame;
  PulseScaleEffect(float highPulseScale, int frameDuration)
  {
     super(highPulseScale, frameDuration);      
  }
  
  void Start()
  {
     super.Start();
     m_MidFrame = (m_StartFrame + m_EndFrame)/2;
  }
  
  void Reprime()
  {
     super.Reprime();
     m_MidFrame = (m_StartFrame + m_EndFrame)/2;
  }
  
  float GetInterpolatedScale()
  {
     float a, b;
     int frameMin;
     if (frameCount <= m_MidFrame)
     {
        a = m_InitialScale;
        b = m_FinalScale;
        frameMin = m_StartFrame;
     }
     else
     {
        a = m_FinalScale;
        b = m_InitialScale;
        frameMin = m_MidFrame;
     }
     
     int frameDur = m_FrameDuration/2;
     
     float interpolatedScale = a + ((b - a) * (frameCount - frameMin) / frameDur);
     return interpolatedScale;
  }
}
