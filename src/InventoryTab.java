import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class InventoryTab {

    public JPanel createInventoryPanel() {
        JPanel panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 50, 20, 50));
        panel.setBackground(Color.WHITE);

        // Title
        JLabel titleLabel = new JLabel("Inventory Management", JLabel.CENTER);
        titleLabel.setFont(new Font("Arial", Font.BOLD, 22));
        titleLabel.setForeground(new Color(50, 50, 50));
        panel.add(titleLabel);
        
        panel.add(Box.createVerticalStrut(10));

        // Form Panel
        JPanel formPanel = new JPanel(new GridLayout(6, 2, 10, 10));
        formPanel.setBackground(Color.WHITE);

        // Components
        JLabel productLabel = new JLabel("Product:");
        JComboBox<String> productComboBox = new JComboBox<>();
        populateProductList(productComboBox);

        JLabel batchNumberLabel = new JLabel("Batch Number:");
        JTextField batchNumberField = new JTextField(15);

        JLabel quantityLabel = new JLabel("Quantity:");
        JTextField quantityField = new JTextField(15);

        JLabel expiryDateLabel = new JLabel("Expiry Date (yyyy-MM-dd):");
        JTextField expiryDateField = new JTextField(15);

        JLabel priceLabel = new JLabel("Set Price:");
        JTextField priceField = new JTextField(15);

        JLabel supplierLabel = new JLabel("Supplier:");
        JComboBox<String> supplierComboBox = new JComboBox<>();
        populateSupplierList(supplierComboBox);

        // Add components to form panel
        formPanel.add(productLabel);
        formPanel.add(productComboBox);
        formPanel.add(batchNumberLabel);
        formPanel.add(batchNumberField);
        formPanel.add(quantityLabel);
        formPanel.add(quantityField);
        formPanel.add(expiryDateLabel);
        formPanel.add(expiryDateField);
        formPanel.add(priceLabel);
        formPanel.add(priceField);
        formPanel.add(supplierLabel);
        formPanel.add(supplierComboBox);

        panel.add(formPanel);
        panel.add(Box.createVerticalStrut(10));

        // Add Button
        JButton addButton = new JButton("Add Inventory");
        addButton.setFont(new Font("Arial", Font.BOLD, 18));
        addButton.setBackground(new Color(30, 144, 255));
        addButton.setForeground(Color.WHITE);
        addButton.setFocusPainted(false);
        addButton.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20));

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        buttonPanel.setBackground(Color.WHITE);
        buttonPanel.add(addButton);

        panel.add(buttonPanel);

        return panel;
    }

    private void populateProductList(JComboBox<String> productComboBox) {
        String query = "SELECT ProductName FROM Products";
        try (PreparedStatement stmt = DatabaseConnection.connection.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                productComboBox.addItem(rs.getString("ProductName"));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error fetching products: " + e.getMessage(), "Database Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void populateSupplierList(JComboBox<String> supplierComboBox) {
        String query = "SELECT Name FROM Suppliers";
        try (Statement stmt = DatabaseConnection.connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                supplierComboBox.addItem(rs.getString("Name"));
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error fetching suppliers: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
