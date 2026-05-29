import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/profile_photo.dart';

/// The current user's own profile screen.
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.flameGradient,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const ClipOval(
                      child: ProfilePhoto(
                        url:
                            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=400&q=80',
                        initial: 'You',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.flameGradient,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Alex, 26',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'San Francisco, CA',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  _StatCard(label: 'Matches', value: '—', icon: Icons.favorite),
                  SizedBox(width: 12),
                  _StatCard(label: 'Likes', value: '128', icon: Icons.star),
                  SizedBox(width: 12),
                  _StatCard(label: 'Visits', value: '342', icon: Icons.visibility),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _premiumBanner(),
            const SizedBox(height: 12),
            const _SettingsTile(icon: Icons.person_outline, label: 'Edit profile'),
            const _SettingsTile(
                icon: Icons.tune, label: 'Discovery settings'),
            const _SettingsTile(
                icon: Icons.notifications_none, label: 'Notifications'),
            const _SettingsTile(
                icon: Icons.lock_outline, label: 'Privacy & safety'),
            const _SettingsTile(icon: Icons.logout, label: 'Log out'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _premiumBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.flameGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.flameEnd.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.workspace_premium, color: Colors.white, size: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Spark Gold',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'See who likes you & get unlimited likes',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatCard({Key key, this.label, this.value, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (r) => AppColors.flameGradient.createShader(r),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SettingsTile({Key key, this.icon, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(
        label,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: () {},
    );
  }
}
