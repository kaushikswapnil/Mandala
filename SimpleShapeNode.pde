class SimpleShape extends Shape
{
   boolean m_Fill, m_Stroke;
   PVector m_FillColor, m_StrokeColor;
  
   SimpleShape(float shapeWidth, float shapeHeight, boolean fill, boolean stroke)
   {
      super(shapeWidth, shapeHeight);    
      
      m_Fill = fill;
      m_FillColor = new PVector(255, 255, 255);
      m_Stroke = stroke;
      m_StrokeColor = new PVector(255, 255, 255);
   }
   
   SimpleShape(float shapeWidth, float shapeHeight, PVector fillColor, PVector strokeColor)
   {
      super(shapeWidth, shapeHeight);    
      
      m_Fill = true;
      m_FillColor = fillColor;
      m_Stroke = true;
      m_StrokeColor = strokeColor;
   }
   
   SimpleShape(float shapeWidth, float shapeHeight, boolean fill, PVector fillColor, boolean stroke, PVector strokeColor)
   {
      super(shapeWidth, shapeHeight);    
      
      m_Fill = fill;
      m_FillColor = fillColor;
      m_Stroke = stroke;
      m_StrokeColor = strokeColor;
   }
   
   void Display()
   {
       pushMatrix();
       
       if (m_Fill)
       {
          fill(m_FillColor.x, m_FillColor.y, m_FillColor.z);
       }
       
       if (m_Stroke)
       {
          stroke(m_StrokeColor.x, m_StrokeColor.y, m_StrokeColor.z);
       }
       
       DisplayInternal();
       
       popMatrix();
   }
   
   void DisplayInternal()
   {
     
   }
}

class SquareNode extends SimpleShape
{
   SquareNode(float shapeWidth, float shapeHeight, PVector fillColor, PVector strokeColor)
   {
      super(shapeWidth, shapeHeight, fillColor, strokeColor);       
   }
   
   void DisplayInternal()
   {
      translate(m_Position.x, m_Position.y);
      rotate(m_Angle);
      
      rectMode(CENTER);
      rect(0, 0, m_Width, m_Height);
   }
   
   Shape Copy()
   {
      Shape node = new SquareNode(m_Width, m_Height, m_FillColor, m_StrokeColor);
      return node;
   }
   
   float GetRadialDimension()
   {
     PVector wVector = new PVector(m_Width, 0);
     PVector hVector = new PVector(0, m_Height);
     
     PVector diagonal = PVector.add(wVector, hVector);
     return diagonal.mag();
   }
   
   float GetFlatDimension()
   {
     PVector wVector = new PVector(m_Width, 0);
     PVector hVector = new PVector(0, m_Height);
     
     PVector diagonal = PVector.add(wVector, hVector);
     return diagonal.mag();
   }
}

class EllipseNode extends SimpleShape
{
   EllipseNode(float radius, PVector fillColor, PVector strokeColor)
   {
      super(radius*2, radius*2, fillColor, strokeColor);       
   }
  
   EllipseNode(float shapeWidth, float shapeHeight, PVector fillColor, PVector strokeColor)
   {
      super(shapeWidth, shapeHeight, fillColor, strokeColor);       
   }
   
   void DisplayInternal()
   {
      ellipse(m_Position.x, m_Position.y, m_Width, m_Height);
   }
   
   Shape Copy()
   {
      Shape node = new EllipseNode(m_Width, m_Height, m_FillColor, m_StrokeColor);
      return node;
   }
   
   float GetRadialDimension()
   {
     return max(m_Width, m_Height);
   }
   
   float GetFlatDimension()
   {
     return max(m_Width, m_Height);
   }
}

class TriangleNode extends SimpleShape
{
   float m_S;
  
   TriangleNode(float s, PVector fillColor, PVector strokeColor)
   {
      super(s, s, fillColor, strokeColor);
      m_S = s;
      
      float root3 = (float)Math.sqrt(3);
      m_Width = s;
      m_Height = root3 * s /2;
   }
   
   void DisplayInternal()
   {
      translate(m_Position.x, m_Position.y);
      rotate(m_Angle + PI/2);
      beginShape(TRIANGLES);
      float root3 = (float)Math.sqrt(3);
      vertex(0, -m_S/root3);
      vertex(-m_S/2, (m_S/(2*root3)));
      vertex(m_S/2, (m_S/(2*root3)));
      endShape();
   }
   
   Shape Copy()
   {
      Shape node = new TriangleNode(m_S, m_FillColor, m_StrokeColor);
      return node;
   }
}
