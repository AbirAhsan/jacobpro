class JobLifeCycleModel {
  String? lifecycleStatusName;
  String? jobLifecycleDatetime;
  String? jobOccuredByFullName;
  int? jobOccuranceStatus;
  String? jobLifecycleNote;

  JobLifeCycleModel(
      {this.lifecycleStatusName,
      this.jobLifecycleDatetime,
      this.jobOccuredByFullName,
      this.jobOccuranceStatus,
      this.jobLifecycleNote});

  JobLifeCycleModel.fromJson(Map<String, dynamic> json) {
    lifecycleStatusName = json['lifecycleStatusName'];
    jobLifecycleDatetime = json['jobLifecycleDatetime'];
    jobOccuredByFullName = json['jobOccuredByFullName'];
    jobOccuranceStatus = json['jobOccuranceStatus'];
    jobLifecycleNote = json['jobLifecycleNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lifecycleStatusName'] = lifecycleStatusName;
    data['jobLifecycleDatetime'] = jobLifecycleDatetime;
    data['jobOccuredByFullName'] = jobOccuredByFullName;
    data['jobOccuranceStatus'] = jobOccuranceStatus;
    data['jobLifecycleNote'] = jobLifecycleNote;
    return data;
  }
}
