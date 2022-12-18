enum StatusEnum{
  confirmed( status: 'Подтвержден'),
  processing(status: 'В работе'),
  done(status: 'Выполнен'),
  refusal(status: 'Отказано'),
  initialization(status: 'Инициализация');

  const StatusEnum({ required this.status});
  final String status;
}