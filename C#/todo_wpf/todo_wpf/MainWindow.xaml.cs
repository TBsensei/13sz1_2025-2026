using System;
using System.Windows;
using System.Windows.Controls;

namespace todo_wpf
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void BTN_Save_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TB_Editor.Text))
            {
                return;
            }

            var selected = (ToDoItem)LB.SelectedItem;

            if (selected is null)
            {
                var item = new ToDoItem();
                item.Description = TB_Editor.Text;
                LB.Items.Add(item);
            }
            else
            {
                selected.Description = TB_Editor.Text;
                LB.Items.Refresh();
                LB.SelectedItem = null;
            }

            TB_Editor.Clear();
        }

        private void BTN_Delete_Click(object sender, RoutedEventArgs e)
        {
            if (LB.SelectedItem != null)
            {
                LB.Items.Remove(LB.SelectedItem);
                TB_Editor.Clear();
            }
        }

        private void LB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selected = (ToDoItem)LB.SelectedItem;
            TB_Editor.Text = selected is null ? string.Empty : selected.Description;
        }

        private void TB_Search_TextChanged(object sender, TextChangedEventArgs e)
        {
            string filter = TB_Search.Text.ToLower();

            foreach (ToDoItem item in LB.Items)
            {
                var container = LB.ItemContainerGenerator.ContainerFromItem(item) as FrameworkElement;

                if (container != null)
                {
                    if (item.Description.ToLower().Contains(filter))
                    {
                        container.Visibility = Visibility.Visible;
                    }
                    else
                    {
                        container.Visibility = Visibility.Collapsed;
                    }
                }
            }
        }

        private void BTN_ClearSearch_Click(object sender, RoutedEventArgs e)
        {
            TB_Search.Clear();
        }
    }
}