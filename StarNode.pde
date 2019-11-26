class StarNode extends PShapeContainerNode
{
  int m_NumPoints;
  float m_InnerPointRadiiRatio;
  StarNode(int numPoints, float radii, PVector strokeColor, PVector fillColor)
  {
    super();
    
    m_Width = m_Height = radii*2;
    
    m_NumPoints = numPoints;
    m_StrokeColor = strokeColor.copy();
    m_FillColor = fillColor.copy();
    m_InnerPointRadiiRatio = 0.5f;
    CreateShape();
  }
  
  StarNode(int numPoints, float radii, float innerPointRadiiRatio, PVector strokeColor, PVector fillColor)
  {
    super();
    
    m_Width = m_Height = radii*2;
    
    m_NumPoints = numPoints;
    m_StrokeColor = strokeColor.copy();
    m_FillColor = fillColor.copy();
    m_InnerPointRadiiRatio = innerPointRadiiRatio;
    CreateShape();
  }
  
  void CreateShape()
  {
    float diameter = GetScaledWidth();
    
    float dAngle = TWO_PI/m_NumPoints;
    float halfDAngle = dAngle/2;
    float outerR = diameter/2;
    float innerR = outerR * m_InnerPointRadiiRatio;
    float theta = 0.0f;
    
    m_Shape = createShape();
    m_Shape.beginShape();
    m_Shape.fill(m_FillColor.x, m_FillColor.y, m_FillColor.z);
    m_Shape.stroke(m_StrokeColor.x, m_StrokeColor.y, m_StrokeColor.z);
    for (int iter = 0; iter < m_NumPoints; ++iter)
    {
       m_Shape.vertex(cos(theta) * outerR, sin(theta) * outerR);
       float innerTheta = (theta + halfDAngle);
       m_Shape.vertex(cos(innerTheta) * innerR, sin(innerTheta) * innerR);
       theta += dAngle;
    }
    m_Shape.endShape(CLOSE);
  }
  
  Shape Copy()
  {
    StarNode node = new StarNode(m_NumPoints, m_Width/2, m_InnerPointRadiiRatio, m_FillColor, m_StrokeColor);
    return node;
  }
}
