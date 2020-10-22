function Controller()
{
  installer.wizardPageInsertionRequested.connect(function(widget, page)
  {
    installer.removeWizardPage(installer.components()[0], "WorkspaceWidget");
  })

  installer.autoRejectMessageBoxes();
  installer.setMessageBoxAutomaticAnswer("OverwriteTargetDirectory", QMessageBox.Yes);
  installer.setMessageBoxAutomaticAnswer("stopProcessesForUpdates", QMessageBox.Ignore);

  installer.installationFinished.connect(function()
  {
    gui.clickButton(buttons.NextButton);
  })
}

Controller.prototype.WelcomePageCallback = function()
{
  gui.clickButton(buttons.NextButton, 5000);
}

Controller.prototype.CredentialsPageCallback = function()
{
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.ObligationsPageCallback = function()
{
    var page = gui.pageWidgetByObjectName("ObligationsPage");
    page.obligationsAgreement.setChecked(true);
    page.completeChanged();
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.IntroductionPageCallback = function()
{
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.TargetDirectoryPageCallback = function()
{
  gui.currentPageWidget().TargetDirectoryLineEdit.setText("/tmp/Qt");
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.DynamicTelemetryPluginFormCallback = function()
{
  gui.currentPageWidget().TelemetryPluginForm.statisticGroupBox.disableStatisticRadioButton.setChecked(true);
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function()
{
  var cBoxes = ["Archive", "LTS", "Latest releases", "Preview"];
  for (var i in cBoxes)
  {
    var box = gui.currentPageWidget().findChild(cBoxes[i]);
    if (box)
    {
      box.checked = (cBoxes[i] !== "Archive")
    }
  }

  var refButton = gui.currentPageWidget().findChild("FetchCategoryButton");
  if (refButton)
  {
    refButton.click();
  }

  var widget = gui.currentPageWidget();
  widget.deselectAll();

  var version = "qt5.5150";
  if (installer.value("VERSION") != "")
  {
    version = installer.value("VERSION");
  }

  // package name list: http://download.qt.io/online/qtsdkrepository/

  gui.currentPageWidget().selectComponent("qt."+version+".gcc_64");

  gui.clickButton(buttons.NextButton);
}

Controller.prototype.LicenseAgreementPageCallback = function()
{
  gui.currentPageWidget().AcceptLicenseRadioButton.setChecked(true);
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.StartMenuDirectoryPageCallback = function()
{
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function()
{
  gui.clickButton(buttons.NextButton);
}

Controller.prototype.FinishedPageCallback = function()
{
  var checkBox = gui.currentPageWidget().LaunchQtCreatorCheckBoxForm;
  if (checkBox && checkBox.launchQtCreatorCheckBox)
  {
    checkBox.launchQtCreatorCheckBox.checked = false;
  }
  gui.clickButton(buttons.FinishButton);
}

Controller.prototype.PerformInstallationPageCallback = function()
{
  gui.clickButton(buttons.CommitButton);
}

