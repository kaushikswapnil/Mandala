class YinYangNode extends Shape
{
  boolean m_IsInitialized;
  PVector m_Color1;
  PVector m_Color2;
  float m_BorderOffset;
  YinYangNode(float radius, PVector color1, float borderOffset)
  {
     super((radius+borderOffset)*2, (radius+borderOffset)*2);
     
     m_BorderOffset = borderOffset;
     m_IsInitialized = false;
     m_Color1 = color1.copy();
  }

  void Update()
  {
     if (!m_IsInitialized)
     {
       m_Color2 = m_Pattern.m_RegionColor.copy();
       m_IsInitialized = true;
     }
     
     super.Update();
  }
  
  void Display()
  {
    pushMatrix();
    
    translate(m_Position.x, m_Position.y);
    rotate(m_Angle);
    
    float diameter = GetScaledWidth() - (4*m_BorderOffset*m_Scale);
    float radius = diameter/2;
    float halfRadius = diameter/4;
    float eighthRadius = diameter/16;
    noStroke();
    fill(m_Color1.x, m_Color1.y, m_Color1.z);
    ellipse(0, 0, diameter, diameter);
    rectMode(CENTER);
    fill(m_Color2.x, m_Color2.y, m_Color2.z);
    rect(halfRadius, 0, radius, diameter);
    ellipse(0, halfRadius, radius, radius);
    fill(m_Color1.x, m_Color1.y, m_Color1.z);
    ellipse(0, -halfRadius, radius, radius);
    ellipse(0, halfRadius, eighthRadius, eighthRadius);
    fill(m_Color2.x, m_Color2.y, m_Color2.z);
    ellipse(0, -halfRadius, eighthRadius, eighthRadius);
    strokeWeight(1.5f);
    noFill();
    stroke(m_Color1.x, m_Color1.y, m_Color1.z);
    ellipse(0, 0, diameter, diameter);
    
    popMatrix();
  }
  
  Shape Copy()
  {
    YinYangNode node = new YinYangNode(m_Width/2, m_Color1, m_BorderOffset);
    node.m_Effects = m_Effects;
    return node;
  }
}
