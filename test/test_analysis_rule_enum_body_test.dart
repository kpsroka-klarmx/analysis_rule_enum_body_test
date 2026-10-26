import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(TestRuleTest);
  });
}

@reflectiveTest
class TestRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = TestAnalysisRule();
    super.setUp();
  }

  void test_detects_dot_shorthand() async {
    await assertDiagnostics('enum EnumAB { a, b }', [lint(0, 5)]);
  }
}

class TestAnalysisRule extends AnalysisRule {
  TestAnalysisRule() : super(name: 'test_rule', description: '');

  @override
  bool get canUseParsedResult => true;

  @override
  DiagnosticCode get diagnosticCode => const LintCode(
    'test_rule',
    '',
    correctionMessage: 'Fix.',
    uniqueName: 'LintCode.test_rule',
  );

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {}
}
