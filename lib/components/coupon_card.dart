


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sky_diving/constants/app_colors.dart';

class CouponCard extends StatelessWidget {
  final String code;
  final String description;
  final String status; // 'active', 'expired', 'used', etc.
  final DateTime? expiryDate; // Optional expiry date

  const CouponCard({
    Key? key, 
    required this.code,
    required this.description,
    required this.status,
    this.expiryDate,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.black,
        content: Text('Coupon "$code" copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'used':
        return Colors.orange;
      case 'pending':
        return Colors.yellow[700]!;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge at top right
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getStatusColor(),
                    width: 1,
                  ),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 8),
            
            Text(
              'Code: $code',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            
            SizedBox(height: 8),
            
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[300],
              ),
            ),
            
            if (expiryDate != null) ...[
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[400]),
                  SizedBox(width: 4),
                  Text(
                    'Expires: ${DateFormat('MMM dd, yyyy').format(expiryDate!)}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: 15),
            
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: status.toLowerCase() == 'active' 
                    ? () => _copyToClipboard(context)
                    : null, // Disable if not active
                icon: Icon(Icons.copy, color: Colors.black),
                label: Text('Copy', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: status.toLowerCase() == 'active'
                      ? AppColors.primaryColor
                      : Colors.grey[700], // Greyed out if not active
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}