import 'package:flutter/material.dart';

class NavigationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const NavigationCard({
    super.key,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: AssetImage('assets/images/placeholder.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        // Use Padding to ensure content doesn't overflow.
        child: Padding(
          padding: EdgeInsets.all(12), // Add padding around content.
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use minimum vertical space.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with constrained size.
                Icon(
                  icon,
                  size: 40, // Reduced from 48 to fit better.
                  color: Colors.white,
                ),
                SizedBox(height: 8), // Reduced from 12 for tighter spacing.
                
                // Flexible text that wraps and ellipsizes if needed.
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20, // Reduced from 22 for better fit.
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2, // Line height multiplier for compact text.
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2, // Allow text to wrap to 2 lines.
                    overflow: TextOverflow.ellipsis, // Add ellipsis if still too long.
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
