using System;
using System.Drawing;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace first_wpf
{

    public partial class MainWindow : Window
    {
        private Random _random = new Random();

        public MainWindow()
        {
            InitializeComponent();
        }

        private void CatchMeButton_MouseEnter(object sender, System.Windows.Input.MouseEventArgs e)
        {
            if (GameCanvas.ActualWidth == 0 || GameCanvas.ActualHeight == 0) return;

            double maxX = GameCanvas.ActualWidth - CatchMeButton.Width;
            double maxY = GameCanvas.ActualHeight - CatchMeButton.Height;

            double newX = _random.NextDouble() * maxX;
            double newY = _random.NextDouble() * maxY;

            Canvas.SetLeft(CatchMeButton, newX);
            Canvas.SetTop(CatchMeButton, newY);

            ChangeButtonColor();
        }

        private void CatchMeButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("GRATULÁLOK! Elképesztő reflexeid vannak!", "Győzelem");

            Canvas.SetLeft(CatchMeButton, 250);
            Canvas.SetTop(CatchMeButton, 200);
            CatchMeButton.Background = Brushes.LightGray;
        }

        private void ChangeButtonColor()
        {
            byte r = (byte)_random.Next(256);
            byte g = (byte)_random.Next(256);
            byte b = (byte)_random.Next(256);

            CatchMeButton.Background = new SolidColorBrush(System.Windows.Media.Color.FromRgb(r, g, b));
        }
    }
}