import 'package:flutter/Material.dart';
// import 'dart:ui';

class WalletAccount {
  final String currency;
  final String balance;
  final String accountNumber;
  final String country;
  final Color color;

  WalletAccount({
    required this.currency,
    required this.balance,
    required this.accountNumber,
    required this.country,
    required this.color,
  });
}
final List<WalletAccount> accounts = [
  WalletAccount(
    currency: "YER",
    balance: "1,250,000",
    accountNumber: "784512963",
    country: "Yemen",
    color: const Color(0xFF1E7F43),
  ),
  WalletAccount(
    currency: "SAR",
    balance: "8,540",
    accountNumber: "962314587",
    country: "Saudi Arabia",
    color: const Color(0xFF2FAF74),
  ),
  WalletAccount(
    currency: "USD",
    balance: "2,430.50",
    accountNumber: "145236987",
    country: "United States",
    color: const Color(0xFF1F4DD8),
  ),
];
class WalletAccountCard extends StatelessWidget {
  final WalletAccount account;

  const WalletAccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 190,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            account.color,
            account.color.withOpacity(0.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: account.color.withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(account.currency,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const Icon(Icons.account_balance_wallet,
                  color: Colors.white, size: 28),
            ],
          ),
          const Spacer(),
          Text(account.balance,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold)),
          const Text("Available Balance",
              style: TextStyle(color: Colors.white70)),
          const Spacer(),
          Text("**** ${account.accountNumber.substring(account.accountNumber.length - 4)}",
              style: const TextStyle(
                  color: Colors.white, letterSpacing: 2, fontSize: 16)),
        ],
      ),
    );
  }
}
class WalletDeck extends StatefulWidget {
  const WalletDeck({super.key});

  @override
  State<WalletDeck> createState() => _WalletDeckState();
}

class _WalletDeckState extends State<WalletDeck> {
  int activeIndex = 0;
  double dragOffset = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        alignment: Alignment.topCenter,
        children: List.generate(accounts.length, (index) {
          final position = index - activeIndex;

          if (position < 0) return const SizedBox();

          return AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            top: position * 35 + (position == 0 ? dragOffset : 0),
            child: position == 0
                ? _buildDraggableCard(accounts[index])
                : Transform.scale(
              scale: 0.95,
              child: WalletAccountCard(account: accounts[index]),
            ),
          );
        }).reversed.toList(),
      ),
    );
  }

  Widget _buildDraggableCard(WalletAccount account) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          dragOffset += details.delta.dy;
          if (dragOffset < 0) dragOffset = 0;
        });
      },
      onVerticalDragEnd: (_) {
        if (dragOffset > 120) {
          _goToNextCard();
        }
        setState(() => dragOffset = 0);
      },
      child: WalletAccountCard(account: account),
    );
  }

  void _goToNextCard() {
    setState(() {
      activeIndex++;
      if (activeIndex >= accounts.length) {
        activeIndex = 0;
      }
    });
  }
}