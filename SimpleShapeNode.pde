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
   
   SimpleShape(float shapeWidth, float shapeHeight, boolean fill, PVector fillColor, boolean stroke, PVector strokeColor, ArrayList<IEffect> effects)
   {
      super(shapeWidth, shapeHeight, effects);    
      
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

class RectNode extends SimpleShape
{
   RectNode(float squareSide, PVector fillColor, PVector strokeColor)
   {
      super(squareSide, squareSide, fillColor, strokeColor);       
   }
   
   RectNode(float shapeWidth, float shapeHeight, PVector fillColor, PVector strokeColor)
   {
      super(shapeWidth, shapeHeight, fillColor, strokeColor);       
   }
   
   RectNode(float shapeWidth, float shapeHeight, boolean fill, PVector fillColor, boolean stroke, PVector strokeColor, ArrayList<IEffect> effects)
   {
      super(shapeWidth, shapeHeight, fill, fillColor, stroke, strokeColor, effects);       
   }
   
   void DisplayInternal()
   {
      translate(m_Position.x, m_Position.y);
      rotate(m_Angle);
      
      rectMode(CENTER);
      rect(0, 0, m_Width*m_Scale, m_Height*m_Scale);
   }
   
   Shape Copy()
   {
      Shape node = new RectNode(m_Width, m_Height, m_Fill, m_FillColor, m_Stroke, m_StrokeColor, m_Effects);
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
  
   EllipseNode(float shapeWidth, float shapeHeight, boolean fill, PVector fillColor, boolean stroke, PVector strokeColor, ArrayList<IEffect> effects)
   {
      super(shapeWidth, shapeHeight, fill, fillColor, stroke, strokeColor, effects);       
   }
   
   void DisplayInternal()
   {
      ellipse(m_Position.x, m_Position.y, m_Width, m_Height);
   }
   
   Shape Copy()
   {
      Shape node = new EllipseNode(m_Width, m_Height, m_Fill, m_FillColor, m_Stroke, m_StrokeColor, m_Effects);
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
   
   TriangleNode(float s, boolean fill, PVector fillColor, boolean stroke, PVector strokeColor, ArrayList<IEffect> effects)
   {
      super(s, s, fill, fillColor, stroke, strokeColor, effects);
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
      float s = m_S * m_Scale;
      
      vertex(0, -s/root3);
      vertex(-s/2, (s/(2*root3)));
      vertex(s/2, (s/(2*root3)));
      endShape();
   }
   
   Shape Copy()
   {
      Shape node = new TriangleNode(m_S, m_Fill, m_FillColor, m_Stroke, m_StrokeColor, m_Effects);
      return node;
   }
}
