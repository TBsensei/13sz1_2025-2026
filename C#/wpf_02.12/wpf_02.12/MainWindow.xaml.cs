using System.Collections.ObjectModel;
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

namespace wpf_02._12
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private ObservableCollection<string> items = new ObservableCollection<string>();
        private ObservableCollection<string> filteredItems = new ObservableCollection<string>();

        public MainWindow()
        {
            InitializeComponent();
            lbItems.ItemsSource = filteredItems;
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            string text = txtInput.Text.Trim();
            if (string.IsNullOrEmpty(text)) return;

            if (lbItems.SelectedIndex != -1)
            {
                int visualIndex = lbItems.SelectedIndex;
                string oldText = filteredItems[visualIndex];

                int realIndex = -1;
                int count = 0;
                for (int i = 0; i < items.Count; i++)
                {
                    if (items[i] == oldText)
                    {
                        if (count == visualIndex)
                        {
                            realIndex = i;
                            break;
                        }
                        count++;
                    }
                }

                if (realIndex != -1)
                {
                    items[realIndex] = text;
                }
            }
            else
            {
                items.Add(text);
            }

            txtInput.Clear();
            lbItems.SelectedIndex = -1;
            UpdateFilter();
        }

        private void LbItems_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (lbItems.SelectedItem != null)
            {
                txtInput.Text = lbItems.SelectedItem.ToString();
            }
        }

        private void BtnDelete_Click(object sender, RoutedEventArgs e)
        {
            if (lbItems.SelectedIndex != -1)
            {
                int visualIndex = lbItems.SelectedIndex;
                string selectedValue = filteredItems[visualIndex];

                int realIndex = -1;
                int currentMatch = 0;

                string filter = txtSearch.Text.ToLower();
                for (int i = 0; i < items.Count; i++)
                {
                    if (items[i].ToLower().Contains(filter))
                    {
                        if (currentMatch == visualIndex)
                        {
                            realIndex = i;
                            break;
                        }
                        currentMatch++;
                    }
                }

                if (realIndex != -1)
                {
                    items.RemoveAt(realIndex);
                }

                txtInput.Clear();
                UpdateFilter();
            }
        }

        private void TxtSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateFilter();
        }

        private void UpdateFilter()
        {
            string filter = txtSearch.Text.ToLower();
            filteredItems.Clear();

            var filteredList = items.Where(i => i.ToLower().Contains(filter)).ToList();
            foreach (var item in filteredList)
            {
                filteredItems.Add(item);
            }
        }
    }
}