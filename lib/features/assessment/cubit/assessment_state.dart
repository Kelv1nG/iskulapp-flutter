import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_erp/enums/action_type.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/assessment_taker.dart';

part 'assessment_state.freezed.dart';

enum AssessmentStateStatus { initial, staging, success, failure }

@freezed
class AssessmentState with _$AssessmentState {
  const factory AssessmentState({
    required Assessment assessment,
    required ActionType actionType,
    @Default([]) List<AssessmentTaker> assessmentTakers,
    @Default([]) List<AssessmentTaker> assessmentTakersForRemoval,
    @Default(AssessmentStateStatus.initial) AssessmentStateStatus status,
    @Default(true) bool isLoading,
    String? errorMessage,
  }) = _AssessmentState;

  factory AssessmentState.initial({
    required String teacherId,
    AssessmentType? assessmentTypeOnCreate,
    Assessment? existingAssessment,
  }) {
    assert(
      !(assessmentTypeOnCreate == null && existingAssessment == null) &&
          !(assessmentTypeOnCreate != null && existingAssessment != null),
      'Either assessmentTypeOnCreate or assessment must be provided, but not both',
    );

    if (existingAssessment == null) {
      return AssessmentState(
        assessment: Assessment.initialize(
          preparedById: teacherId,
          assessmentType: assessmentTypeOnCreate!,
        ),
        actionType: ActionType.create,
      );
    }

    return AssessmentState(
      assessment: existingAssessment,
      actionType: ActionType.update,
    );
  }
}
