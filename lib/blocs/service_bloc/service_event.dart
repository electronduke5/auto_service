part of 'service_bloc.dart';

@immutable
abstract class ServiceEvent {}

class GetListServicesEvent extends ServiceEvent {}
class InitialServiceEvent extends ServiceEvent {}
