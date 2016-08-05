Attribute VB_Name = "UI"
Public Sub ShowSetExportDirectoryForm()
    Load SetWorkingDirectoryForm
    
    On Error Resume Next
        Dim dir As String
        dir = DocPropIO.GetItemFromDocProperties(CodeUtils.EXPORT_DIRECTORY_PROPERTY)
        SetWorkingDirectoryForm.DirTextBox.Text = dir
    On Error GoTo 0
        
    SetWorkingDirectoryForm.Show
End Sub


Public Sub ShowSetGitPathForm()
    Load GitPathForm
    
    On Error Resume Next
        Dim gitPath As String
        gitPath = DocPropIO.GetItemFromDocProperties(Git.PROJECT_PATH_PROPERTY)
        GitPathForm.DirTextBox.Text = gitPath
    On Error GoTo 0
        
    GitPathForm.Show
End Sub


Public Sub ShowSetGitExePathForm()
    Load GitExePathForm
    
    On Error Resume Next
        Dim gitExe As String
        gitExe = GetSetting(CodeUtils.APPNAME, "FileInfo", Git.EXE_PATH_PROPERTY, "")
        GitExePathForm.DirTextBox.Text = gitExe
    On Error GoTo 0
        
    GitExePathForm.Show
End Sub

Public Sub ShowGitCommitForm()
    
    Load GitCommitMessageForm
    GitCommitMessageForm.Show
    
End Sub

Public Sub ShowGitOtherForm()
    
    Load GitConsoleForm
    GitConsoleForm.OutputBox.ScrollBars = fmScrollBarsVertical
    GitConsoleForm.Show False
    
End Sub

Public Function FolderDialog() As String
    Dim fd As FileDialog
    Set fd = Application.FileDialog(msoFileDialogFolderPicker)
    With fd
        If .Show = -1 Then
            FolderDialog = .SelectedItems(1)
            Exit Function
        End If
    End With
    FolderDialog = ""
End Function

