part of 'enquiry_cubit.dart';

abstract class EnquiryState extends Equatable {
  const EnquiryState();

  @override
  List<Object> get props => [];
}

class EnquiryInitial extends EnquiryState {}

class EnquiryLoading extends EnquiryState {}

class EnquiryLoadError extends EnquiryState {
  final String error;

  const EnquiryLoadError({required this.error});

  @override
  List<Object> get props => [error];
}

class EnquiryLoaded extends EnquiryState {
  final List<EnquiryModel> lists;

  const EnquiryLoaded({required this.lists});

  @override
  List<Object> get props => [lists];
}
