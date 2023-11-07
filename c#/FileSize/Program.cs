// See https://aka.ms/new-console-template for more information
string path = "file.iso";
long size = new System.IO.FileInfo(path).Length;
Console.WriteLine( (size/1024) / 1024 + " MB" );
