class IEffect
{
   int m_StartFrame, m_EndFrame, m_FrameDuration;
   
   IEffect()
   {
      m_FrameDuration = MAX_INT; 
      m_StartFrame = m_EndFrame = 0;
   }
   
   IEffect(int frameDuration)
   {
      m_FrameDuration = frameDuration; 
      m_StartFrame = m_EndFrame = 0;
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
   
   boolean IsStarted()
   {
      return m_StartFrame != 0; 
   }
   
   void Apply(IGraphicNode node)
   {
     
   }
    
   void Apply(Shape shape)
   {
     
   }
   
   void Apply(SimpleShape sShape)
   {
     
   }
   
   void Apply(Pattern pattern)
   {
     
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
   
   void Apply(IGraphicNode node)
   {
     if (m_InitialScale == MAX_FLOAT)
     {
        m_InitialScale = node.m_Scale;  
     }
     
     float interpolatedScale = m_InitialScale + ((m_FinalScale - m_InitialScale) * (frameCount - m_StartFrame) / m_EndFrame); //<>//
     node.m_Scale = interpolatedScale;
   }
   
   void Apply(Shape node)
   {
     if (m_InitialScale == MAX_FLOAT)
     {
        m_InitialScale = node.m_Scale;  
     }
     
     float interpolatedScale = m_InitialScale + ((m_FinalScale - m_InitialScale) * (frameCount - m_StartFrame) / m_EndFrame);
     node.m_Scale = interpolatedScale;
   }
   
   void Apply(Pattern pattern)
   {
     if (m_InitialScale == MAX_FLOAT)
     {
        m_InitialScale = pattern.m_Scale;  
     }
     
     float interpolatedScale = m_InitialScale + ((m_FinalScale - m_InitialScale) * (frameCount - m_StartFrame) / m_EndFrame);
     pattern.m_Scale = interpolatedScale;
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
