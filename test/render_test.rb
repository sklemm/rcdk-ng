$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rcdk'
require 'rcdk/util'
require 'rcdk/render'
require 'tempfile'

class RenderTest < Test::Unit::TestCase
  include RCDK::Util
  include RCDK::Render


  def test_render_imgs()
    molecule = Lang.read_smiles('Clc1ccccc1')
    Painter.write_png(molecule, 'output/new_chlorobenzene.png', 200, 200)
    Painter.write_jpg(molecule, 'output/new_chlorobenzene.jpg', 200, 200)
    Painter.write_svg(molecule, 'output/new_chlorobenzene.svg', 200, 200)
    molecule = Lang.read_smiles(@aspirin)
    Painter.write_png(molecule, 'output/new_aspirin.png', 200, 200)
    Painter.write_jpg(molecule, 'output/new_aspirin.jpg', 200, 200)
    Painter.write_svg(molecule, 'output/new_aspirin.svg', 200, 200)
    molecule = Lang.read_molfile(@cyclosporine)
    Painter.write_png(molecule, 'output/new_cyclosporine.png', 200, 200)
    Painter.write_jpg(molecule, 'output/new_cyclosporine.jpg', 200, 200)
    Painter.write_svg(molecule, 'output/new_cyclosporine.svg', 200, 200)
  end

  def test_render_temp()
    molecule = Lang.read_smiles(@aspirin)
    file = Tempfile.new('la')
    puts file.path
    Painter.write_svg(molecule, file.path, 200, 200)
  end

  def setup
    @aspirin =
      "OC(=O)C1=CC=CC=C1(OC(=O)C"

    @cyclosporine =
      "
  CDK    5/12/09,19:33

 85 85  0  0  0  0  0  0  0  0999 V2000
    2.3633    0.4207    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    1.4932    1.6426    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.0000    1.5000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.0000    0.0000    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    1.4932   -0.1426    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   -0.2839   -1.4729    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
   -0.8414   -2.8654    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -1.6523   -4.1273    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -0.4733   -5.0546    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   -2.6875   -5.2129    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
   -3.9093   -6.0830    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -5.2738   -6.7061    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -4.7832   -8.1236    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   -6.7315   -7.0598    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
   -8.2298   -7.1311    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -9.7145   -6.9177    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -10.0682   -8.3754    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
  -11.1320   -6.4271    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
  -12.4311   -5.6771    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -13.5647   -4.6948    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -14.6503   -5.7299    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
  -14.4919   -3.5157    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
  -15.1793   -2.1824    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -15.6019   -0.7432    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -17.0747   -1.0271    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
  -15.7444    0.7500    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
  -15.6019    2.2432    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -15.1793    3.6824    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -16.5718    4.2399    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
  -14.4919    5.0157    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
  -13.5647    6.1948    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -12.4311    7.1771    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -13.3011    8.3989    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
  -11.1320    7.9271    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
   -9.7145    8.4177    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -8.2298    8.6311    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -8.3012   10.1294    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   -6.7315    8.5598    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
   -5.2738    8.2061    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -3.9093    7.5830    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -3.1593    8.8820    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   -2.6875    6.7129    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
   -1.6523    5.6273    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -0.8414    4.3654    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.4919    5.0528    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   -0.2839    2.9729    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0
   -0.4733    6.5546    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    0.9193    5.9971    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    1.1328    4.5123    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    2.0984    6.9243    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    3.4909    6.3668    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    4.6700    7.2941    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    6.0626    6.7366    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -0.6867    8.0393    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   -1.7052    7.8466    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -4.7832    9.6236    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -5.7655   10.7573    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -3.3103    9.9075    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -6.5180   10.0445    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -10.0682    9.8754    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -11.5074   10.2980    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -11.8610   11.7557    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -12.5930    9.2629    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -11.7551    9.2915    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -14.6503    7.2299    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -16.0895    6.8073    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -17.1751    7.8424    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -16.4432    5.3496    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -15.7538    5.8267    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -17.0747    2.5271    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -16.5718   -2.7399    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -13.3011   -6.8989    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -12.6780   -8.2634    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -13.5481   -9.4852    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -11.1848   -8.4060    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  -11.7551   -7.7915    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -8.3012   -8.6294    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -9.6344   -9.3168    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -7.0393   -9.4404    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -3.1593   -7.3820    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -3.9093   -8.6811    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -3.1593   -9.9801    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -5.4093   -8.6811    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   -1.7052   -6.3466    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    1.1554   -1.8955    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
  2  1  1  0  0  0  0
  3  2  1  0  0  0  0
  4  3  1  0  0  0  0
  5  4  2  0  0  0  0
  6  4  1  0  0  0  0
  7  6  1  0  0  0  0
  8  7  1  0  0  0  0
  9  8  2  0  0  0  0
 10  8  1  0  0  0  0
 11 10  1  0  0  0  0
 12 11  1  0  0  0  0
 13 12  2  0  0  0  0
 14 12  1  0  0  0  0
 15 14  1  0  0  0  0
 16 15  1  0  0  0  0
 17 16  2  0  0  0  0
 18 16  1  0  0  0  0
 19 18  1  0  0  0  0
 20 19  1  0  0  0  0
 21 20  2  0  0  0  0
 22 20  1  0  0  0  0
 23 22  1  0  0  0  0
 24 23  1  0  0  0  0
 25 24  2  0  0  0  0
 26 24  1  0  0  0  0
 27 26  1  0  0  0  0
 28 27  1  0  0  0  0
 29 28  2  0  0  0  0
 30 28  1  0  0  0  0
 31 30  1  0  0  0  0
 32 31  1  0  0  0  0
 33 32  2  0  0  0  0
 34 32  1  0  0  0  0
 35 34  1  0  0  0  0
 36 35  1  0  0  0  0
 37 36  2  0  0  0  0
 38 36  1  0  0  0  0
 39 38  1  0  0  0  0
 40 39  1  0  0  0  0
 41 40  2  0  0  0  0
 42 40  1  0  0  0  0
 43 42  1  0  0  0  0
 44 43  1  0  0  0  0
 45 44  2  0  0  0  0
 46 44  1  0  0  0  0
 46  3  1  0  0  0  0
 47 43  1  0  0  0  0
 48 47  1  0  0  0  0
 49 48  1  0  0  0  0
 50 48  1  0  0  0  0
 51 50  1  0  0  0  0
 52 51  2  0  0  0  0
 53 52  1  0  0  0  0
 54 47  1  0  0  0  0
 55 42  1  0  0  0  0
 56 39  1  0  0  0  0
 57 56  1  0  0  0  0
 58 56  1  0  0  0  0
 59 38  1  0  0  0  0
 60 35  1  0  0  0  0
 61 60  1  0  0  0  0
 62 61  1  0  0  0  0
 63 61  1  0  0  0  0
 64 34  1  0  0  0  0
 65 31  1  0  0  0  0
 66 65  1  0  0  0  0
 67 66  1  0  0  0  0
 68 66  1  0  0  0  0
 69 30  1  0  0  0  0
 70 27  1  0  0  0  0
 71 23  1  0  0  0  0
 72 19  1  0  0  0  0
 73 72  1  0  0  0  0
 74 73  1  0  0  0  0
 75 73  1  0  0  0  0
 76 18  1  0  0  0  0
 77 15  1  0  0  0  0
 78 77  1  0  0  0  0
 79 77  1  0  0  0  0
 80 11  1  0  0  0  0
 81 80  1  0  0  0  0
 82 81  1  0  0  0  0
 83 81  1  0  0  0  0
 84 10  1  0  0  0  0
 85  6  1  0  0  0  0
M  END"
  end

end
