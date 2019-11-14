class Shape extends IGraphicNode
{
   float m_Width, m_Height;
   PVector m_Position;
   float m_Angle;
   
   Pattern m_Pattern;
   
   Shape(float shapeWidth, float shapeHeight)
   {
      m_Width = shapeWidth;
      m_Height = shapeHeight;
      
      m_Position = new PVector(0, 0);
      
      m_Angle = 0.0f;
      
      m_Pattern = null;
   }
   
   Shape(float shapeWidth, float shapeHeight, ArrayList<IEffect> effects)
   {
      m_Width = shapeWidth;
      m_Height = shapeHeight;
      
      m_Position = new PVector(0, 0);
      
      m_Angle = 0.0f;
      
      m_Pattern = null;
      
      m_Effects = effects;
   }
   
   Shape(float shapeWidth, float shapeHeight, Pattern parentPattern)
   {
      m_Width = shapeWidth;
      m_Height = shapeHeight;
      
      m_Position = new PVector(0, 0);
      
      m_Angle = 0.0f;
      
      m_Pattern = parentPattern;
   }
   
   Shape(float shapeWidth, float shapeHeight, PVector position, float angle, Pattern parentPattern, ArrayList<IEffect> effects)
   {
      m_Width = shapeWidth;
      m_Height = shapeHeight;
      
      m_Position = position.copy();

      m_Angle = angle;
      
      m_Pattern = parentPattern;
      
      m_Effects = effects;
   }
   
   Shape Copy()
   {
      Shape node = new Shape(m_Width, m_Height, m_Position, m_Angle, m_Pattern, m_Effects); 
      return node;
   }
   
   float GetScaledWidth()
   {
      return m_Scale * m_Width; 
   }
   
   float GetScaledHeight()
   {
      return m_Scale * m_Height; 
   }
   
   float GetRadialDimension()
   {
      return Math.max(m_Width, m_Height); 
   }
   
   float GetFlatDimension()
   {
      return Math.max(m_Width, m_Height);
   }
   
   void ApplyEffect(IEffect effect)
    {
      effect.Apply(this);
    }
}
