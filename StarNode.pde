class StarNode extends PShapeContainerNode
{
  int m_NumPoints;
  float m_InnerPointRadiiRatio;
  StarNode(int numPoints, float radii, PVector fillColor, PVector strokeColor)
  {
    super();
    
    m_Width = m_Height = radii*2;
    
    m_NumPoints = numPoints;
    m_StrokeColor = strokeColor.copy();
    m_FillColor = fillColor.copy();
    m_InnerPointRadiiRatio = 0.5f;
    CreateShape();
  }
  
  StarNode(int numPoints, float radii, float innerPointRadiiRatio, PVector fillColor, PVector strokeColor)
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
    if (m_Fill)
    {
     m_Shape.fill(m_FillColor.x, m_FillColor.y, m_FillColor.z); 
    }
    else
    {
     m_Shape.noFill(); 
    }
    if(m_Stroke)
    {
     m_Shape.stroke(m_StrokeColor.x, m_StrokeColor.y, m_StrokeColor.z);
    }
    else
    {
     m_Shape.noStroke();
    }
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
    node.m_Fill = m_Fill;
    node.m_Stroke = m_Stroke;
    node.m_Effects = m_Effects;
    return node;
  }
}

class RecursiveStarNode extends SimpleShape
{
  int m_NumLayers;
  int m_NumPoints;
  float m_MinStarRadius, m_InnerRadiiRatio, m_DeltaRot;
  ArrayList<StarNode> m_Stars;
  RecursiveStarNode(int numLayers, int numPoints, float minStarRadius, float innerRRatio)
  {
    super(minStarRadius/pow(innerRRatio, numLayers), minStarRadius/pow(innerRRatio, numLayers), true, true);
    
    m_Fill = false;
    m_StrokeColor = g_Black.copy();
    
    m_NumLayers = numLayers;
    m_NumPoints = numPoints;
    m_MinStarRadius = minStarRadius;
    m_InnerRadiiRatio = innerRRatio;
    m_DeltaRot = TWO_PI/m_NumPoints;
    
    GenerateStars();
  }
  
  void GenerateStars()
  {
    m_Stars = new ArrayList<StarNode>();
    
    float starRadius = m_MinStarRadius*m_Scale;
    
    for(int iter = 0; iter < m_NumLayers; ++iter)
    {
      StarNode newStarA = new StarNode(m_NumPoints, starRadius, m_InnerRadiiRatio, m_FillColor, m_StrokeColor);
      newStarA.m_Position = g_NullVector.copy();
      newStarA.m_Fill = m_Fill;
      newStarA.m_Angle = 0.0f;
      newStarA.CreateShape();
      
      m_Stars.add(newStarA);
      
      StarNode newStarB = new StarNode(m_NumPoints, starRadius, m_InnerRadiiRatio, m_FillColor, m_StrokeColor);
      newStarB.m_Position = g_NullVector.copy();
      newStarB.m_Fill = m_Fill;
      newStarB.m_Angle = m_DeltaRot/2;
      newStarB.CreateShape();
      
      m_Stars.add(newStarB);
      
      starRadius = starRadius/m_InnerRadiiRatio;
    }
  }
  
  void Display()
  {
   pushMatrix();
   
   translate(m_Position.x, m_Position.y);
   rotate(m_Angle);
   
   for (StarNode star : m_Stars)
   {
    star.Display(); 
   }
   
   popMatrix();
  }
  
  Shape Copy()
  {
    RecursiveStarNode node = new RecursiveStarNode(m_NumLayers, m_NumPoints, m_MinStarRadius, m_InnerRadiiRatio);
    node.m_Fill = m_Fill;
    node.m_FillColor = m_FillColor.copy();
    node.m_Stroke = m_Stroke;
    node.m_StrokeColor = m_StrokeColor.copy();
    node.m_Effects = m_Effects;
    node.GenerateStars();
    return node;
  }
}

class RecursiveStarMandala extends RecursiveStarNode
{
  float m_BorderCircleRadius;
  
  RecursiveStarMandala(int numLayers, int numPoints, float minStarRadius, float innerRRatio, float borderCircleRadius)
  {
   super(numLayers, numPoints, minStarRadius, innerRRatio);
   
   float recursiveStarDiameter = GetScaledWidth();
   float finalDiameterWithBorder = recursiveStarDiameter + 2*borderCircleRadius*m_Scale;
   float unscaledFinalDiameter = finalDiameterWithBorder/m_Scale;
   m_BorderCircleRadius = borderCircleRadius;
   
   m_Width = m_Height = unscaledFinalDiameter;
   
   GenerateStars();
  }
  
  void Display()
  {
    super.Display();
    
    pushMatrix();
    
    translate(m_Position.x, m_Position.y);
    rotate(m_Angle);
    
    noFill();
    stroke(m_StrokeColor.x, m_StrokeColor.y, m_StrokeColor.z);
    float maxStarRadius = m_MinStarRadius*m_Scale/pow(m_InnerRadiiRatio, m_NumLayers);
    strokeWeight(1.3f);
    ellipse(0, 0, maxStarRadius, maxStarRadius);
    ellipse(0, 0, (maxStarRadius)+(2*m_BorderCircleRadius*m_Scale), (maxStarRadius)+(2*m_BorderCircleRadius*m_Scale));
    popMatrix();
  }
  
  Shape Copy()
  {
    RecursiveStarMandala node = new RecursiveStarMandala(m_NumLayers, m_NumPoints, m_MinStarRadius, m_InnerRadiiRatio, m_BorderCircleRadius);
    node.m_Fill = m_Fill;
    node.m_FillColor = m_FillColor.copy();
    node.m_Stroke = m_Stroke;
    node.m_StrokeColor = m_StrokeColor.copy();
    node.m_Effects = m_Effects;
    node.GenerateStars();
    return node;
  }
}
