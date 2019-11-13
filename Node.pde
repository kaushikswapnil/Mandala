class Node
{
   float m_Width, m_Height;
   PVector m_Position;
   float m_Angle;
   
   Pattern m_Pattern;
   
   Node(float shapeWidth, float shapeHeight)
   {
      m_Width = shapeWidth;
      m_Height = shapeHeight;
      
      m_Position = new PVector(0, 0);
      
      m_Angle = 0.0f;
      
      m_Pattern = null;
   }
   
   Node(float shapeWidth, float shapeHeight, Pattern parentPattern)
   {
      m_Width = shapeWidth;
      m_Height = shapeHeight;
      
      m_Position = new PVector(0, 0);
      
      m_Angle = 0.0f;
      
      m_Pattern = parentPattern;
   }
   
   Node(float shapeWidth, float shapeHeight, PVector position, float angle, Pattern parentPattern)
   {
      m_Width = shapeWidth;
      m_Height = shapeHeight;
      
      m_Position = position.copy();

      m_Angle = angle;
      
      m_Pattern = parentPattern;
   }
   
   void Display()
   {
 //<>//
   }
   
   Node Copy()
   {
      Node node = new Node(m_Width, m_Height, m_Position, m_Angle, m_Pattern); 
      return node;
   }
   
   float GetRadialDimension()
   {
      return Math.max(m_Width, m_Height); 
   }
   
   float GetFlatDimension()
   {
      return Math.max(m_Width, m_Height);
   }
}
