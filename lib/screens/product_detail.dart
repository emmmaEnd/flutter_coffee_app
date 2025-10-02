import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

enum DrinkSize { small, medium, large }
enum Percent { p10, p20, p50, p100 }

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // sin selección por defecto
  DrinkSize? _size;
  Percent? _ice;
  Percent? _sugar;

  bool get _allSelected => _size != null && _ice != null && _sugar != null;

  static const _bottomBarHeight = 76.0; // altura aprox. de la barra fija

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // imagen + iconos
              Stack(
                children: [
                  Hero(
                    tag: "product-img-${p.name}",
                    child: AspectRatio(
                      aspectRatio: 4 / 5,
                      child: Image.asset(
                        p.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // flecha atrás
                  Positioned(
                    top: 12,
                    left: 12,
                    child: _roundIconButton(
                      context,
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  // corazón
                  Positioned(
                    top: 12,
                    right: 12,
                    child: _roundIconButton(
                      context,
                      icon: p.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: p.isFavorite ? Colors.pink : Colors.white,
                      onTap: () {
                        setState(() {
                          p.isFavorite = !p.isFavorite;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // contenido
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // nombre + rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            p.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star, color: Colors.amber, size: 24),
                        const SizedBox(width: 4),
                        Text(
                          "${p.rating} rating",
                          style: const TextStyle(color: Colors.orange, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // descripción
                    Text(
                      p.description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 17,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // fila de precios
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFFE9E9E9), width: 1)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${p.oldPrice.toStringAsFixed(1)}\$",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.pink,
                            ),
                          ),
                          Text(
                            "Discount",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${p.price.toStringAsFixed(1)}\$",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // size
                    const _SectionTitle("Size", fontSize: 20),
                    _radioRow<DrinkSize>(
                      items: const [
                        (label: "Small", value: DrinkSize.small),
                        (label: "Medium", value: DrinkSize.medium),
                        (label: "Large", value: DrinkSize.large),
                      ],
                      group: _size,
                      onChanged: (v) => setState(() => _size = v),
                      labelFontSize: 17,
                      outerSize: 26,
                      innerSize: 14,
                    ),
                    const SizedBox(height: 12),

                    // ice
                    const _SectionTitle("Ice", fontSize: 20),
                    _radioColumn<Percent>(
                      items: const [
                        (label: "10%", value: Percent.p10),
                        (label: "20%", value: Percent.p20),
                        (label: "50%", value: Percent.p50),
                        (label: "100%", value: Percent.p100),
                      ],
                      group: _ice,
                      onChanged: (v) => setState(() => _ice = v),
                      labelFontSize: 17,
                      outerSize: 26,
                      innerSize: 14,
                    ),
                    const SizedBox(height: 12),

                    // sugar
                    const _SectionTitle("Sugar", fontSize: 20),
                    _radioColumn<Percent>(
                      items: const [
                        (label: "10%", value: Percent.p10),
                        (label: "50%", value: Percent.p50),
                        (label: "100%", value: Percent.p100),
                      ],
                      group: _sugar,
                      onChanged: (v) => setState(() => _sugar = v),
                      labelFontSize: 17,
                      outerSize: 26,
                      innerSize: 14,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // barra inferior fija
      bottomNavigationBar: _BottomActionsBar(
        enabled: _allSelected,
        onAddToCart: _allSelected
            ? () {
                setState(() {
                  if (!p.inCart) {
                    p.inCart = true;
                    p.cartCount = 1;
                  } else {
                    p.cartCount++;
                  }
                });
              }
            : null,
        onBuyNow: _allSelected ? () {} : null,
      ),
    );
  }

  // botón redondo (flecha/corazón)
  Widget _roundIconButton(BuildContext context,
      {required IconData icon, Color? color, VoidCallback? onTap}) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: color ?? Colors.white, size: 33),
        ),
      ),
    );
  }
}

// título de sección
class _SectionTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  const _SectionTitle(this.text, {this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
      ),
    );
  }
}

// radios en fila (size)
Widget _radioRow<T>({
  required List<({String label, T value})> items,
  required T? group,
  required ValueChanged<T> onChanged,
  double labelFontSize = 15,
  double outerSize = 22,
  double innerSize = 12,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: items.map((it) {
      final bool selected = group == it.value;
      return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => onChanged(it.value),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _radioDot(selected: selected, outer: outerSize, inner: innerSize),
                const SizedBox(width: 8),
                Text(
                  it.label,
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

// radios en columna (ice/sugar)
Widget _radioColumn<T>({
  required List<({String label, T value})> items,
  required T? group,
  required ValueChanged<T> onChanged,
  double labelFontSize = 15,
  double outerSize = 22,
  double innerSize = 12,
}) {
  return Column(
    children: items.map((it) {
      final bool selected = group == it.value;
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onChanged(it.value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              _radioDot(selected: selected, outer: outerSize, inner: innerSize),
              const SizedBox(width: 10),
              Text(it.label, style: TextStyle(fontSize: labelFontSize)),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

// radio gris o rosa
Widget _radioDot({
  required bool selected,
  double outer = 22,
  double inner = 12,
}) {
  final Color borderColor = selected ? Colors.pink : Colors.grey.shade400;
  final Color fillColor = selected ? Colors.pink : Colors.transparent;

  return Container(
    width: outer,
    height: outer,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: borderColor, width: 2),
    ),
    alignment: Alignment.center,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: selected ? inner : 0,
      height: selected ? inner : 0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fillColor,
      ),
    ),
  );
}

// barra inferior fija
class _BottomActionsBar extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;

  const _BottomActionsBar({
    required this.enabled,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).padding.bottom;
    final Color strongPink = Colors.pink;
    final Color palePink = Colors.pink.withOpacity(0.20);
    final Color outlinePink = Colors.pink.withOpacity(enabled ? 1 : 0.45);
    final Color textPink = Colors.pink.withOpacity(enabled ? 1 : 0.45);

    return Container(
      color: Colors.white.withOpacity(0), // transparencia total
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + pad),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: outlinePink, width: 2),
                foregroundColor: textPink,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
              onPressed: enabled ? onAddToCart : null,
              child: const Text(
                "Add to Cart",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: enabled ? strongPink : palePink,
                foregroundColor: enabled ? Colors.white : Colors.pink.withOpacity(0.55),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
              onPressed: enabled ? onBuyNow : null,
              child: const Text(
                "Buy Now",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
