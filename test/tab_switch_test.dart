import "package:android_dev/widgets/animated_indexed_stack.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  testWidgets("switching back shows the previous page again", (tester) async {
    Widget build(int index) => MaterialApp(
      home: AnimatedIndexedStack(
        index: index,
        children: const [Text("A"), Text("B"), Text("C")],
      ),
    );

    Future<void> expectVisible(String label) async {
      await tester.pumpAndSettle();
      for (final l in ["A", "B", "C"]) {
        if (!tester.any(find.text(l))) continue;
        final opacity = tester.widget<AnimatedOpacity>(
          find.ancestor(
            of: find.text(l),
            matching: find.byType(AnimatedOpacity),
          ),
        );
        final shown =
            tester
                .renderObject<RenderAnimatedOpacity>(
                  find.ancestor(
                    of: find.text(l),
                    matching: find.byType(AnimatedOpacity),
                  ),
                )
                .opacity
                .value ==
            1.0;
        expect(shown, l == label, reason: "$l (target ${opacity.opacity})");
      }
    }

    await tester.pumpWidget(build(0));
    await expectVisible("A");
    await tester.pumpWidget(build(2));
    await expectVisible("C");
    await tester.pumpWidget(build(0));
    await expectVisible("A");
    await tester.pumpWidget(build(1));
    await expectVisible("B");
  });
}
