

fn main()
{
  mut uf := map[string]string
  uf['sp'] = 'São Paulo'
  uf['rj'] = 'Rio de Janeiro'

  println(uf['sp'])		// "São Paulo"
  println(uf['mg'])		// "0"
  println('sp' in uf)	// true
  uf.delete('rj')
  println(uf)				// {'sp': 'São Paulo', '': ''}
}
