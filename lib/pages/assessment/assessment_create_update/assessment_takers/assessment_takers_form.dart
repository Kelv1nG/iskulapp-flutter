import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/constants/assessments/form_validation.dart'
    as validation;
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/features/assessment/cubit/assessment_state.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/widgets/assessment_section_row.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/widgets/next_button.dart';
import 'package:school_erp/repositories/repositories.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/routes/routes.dart';
import 'package:go_router/go_router.dart';

class AssessmentTakersForm extends StatefulWidget {
  const AssessmentTakersForm({super.key});

  _AssessmentTakersFormState createState() => _AssessmentTakersFormState();
}

class _AssessmentTakersFormState extends State<AssessmentTakersForm> {
  late List<Section> activeSections;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSectionSelection();
  }

  void _loadSectionSelection() async {
    final teacherId = getTeacherId(context);
    final assessment = context.read<AssessmentCubit>().state.assessment;
    final sections = await sectionRepository.getTeacherSectionsBySubject(
        teacherId: teacherId, subjectYearId: assessment.subjectYearId!);
    setState(() {
      activeSections = sections;
      _isLoading = false;
    });
  }

  void _onNextPressed(BuildContext context, AssessmentState state) async {
    if (_validateTakers(state)) {
      context.push(
        assessmentQuestionSetupRoute.path,
        extra: BlocProvider.of<AssessmentCubit>(context),
      );
    }
  }

  bool _validateTakers(AssessmentState state) {
    for (final taker in state.assessmentTakers) {
      if (taker.sectionId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(validation.emptySectionField),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentCubit, AssessmentState>(
      builder: (context, state) {
        if (_isLoading || state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.separated(
                    itemCount: state.assessmentTakers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 25),
                    itemBuilder: (context, idx) {
                      final taker = state.assessmentTakers[idx];
                      return AssessmentSectionRow(
                        index: idx,
                        key: ValueKey(taker.id),
                        sections: activeSections,
                        assessmentTaker: taker,
                      );
                    },
                  ),
                ),
                const Spacer(),
                NextButton(
                  onPressed: () => _onNextPressed(
                      context, context.read<AssessmentCubit>().state),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }
}
