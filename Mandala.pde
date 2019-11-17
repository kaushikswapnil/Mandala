ArrayList<Pattern> g_Mandala;

PVector g_Center;
void setup()
{
  size(800, 800);
  
  g_Center = new PVector(width/2, height/2);

  GenerateMandala();
}

void draw()
{
  background(0);
  
  for(int pIter = g_Mandala.size() - 1; pIter >= 0; --pIter)
  {
     Pattern p = g_Mandala.get(pIter);
     p.Update();
     p.Display(); 
  }
}

void GenerateMandala()
{
  g_Mandala = new ArrayList<Pattern>();
  
  SunNode sNode = new SunNode(80);
  Pattern p = new Pattern(sNode);
  p.m_BorderColor = new PVector(255, 103, 0);
  g_Mandala.add(p);
  
  Shape node = new MoonNode(30, 600);
  Pattern p1 = new Pattern(node, p.m_OuterRadius);
  p1.m_Effects.add(new RotateEffect(TWO_PI*2, 800));
  p1.m_Effects.get(0).SetLoopable(true);
  
  g_Mandala.add(p1);
  
  ArrayList<IEffect> effects = new ArrayList<IEffect>();
  effects.add(new RotateEffect(-TWO_PI, 800));
  //effects.add(new PulseScaleEffect(3, 80));
  
  effects.get(0).SetLoopable(true);
  //effects.get(1).SetLoopable(true);
  
  Shape sqNode = new RectNode(15, 15, true, new PVector(255, 80, 0), true, new PVector(150, 180, 210), new ArrayList<IEffect>());
  Pattern p2 = new Pattern(sqNode, p1.m_OuterRadius, new PVector(255, 215, 0), new PVector(250, 255, 255), effects);
  g_Mandala.add(p2);
  
  Shape trNode = new TriangleNode(30, true, new PVector(255, 80, 0), true, new PVector(150, 180, 210), new ArrayList<IEffect>());
  Pattern p3 = new Pattern(trNode, p2.m_OuterRadius, new PVector(255, 215, 0), new PVector(250, 255, 255), effects);
  g_Mandala.add(p3);
  
  Shape skyN = new SkyNode(p3.m_OuterRadius, p3.m_OuterRadius+100.0f, 500);
  Pattern p4 = new Pattern(skyN);
  g_Mandala.add(p4);
}

int HSBtoRGB(float hue, float saturation, float brightness) 
{
    int r = 0, g = 0, b = 0;
    if (saturation == 0) 
    {
        r = g = b = (int) (brightness * 255.0f + 0.5f);
    } 
    else 
    {
        float h = (hue - (float)floor(hue)) * 6.0f;
        float f = h - (float)floor(h);
        float p = brightness * (1.0f - saturation);
        float q = brightness * (1.0f - saturation * f);
        float t = brightness * (1.0f - (saturation * (1.0f - f)));
        switch ((int) h) 
        {
        case 0:
            r = (int) (brightness * 255.0f + 0.5f);
            g = (int) (t * 255.0f + 0.5f);
            b = (int) (p * 255.0f + 0.5f);
            break;
        case 1:
            r = (int) (q * 255.0f + 0.5f);
            g = (int) (brightness * 255.0f + 0.5f);
            b = (int) (p * 255.0f + 0.5f);
            break;
        case 2:
            r = (int) (p * 255.0f + 0.5f);
            g = (int) (brightness * 255.0f + 0.5f);
            b = (int) (t * 255.0f + 0.5f);
            break;
        case 3:
            r = (int) (p * 255.0f + 0.5f);
            g = (int) (q * 255.0f + 0.5f);
            b = (int) (brightness * 255.0f + 0.5f);
            break;
        case 4:
            r = (int) (t * 255.0f + 0.5f);
            g = (int) (p * 255.0f + 0.5f);
            b = (int) (brightness * 255.0f + 0.5f);
            break;
        case 5:
            r = (int) (brightness * 255.0f + 0.5f);
            g = (int) (p * 255.0f + 0.5f);
            b = (int) (q * 255.0f + 0.5f);
            break;
        }
    }
    return 0xff000000 | (r << 16) | (g << 8) | (b << 0);
}
