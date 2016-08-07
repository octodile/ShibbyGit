VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} GitRemoteForm 
   Caption         =   "Git Remote"
   ClientHeight    =   3660
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   5415
   OleObjectBlob   =   "GitRemoteForm.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "GitRemoteForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public remotes As Collection
Public branches As Collection

Public Sub AddPushRemotesToList()
    Dim currentInd As Integer
    currentInd = RemoteBox.ListIndex
    
    RemoteBox.Clear
    Dim remote As GitRemote
    For Each remote In remotes
        If remote.RemoteType = "push" Then
            RemoteBox.AddItem remote.Name
        End If
    Next remote
    
    If currentInd <= UBound(RemoteBox.List) And currentInd > LBound(RemoteBox.List) Then
        RemoteBox.ListIndex = currentInd
    Else
        RemoteBox.ListIndex = 0
    End If
End Sub

Public Sub AddFetchRemotesToList()
    Dim currentInd As Integer
    currentInd = RemoteBox.ListIndex
    
    RemoteBox.Clear
    Dim remote As GitRemote
    For Each remote In remotes
        If remote.RemoteType = "fetch" Then
            RemoteBox.AddItem remote.Name
        End If
    Next remote
    
    If currentInd <= UBound(RemoteBox.List) And currentInd > LBound(RemoteBox.List) Then
        RemoteBox.ListIndex = currentInd
    Else
        RemoteBox.ListIndex = 0
    End If
End Sub

Public Sub AddBranchesToList()
    Dim currentInd As Integer
    currentInd = BranchBox.ListIndex

    BranchBox.Clear
    Dim br As GitBranch
    For Each br In branches
        If br.Active Then
            BranchBox.AddItem "*" & br.Name, 0
        Else
            BranchBox.AddItem br.Name
        End If
    Next br
    
    If currentInd <= UBound(BranchBox.List) And currentInd > LBound(BranchBox.List) Then
        BranchBox.ListIndex = currentInd
    Else
        BranchBox.ListIndex = 0
    End If
End Sub


Private Sub DoneButton_Click()
    GitRemoteForm.Hide
End Sub

Private Sub OKButton_Click()
    
    If RemoteBox.ListIndex = -1 Or BranchBox.ListIndex = -1 Then
        Exit Sub
    End If
    
    Dim operation As String
    If PushButton.value = True Then
        operation = "push"
    ElseIf PullButton.value = True Then
        operation = "pull"
    Else
        operation = "fetch"
    End If
    
    Dim remote As String
    remote = RemoteBox.List(RemoteBox.ListIndex)
    
    Dim branch As String
    branch = BranchBox.List(BranchBox.ListIndex)
    branch = Replace(branch, "*", "")
    
    Dim gitParms As String
    gitParms = operation & " " & remote & " " & branch
    
    Dim command As String
    command = "cmd /c echo Running 'git " & gitParms & "'" & _
    " & " & GitCommands.GitExeWithPath & " " & gitParms & " & pause"
    Debug.Print command
    Shell command, 1
End Sub

Private Sub PushButton_Click()
    AddPushRemotesToList
End Sub

Private Sub PullButton_Click()
    AddFetchRemotesToList
End Sub

Private Sub FetchButton_Click()
    AddFetchRemotesToList
End Sub
