Attribute VB_Name = "ģ��1"
'
'Ver 1.2
'Date 2023.7.15
'Author Silas
'
Public it As Integer
Sub ȫ��ҳ�߾��ҳü()
    Selection.WholeStory
    With ActiveDocument.PageSetup
        .TopMargin = CentimetersToPoints(2.5)
        .BottomMargin = CentimetersToPoints(2.5)
        .LeftMargin = CentimetersToPoints(2.5)
        .RightMargin = CentimetersToPoints(2.5)
    End With
    Selection.ParagraphFormat.LineSpacingRule = wdLineSpace1pt5

    ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
    Selection.HomeKey Unit:=wdLine
    Selection.EndKey Unit:=wdLine, Extend:=wdExtend
    Selection.Delete
    Selection.TypeText Text:="�ϲ����մ�ѧѧʿѧλ����"
    Selection.HomeKey Unit:=wdLine
    Selection.EndKey Unit:=wdLine, Extend:=wdExtend
    Selection.Font.Name = "����"
    Selection.Font.Size = 9
    Selection.EndKey Unit:=wdStory

    With ActiveDocument.PageSetup
        .FooterDistance = CentimetersToPoints(1.5)
    End With
    
    With ActiveDocument.Sections(1).Footers(wdHeaderFooterPrimary)
        .Range.Font.Name = "Times New Roman"
        .Range.Font.Size = 9
        .Range.ParagraphFormat.Alignment = wdAlignParagraphCenter
    End With

    ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
    Selection.HomeKey
    MsgBox "��ɣ�"
End Sub
'======================================================================

Sub ���Ĵ����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "����"
    Selection.Font.Size = 15
    Selection.Font.Bold = False
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
End Sub

Sub �����뵼ʦ_����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "����"
    Selection.Font.Size = 12
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    Selection.ParagraphFormat.SpaceBefore = 0
    Selection.ParagraphFormat.SpaceBeforeAuto = False
    Selection.ParagraphFormat.SpaceAfter = 0
    Selection.ParagraphFormat.SpaceAfterAuto = False
    Selection.ParagraphFormat.LineUnitBefore = 0
    Selection.ParagraphFormat.LineUnitAfter = 0
    Selection.Font.Bold = False
End Sub

Sub ����ժҪ_����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "����"
    Selection.Font.Size = 16 ' ���ֺ�����Ϊ���ţ�16����
    Selection.Font.Bold = True
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    With Selection.ParagraphFormat
        .LineSpacingRule = wdLineSpaceExactly ' �����о�Ϊ�̶�ֵ
        .LineSpacing = 22 ' �����о�Ϊ22��
    End With
    Selection.ParagraphFormat.SpaceBefore = 0.5
    Selection.ParagraphFormat.SpaceAfter = 0.5
End Sub

Function IsStyleExists(styleName As String) As Boolean
    Dim style As style
    For Each style In ActiveDocument.Styles
        If style.NameLocal = styleName Then
            IsStyleExists = True
            Exit Function
        End If
    Next style
    IsStyleExists = False
End Function

Sub ����ժҪ_����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    
    
    ' �ж���ʽ�Ƿ����
    Dim styleExists As Boolean
    styleExists = IsStyleExists("����ժҪ_����")
    
    ' ��ʽ�����ڣ���������ӵ���ʽ����
    If Not styleExists Then
        Dim myStyle As style
        Set myStyle = ActiveDocument.Styles.Add(Name:="����ժҪ_����", Type:=wdStyleTypeParagraph)
        With myStyle.Font
            .Name = "����"
            .Size = 12
            .Bold = False
        End With
        With myStyle.ParagraphFormat
            .LineSpacingRule = wdLineSpaceExactly
            .LineSpacing = 22
        End With
        
        ' ������ʽ��ģ��
        ActiveDocument.AttachedTemplate.Styles.Add myStyle
        ActiveDocument.AttachedTemplate.Save
    End If
    
    ' ��ѡ�е��ı�Ӧ������ʽ
    Selection.style = "����ժҪ_����"
    
    
    ' ��ѡ���ı�ǰ���� "ժҪ��"

    Dim selectedRange As Range
    Set selectedRange = Selection.Range
    
    If selectedRange.Start > 3 Then
        Dim previousText As String
        previousText = Mid(selectedRange.Text, 1, 3)
        
        If Trim(previousText) <> "ժҪ��" Then
            ' ������ƶ���ѡ���ı�����λ
            Selection.Collapse Direction:=wdCollapseStart
            Selection.InsertBefore "ժҪ��"
            Selection.Font.Name = "����"
            Selection.Font.Size = 14
            Selection.Font.Bold = True
        End If
    End If
    
    
End Sub


Sub ���ժҪ��Ӧ����ʽ1()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    
    ' ��ѡ���ı�ǰ���� "ժҪ" ������
    Selection.InsertBefore "ժҪ"
    Selection.Font.Name = "����"
    Selection.Font.Size = 14
    Selection.Font.Bold = True
    Selection.Font.Color = wdColorAutomatic
    
    ' �ж���ʽ�Ƿ����
    Dim styleExists As Boolean
    styleExists = IsStyleExists("����ժҪ_����")
    
    ' ��ʽ�����ڣ����������浽ģ����
    If Not styleExists Then
        Dim myStyle As style
        Set myStyle = ActiveDocument.Styles.Add(Name:="����ժҪ_����", Type:=wdStyleTypeParagraph)
        With myStyle.Font
            .Name = "����"
            .Size = 12
            .Bold = False
        End With
        With myStyle.ParagraphFormat
            .LineSpacingRule = wdLineSpaceExactly
            .LineSpacing = 22
        End With
        
        ' ����һ���µ�ģ���ĵ�
        Dim templateDoc As Document
        Set templateDoc = Documents.Add
        
        ' ����ʽ��ӵ�ģ���ĵ�����ʽ������
        templateDoc.Styles.Add myStyle
        
        ' ���Ϊģ���ļ�
        templateDoc.SaveAs2 "D:\����\ģ���ļ�_ժҪ����.dotm", wdFormatXMLTemplateMacroEnabled
        
        ' �ر�ģ���ĵ�
        templateDoc.Close
    End If
    
    ' ��ѡ�е��ı�Ӧ������ʽ
    Selection.style = "����ժҪ_����"
End Sub


Sub ���ժҪ��Ӧ����ʽ2()

    Dim styleName As String '�����ַ���
    styleName = "����ժҪ_����"      '��ֵ
    
    If styleIsExists(ThisDocument, styleName) Then
        MsgBox "�ĵ���" & ThisDocument.Name & "�����ڡ�" & styleName & "����ʽ" & vbCr & "��", 64, "�����ʽ�Ƿ���ڣ�"
    Else
        Set myStyle = ActiveDocument.Styles.Add(Name:=styleName, Type:=wdStyleTypeParagraph)
        MsgBox "�ĵ���" & ThisDocument.Name & "�������ڡ�" & styleName & "����ʽ" & vbCr & "���Զ�������", 16, "�����ʽ�Ƿ���ڣ�"
        ' ������ʽ�ĸ�ʽ
        With myStyle.Font
            .Name = "����"
            .Size = 12
            .Color = wdColorAutomatic
            .Bold = False
        End With
        With myStyle.ParagraphFormat
            .LineSpacingRule = wdLineSpaceExactly
            .LineSpacing = 22
        End With
        
        ActiveDocument.AttachedTemplate.Styles.Add myStyle
    End If
    

End Sub

' �ж���ʽ�Ƿ����
Function styleIsExists(myDocument As Word.Document, styleName As String) As Boolean

    On Error Resume Next
    styleIsExists = myDocument.Styles(styleName).NameLocal = styleName
    
End Function


Sub ����ժҪ��ʽҪ��()
    MsgBox "                                             ������ժҪ��ʽҪ��" & Chr(13) & _
        "��һ�ţ�" & vbCrLf & "��ҵ��ƣ����ģ���Ŀ���������żӴ��֣����У��о�̶�ֵ22��������ǰ0.5�У��κ�0.5��" & vbCrLf & vbCrLf & _
        "�ڶ��ţ�" & vbCrLf & "ѧ�������� ǰ���������ָ�С�ĺ��֣�������С�ĺţ���д����ʹ�ÿ���С�ĺ�" & vbCrLf & _
        "�༶��  ǰ���������ָ�С�ĺ��֣�������С�ĺţ���д����ʹ�ÿ���С�ĺ�" & vbCrLf & vbCrLf & _
        "�����ţ�" & vbCrLf & "ָ����ʦ�� ǰ���������ָ�С�ĺ��֣�������С�ĺ��֣���д����ʹ�ÿ���С�ĺ�" & vbCrLf & vbCrLf & _
        "�����ţ�" & vbCrLf & "ժҪ�� �����ĺżӴ֣�������Ϊ����С�ĺ��֣��о�̶�ֵ22��" & vbCrLf & vbCrLf & _
        "�����ţ�" & vbCrLf & "�ؼ��ʣ� ����С�ļӴ֣�������ſ�һ�У�С�ĺţ����ʻ�Ϊ����С�ĺţ����ʻ���һ�����ָ����һ�ʲ��ñ�����" & vbCrLf & vbCrLf & _
        "�����ţ�" & vbCrLf & "ָ����ʦǩ���� ǰ�ն�ʮ�����ָ�С�ĺţ�������С�ļӴ֣�������ſն��У�С�ĺţ���������дǩ����"
End Sub



Sub ���Ĺؼ���()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "����"
    Selection.Font.Size = 12
    Selection.Font.Bold = False
    Selection.ParagraphFormat.CharacterUnitFirstLineIndent = 0
    Selection.ParagraphFormat.FirstLineIndent = CentimetersToPoints(0)
    
       Dim selectedText As String
    selectedText = Selection.Text
    
    If Not IsEmpty(selectedText) Then
        Dim currentRange As Range
        Set currentRange = Selection.Range
        
        For Each c In currentRange.Characters
            If VBA.Asc(c) >= 0 And c.Font.Name <> "Times New Roman" Then
                c.Font.Name = "Times New Roman"
            End If
        Next c
    End If
    
        ' ������ƶ���ѡ���ı�����λ
    Selection.Collapse Direction:=wdCollapseStart
    
    ' ��ѡ���ı�ǰ���� "�ؼ���"
    Selection.InsertBefore "�ؼ��ʣ�"
    Selection.Font.Name = "����"
    Selection.Font.Size = 12
    Selection.Font.Bold = True
    Selection.Font.Color = wdColorAutomatic
    
    
End Sub
'======================================================================

Sub Ӣ�Ĵ����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "Times New Roman"
    Selection.Font.Size = 16
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    Selection.Font.Bold = True
    Selection.ParagraphFormat.LineSpacing = 22
    Selection.ParagraphFormat.SpaceBefore = 0.5
    Selection.ParagraphFormat.SpaceAfter = 0.5
End Sub

Sub �����뵼ʦ_Ӣ��()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "Times New Roman"
    Selection.Font.Size = 12
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    Selection.ParagraphFormat.SpaceBefore = 0
    Selection.ParagraphFormat.SpaceBeforeAuto = False
    Selection.ParagraphFormat.SpaceAfter = 0
    Selection.ParagraphFormat.SpaceAfterAuto = False
    Selection.ParagraphFormat.LineUnitBefore = 0
    Selection.ParagraphFormat.LineUnitAfter = 0
    Selection.Font.Bold = False
End Sub

Sub Ӣ��ժҪ_����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "Times New Roman"
    Selection.Font.Size = 16
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    Selection.Font.Bold = True
    Selection.ParagraphFormat.LineSpacing = 22
    Selection.ParagraphFormat.SpaceBefore = 0.5
    Selection.ParagraphFormat.SpaceAfter = 0.5
End Sub

Sub Ӣ��ժҪ_����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    
    
    ' �ж���ʽ�Ƿ����
    Dim styleExists As Boolean
    styleExists = IsStyleExists("Ӣ��ժҪ_����")
    
    ' ��ʽ�����ڣ���������ӵ���ʽ����
    If Not styleExists Then
        Dim myStyle As style
        Set myStyle = ActiveDocument.Styles.Add(Name:="Ӣ��ժҪ_����", Type:=wdStyleTypeParagraph)
        With myStyle.Font
            .Name = "Times New Roman"
            .Size = 12
            .Bold = False
        End With
        With myStyle.ParagraphFormat
            .LineSpacingRule = wdLineSpaceExactly
            .LineSpacing = 22
        End With
        
        ' ������ʽ��ģ��
        ActiveDocument.AttachedTemplate.Styles.Add myStyle
        ActiveDocument.AttachedTemplate.Save
    End If
    
    ' ��ѡ�е��ı�Ӧ������ʽ
    Selection.style = "Ӣ��ժҪ_����"

    
    ' ��ѡ���ı�ǰ���� "Abstract:"
    Dim selectedRange As Range
    Set selectedRange = Selection.Range
    
    If selectedRange.Start > 10 Then
        Dim previousText As String
        previousText = Mid(selectedRange.Text, 1, 10)
        
        If Trim(previousText) <> "Abstract:" Then
            ' ������ƶ���ѡ���ı�����λ
            Selection.Collapse Direction:=wdCollapseStart
            Selection.InsertBefore "Abstract: "
            Selection.Font.Name = "Times New Roman"
            Selection.Font.Size = 14
            Selection.Font.Bold = True
            Selection.Font.Color = wdColorAutomatic
        End If
        
        If Trim(previousText) = "Abstract:" Then
            selectedRange.SetRange selectedRange.Start, selectedRange.Start + 9
            selectedRange.Font.Bold = True
            selectedRange.Font.Name = "Times New Roman"
            selectedRange.Font.Size = 14
            
        End If
        
    End If
    
End Sub

Sub Ӣ�Ĺؼ���()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.Font.Name = "Times New Roman"
    Selection.Font.Size = 12
    Selection.Font.Bold = False
    Selection.ParagraphFormat.LineSpacing = 22
    Selection.ParagraphFormat.CharacterUnitFirstLineIndent = 0
    Selection.ParagraphFormat.FirstLineIndent = CentimetersToPoints(0)
    
            ' ������ƶ���ѡ���ı�����λ
    Selection.Collapse Direction:=wdCollapseStart
    
    ' ��ѡ���ı�ǰ���� "Keywords:"
    Selection.InsertBefore "Keywords:"
    Selection.Font.Name = "Times New Roman"
    Selection.Font.Size = 12
    Selection.Font.Bold = True
    Selection.Font.Color = wdColorAutomatic
    
End Sub
'======================================================================

Sub ����һ������()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    With ActiveDocument.Styles("���� 1").Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 15
        .Bold = True
    End With
    
    
    With ActiveDocument.Styles("���� 1").ParagraphFormat
        .SpaceBefore = 0.5
        .SpaceBeforeAuto = False
        .SpaceAfter = 0.5
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 22
        .Alignment = wdAlignParagraphCenter
        .LineUnitBefore = 0
        .LineUnitAfter = 0
    End With
        
    Selection.ClearFormatting
    Selection.style = ActiveDocument.Styles("���� 1")
    Selection.HomeKey Unit:=wdLine
    Selection.InsertBreak Type:=wdPageBreak
    
    MsgBox "��������һҳ"
End Sub

Sub ���Ķ�������()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    With ActiveDocument.Styles("���� 2").Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 14
        .Bold = True
    End With
    
    With ActiveDocument.Styles("���� 2").ParagraphFormat
        .SpaceBefore = 0.5
        .SpaceBeforeAuto = False
        .SpaceAfter = 0.5
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 22
        .Alignment = wdAlignParagraphLeft
        .LineUnitBefore = 0
        .LineUnitAfter = 0
    End With
    
    Selection.ClearFormatting
    Selection.style = ActiveDocument.Styles("���� 2")
End Sub

Sub ������������()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    With ActiveDocument.Styles("���� 3").Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 12
        .Bold = True
    End With
    
    With ActiveDocument.Styles("���� 3").ParagraphFormat
        .SpaceBefore = 0.5
        .SpaceBeforeAuto = False
        .SpaceAfter = 0.5
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 22
        .Alignment = wdAlignParagraphLeft
        .LineUnitBefore = 0
        .LineUnitAfter = 0
    End With
    
    Selection.ClearFormatting
    Selection.style = ActiveDocument.Styles("���� 3")
End Sub

Sub ����()
    If Selection.Type = wdSelectionIP Then
        Selection.Expand Unit:=wdParagraph
    ElseIf Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ�����֣�"
        Exit Sub
    End If
    
    Selection.ClearFormatting
    
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 12
    End With
    
    Selection.Font.Bold = False
    
    With Selection.ParagraphFormat
        .SpaceBefore = 0
        .SpaceBeforeAuto = False
        .SpaceAfter = 0
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 22
        .Alignment = wdAlignParagraphJustify
        .CharacterUnitFirstLineIndent = 2
    End With

End Sub
'======================================================================

Sub ��л�ο����׸�¼��ʹ��һ������()
   If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    With ActiveDocument.Styles("���� 1").Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 15
        .Bold = True
    End With
    
    
    With ActiveDocument.Styles("���� 1").ParagraphFormat
        .SpaceBefore = 0.5
        .SpaceBeforeAuto = False
        .SpaceAfter = 0.5
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 22
        .Alignment = wdAlignParagraphCenter
        .LineUnitBefore = 0
        .LineUnitAfter = 0
    End With
        
    Selection.ClearFormatting
    Selection.style = ActiveDocument.Styles("���� 1")
    Selection.HomeKey Unit:=wdLine
    Selection.InsertBreak Type:=wdPageBreak
    
    MsgBox "��������һҳ"
End Sub

Sub �ο�����_����()
     If Selection.Type = wdSelectionIP Then
        Selection.Expand Unit:=wdParagraph
    ElseIf Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ�����֣�"
        Exit Sub
    End If
    
    Selection.ClearFormatting
    
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 10.5
    End With
    
    Selection.Font.Bold = False
    
    With Selection.ParagraphFormat
        .SpaceBefore = 0
        .SpaceBeforeAuto = False
        .SpaceAfter = 0
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 22
        .Alignment = wdAlignParagraphJustify
    End With
End Sub

Sub ��л_����()
     If Selection.Type = wdSelectionIP Then
        Selection.Expand Unit:=wdParagraph
    ElseIf Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ�����֣�"
        Exit Sub
    End If
    
    Selection.ClearFormatting
    
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 12
    End With
    
    Selection.Font.Bold = False
    
    With Selection.ParagraphFormat
        .SpaceBefore = 0
        .SpaceBeforeAuto = False
        .SpaceAfter = 0
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceExactly
        .LineSpacing = 22
        .Alignment = wdAlignParagraphJustify
        .CharacterUnitFirstLineIndent = 2
    End With
    
End Sub

Sub �����_ͼ����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.ClearFormatting
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 10.5
    End With
    
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter '����
    Selection.ParagraphFormat.LineSpacingRule = wdLineSpaceSingle '�����о�
    
    Selection.Font.Bold = True
    For Each c In Selection.Characters
        If VBA.Asc(c) >= 0 And c.Font.Name <> "Times New Roman" Then
            c.Font.Name = "Times New Roman"
        End If
    Next
    
    MsgBox "ע�⣺ͼ����ͼ����һ���ָ�"
End Sub

Sub ͼ��_ע��()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    Selection.ClearFormatting
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .NameOther = "Times New Roman"
        .Size = 10.5
    End With
    
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter '����
    Selection.ParagraphFormat.LineSpacingRule = wdLineSpaceSingle '�����о�
    
    For Each c In Selection.Characters
        If VBA.Asc(c) >= 0 And c.Font.Name <> "Times New Roman" Then
            c.Font.Name = "Times New Roman"
        End If
    Next
    
    MsgBox "ע�⣺ͼ��������ͼ��������һ���ָ�"
End Sub

Function TableLine()
    With Selection.Tables(1)
        .Borders(wdBorderLeft).LineStyle = wdLineStyleNone
        .Borders(wdBorderRight).LineStyle = wdLineStyleNone
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
            .Color = wdColorAutomatic
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
            .Color = wdColorAutomatic
        End With
        With .Borders(wdBorderHorizontal)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth050pt
            .Color = wdColorAutomatic
        End With
        .Borders(wdBorderVertical).LineStyle = wdLineStyleNone
        .Borders(wdBorderDiagonalDown).LineStyle = wdLineStyleNone
        .Borders(wdBorderDiagonalUp).LineStyle = wdLineStyleNone
        .Borders.Shadow = False
    End With
End Function


'�����ʽ������һ������
Sub �������()
    If Selection.Type = wdSelectionIP Or Selection.Type = wdSelectionNormal Then
        MsgBox "��ѡ�б��"
        Exit Sub
    End If
    
    temp = TableLine()
    rn = Selection.Tables(1).Rows.Count
    Selection.Font.Name = "����"
    Selection.Font.Size = 10.5
    Selection.Tables(1).AutoFitBehavior wdAutoFitWindow
    Selection.Tables(1).AutoFitBehavior wdAutoFitContent
 
    temp = TableLine()
    Selection.Tables(1).Rows(2).Select
    Selection.MoveDown Unit:=wdLine, Count:=(rn - 2), Extend:=wdLine
    With Options
        .DefaultBorderLineStyle = wdLineStyleSingle
        .DefaultBorderLineWidth = wdLineWidth100pt
        .DefaultBorderColor = wdColorAutomatic
    End With
    Selection.Borders(wdBorderHorizontal).LineStyle = wdLineStyleNone
    Selection.ParagraphFormat.CharacterUnitFirstLineIndent = 0
    Selection.ParagraphFormat.FirstLineIndent = CentimetersToPoints(0)
    
    With Selection.Tables(1)
'       .Alignment = wdAlignParagraphCenter
        .Rows.Alignment = wdAlignRowCenter
        .Range.Cells.VerticalAlignment = wdCellAlignVerticalCenter
        .AutoFitBehavior wdAutoFitWindow
        .AutoFitBehavior wdAutoFitContent
    End With
    
    '��������ı��Ķ��뷽ʽ��Ϊˮƽ���ж���
    With Selection.Tables(1).Range
        .Cells.VerticalAlignment = wdCellAlignVerticalCenter
        .ParagraphFormat.Alignment = wdAlignParagraphCenter
    End With


End Sub

Sub ȫ�ı������()
    Dim tbs As Tables, tb As Table
    Set tbs = ActiveDocument.Tables
    n = tbs.Count
    For i = 1 To n
        Set tb = tbs(i)
        rn = tb.Rows.Count
        tb.Select
        Selection.Font.Name = "����"
        Selection.Font.Size = 10.5
        Selection.Tables(1).AutoFitBehavior (wdAutoFitWindow)
        Selection.Tables(1).AutoFitBehavior (wdAutoFitContent)
'       Selection.Tables(1).AutoFitBehavior (wdAutoFitWindow)
        temp = TableLine()
        tb.Rows(2).Select
        Selection.MoveDown Unit:=wdLine, Count:=(rn - 2), Extend:=wdLine
        With Options
            .DefaultBorderLineStyle = wdLineStyleSingle
            .DefaultBorderLineWidth = wdLineWidth100pt
            .DefaultBorderColor = wdColorAutomatic
        End With
        Selection.Borders(wdBorderHorizontal).LineStyle = wdLineStyleNone
        Selection.ParagraphFormat.CharacterUnitFirstLineIndent = 0
        Selection.ParagraphFormat.FirstLineIndent = CentimetersToPoints(0)
    Next i
    MsgBox "���"
End Sub

Sub ����ֽڷ�()
    Selection.InsertBreak Type:=wdSectionBreakNextPage
End Sub

Sub �����ҳ��()
    Selection.InsertBreak Type:=wdPageBreak
End Sub

Sub �����������ַ�()
    Selection.ParagraphFormat.CharacterUnitFirstLineIndent = 2
End Sub

Sub ȫ��Ӣ��ʹ������������()
    On Error GoTo msg
    Dim ps As Paragraphs
    Set ps = ActiveDocument.Paragraphs
    n = ps.Count
    For i = 1 To n
        For Each c In ps(i).Range.Characters
            If VBA.Asc(c) >= 0 And c.Font.Name <> "Times New Roman" Then
                c.Font.Name = "Times New Roman"
            End If
        Next
    Next
    MsgBox "��ɣ�"
    Exit Sub
msg:
    MsgBox "���˵����⣬���������  >_<", Title:="Error", buttons:=vbCritical
End Sub

Sub �����ĵ���ԭ��()
    On Error GoTo msg
    ActiveDocument.Save
    Fname = ActiveDocument.Name
    strs = Split(Fname, ".")
    For i = LBound(strs, 1) To (UBound(strs, 1) - 1)
        myname = myname & strs(i) & "."
    Next i
    endformat = strs(UBound(strs, 1))
    timenow = Format(Now, "(��ԭ��yyyy-mm-dd_hh'mm'ss)")
    savename = timenow & myname & endformat
    fpath = ActiveDocument.Path
    ActiveDocument.SaveAs fpath & "\" & savename
    ActiveDocument.Close
    Documents.Open (fpath & "\" & Fname)
    MsgBox "��ɣ�" & Chr(13) & "��ԭ��λ�ڸ��ĵ������ļ���"
    Exit Sub
msg:
    MsgBox "���˵����⣬���������  >_<", Title:="Error", buttons:=vbCritical
End Sub

Sub ɾ��ȫ�Ŀ���()
    Dim ps As Paragraphs
    Set ps = ActiveDocument.Paragraphs
    For Each p In ps
        If p = Chr(13) Then
            p.Range.Delete
        End If
    Next
    MsgBox "��ɣ�"
End Sub

Sub ɾ���ո�()
    Dim myRange As Range
    If Selection.Type = wdSelectionIP Then
        MsgBox "��ѡ������"
    Else
        Set myRange = Selection.Range
        myRange.Find.Execute FindText:=" ", replacewith:="", Replace:=wdReplaceAll
        MsgBox "�ո�ɾ����ϣ�"
    End If
End Sub

Sub ȫѡ()
    Selection.WholeStory
End Sub

Sub �����ע()
    With Selection
        With .FootnoteOptions
            .Location = wdBottomOfPage
            .NumberingRule = wdRestartContinuous
            .StartingNumber = 1
            .NumberStyle = wdNoteNumberStyleArabic
            .LayoutColumns = 0
        End With
        .Footnotes.Add Range:=Selection.Range, Reference:=""
    End With
End Sub

Sub ����ҳ��()
    response = MsgBox("����Ҫ��ʾ��" & Chr(13) & "��ȷ�����λ�ڵ�1��һ������ǰ" & Chr(13) & "�ٵ��[ȷ��]  ������[ȡ��]", buttons:=vbOKCancel + vbDefaultButton2)
    If response = 1 Then
        response = MsgBox("���ٴ�ȷ�ϡ�" & Chr(13) & "��ȷ�Ϲ��λ����ȷλ��", buttons:=vbOKCancel + vbDefaultButton2)
        If response <> 1 Then
            Exit Sub
        End If
    Else
        Exit Sub
    End If

    Selection.InsertBreak Type:=wdSectionBreakNextPage
    
    With ActiveDocument.Sections(1)
        .Footers(wdHeaderFooterPrimary).PageNumbers.Add PageNumberAlignment:=wdAlignPageNumberCenter, FirstPage:=True
        .Footers(wdHeaderFooterPrimary).PageNumbers.StartingNumber = 1
        .Footers(wdHeaderFooterPrimary).PageNumbers.NumberStyle = wdPageNumberStyleUppercaseRoman
        .Footers(wdHeaderFooterPrimary).Range.Font.Name = "Times New Roman"
        .Footers(wdHeaderFooterPrimary).Range.Font.Size = 9
        '.Headers(1).Range.ParagraphFormat.Borders(3).LineStyle = wdLineStyleNone
    End With
    With ActiveDocument.Sections(2)
        .Footers(wdHeaderFooterPrimary).PageNumbers.Add PageNumberAlignment:=wdAlignPageNumberCenter, FirstPage:=True
        .Footers(wdHeaderFooterPrimary).PageNumbers.RestartNumberingAtSection = True
        .Footers(wdHeaderFooterPrimary).PageNumbers.StartingNumber = 1
        .Footers(wdHeaderFooterPrimary).PageNumbers.NumberStyle = wdPageNumberStyleArabic
        .Footers(wdHeaderFooterPrimary).Range.Font.Name = "Times New Roman"
        .Footers(wdHeaderFooterPrimary).Range.Font.Size = 9
        '.Headers(1).Range.ParagraphFormat.Borders(3).LineStyle = wdLineStyleNone
    End With
    MsgBox "��ɣ�"
End Sub

Sub ȫ�ı����ӱ���()
    Dim tbs As Tables, tb As Table
    Set tbs = ActiveDocument.Tables
    n = tbs.Count
    For i = 1 To n
        Set tb = tbs(i)
        tb.Select
        Selection.MoveLeft Count:=2
        Selection.MoveUp Unit:=wdParagraph, Count:=2, Extend:=wdExtend
        If Selection.Text Like "*��*able*" Then
            Selection.Delete
            Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=wdExtend
            Selection.Delete
        End If
        tb.Select
        Selection.MoveLeft Count:=2
        tabletitle = Chr(13) & "�� " & "x.x ���������" & Chr(13) & "Table " & "x.x Please input title"
        Selection.TypeText tabletitle
        Selection.MoveUp Unit:=wdParagraph, Count:=2, Extend:=wdExtend
        Selection.ClearFormatting
        Selection.Font.Name = "����"
        Selection.Font.Size = 10.5
        Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
        Selection.Font.Bold = True
        For Each c In Selection.Characters
            If VBA.Asc(c) >= 0 And c.Font.Name <> "Times New Roman" Then
                c.Font.Name = "Times New Roman"
            End If
        Next
    Next i
    tbs(1).Select
    Selection.MoveLeft Count:=2
    MsgBox "��ɣ������ֶ������������"
End Sub

Sub ȫ��ͼƬ��ӱ���()
    Dim pics As InlineShapes, pic As InlineShape
    Set pics = ActiveDocument.InlineShapes
    n = pics.Count
    For i = 1 To n
        Set pic = pics(i)
        pic.Select
        Selection.MoveRight Count:=2
        Selection.MoveDown Unit:=wdParagraph, Count:=2, Extend:=wdExtend
        If Selection.Text Like "*ͼ*igure*" Then
            Selection.Delete
            Selection.MoveRight Unit:=wdCharacter, Count:=1, Extend:=wdExtend
        End If
        pic.Select
        Selection.MoveRight Count:=1
        pictitle = Chr(13) & "ͼ " & "x.x ���������" & Chr(13) & "Figure " & "x.x Please input title"
        Selection.TypeText pictitle
        Selection.MoveUp Unit:=wdParagraph, Count:=2, Extend:=wdExtend
        Selection.ClearFormatting
        Selection.Font.Name = "����"
        Selection.Font.Size = 10.5
        Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
        Selection.Font.Bold = True
        For Each c In Selection.Characters
            If VBA.Asc(c) >= 0 And c.Font.Name <> "Times New Roman" Then
                c.Font.Name = "Times New Roman"
            End If
        Next
    Next i
    pics(1).Select
    Selection.MoveRight Count:=2
    MsgBox "��ɣ������ֶ������������"
End Sub

Sub Ŀ¼����()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    
    ' ����ѡ�ı�����Ϊ����һ��ʽ
    Selection.style = ActiveDocument.Styles("���� 1")
    
    With Selection.Font
        .NameFarEast = "����"
        .Size = 15
        .Bold = False
        .Italic = False
        .ColorIndex = wdAuto
    End With
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    Selection.ParagraphFormat.LineSpacing = 22
    Selection.ParagraphFormat.SpaceBefore = 0.5
    Selection.ParagraphFormat.SpaceAfter = 0.5
End Sub

Sub Ŀ¼һ������()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
        
        ' ����ѡ�ı�����Ϊ���ĸ�ʽ
    Selection.style = ActiveDocument.Styles("����")
    
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .Size = 15
        .Bold = False
        .Underline = False
    End With
    
    With Selection.ParagraphFormat
        .Alignment = wdAlignParagraphLeft
        .SpaceBefore = 0
        .SpaceAfter = 0
    End With
    
    '����Ʊ�λ
'    With Selection.ParagraphFormat.TabStops
'        .ClearAll
'        .Add Position:=CentimetersToPoints(12.5), Leader:=wdTabLeaderMiddleDot, Alignment:=wdAlignTabLeft
'       .Add Position:=InchesToPoints(2), Leader:=wdTabLeaderMiddleDot, Alignment:=wdAlignTabLeft
'    End With

    
'   MsgBox "�Ʊ�λ������ɣ���Tab��������е�������"

    Selection.ParagraphFormat.LineSpacingRule = wdLineSpaceExactly
    Selection.ParagraphFormat.LineSpacing = 22
End Sub

Sub Ŀ¼��������()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub
    End If
    

    With Selection.ParagraphFormat.TabStops
        .ClearAll
        .Add Position:=CentimetersToPoints(12.5), Leader:=wdTabLeaderMiddleDot, Alignment:=wdAlignTabLeft
'       .Add Position:=InchesToPoints(2), Leader:=wdTabLeaderMiddleDot, Alignment:=wdAlignTabLeft
    End With

    
    MsgBox "�Ʊ�λ������ɣ���Tab��������е�������"
    
    
    '---------------------------------------------------------------------------------
    
    Selection.ParagraphFormat.LineSpacingRule = wdLineSpaceExactly
    Selection.ParagraphFormat.LineSpacing = 22
    
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .Size = 12
        .Bold = False
        .Underline = False
    End With
    With Selection.ParagraphFormat
        .LeftIndent = CentimetersToPoints(0)
        .CharacterUnitFirstLineIndent = 0
        .CharacterUnitLeftIndent = 1
    End With

End Sub

Sub Ŀ¼��������()
    If Selection.Type <> wdSelectionNormal Then
        MsgBox "��ѡ������"
        Exit Sub

    With Selection.ParagraphFormat.TabStops
        .ClearAll
        .Add Position:=CentimetersToPoints(12.5), Leader:=wdTabLeaderMiddleDot, Alignment:=wdAlignTabLeft
'       .Add Position:=InchesToPoints(2), Leader:=wdTabLeaderMiddleDot, Alignment:=wdAlignTabLeft
    End With

    
    MsgBox "�Ʊ�λ������ɣ���Tab��������е�������"
    
    
    '---------------------------------------------------------------------------------
    
    Selection.ParagraphFormat.LineSpacingRule = wdLineSpaceExactly
    Selection.ParagraphFormat.LineSpacing = 22
    
    With Selection.Font
        .NameFarEast = "����"
        .NameAscii = "Times New Roman"
        .Size = 12
        .Bold = False
        .Underline = False
    End With
    With Selection.ParagraphFormat
        .LeftIndent = CentimetersToPoints(0)
        .CharacterUnitFirstLineIndent = 0
        .CharacterUnitLeftIndent = 2
    End With
End Sub

Sub ���ΪPDF()
    MsgBox "�ò���Լ��Ҫ1~30��" & Chr(13) & "�����ȷ������ʼִ��", Title:="��ʾ"
    Fname = ActiveDocument.Name
    strs = Split(Fname, ".")
    For i = LBound(strs, 1) To (UBound(strs, 1) - 1)
        myname = myname & strs(i) & "."
    Next i
    fpath = ActiveDocument.Path
    ActiveDocument.SaveAs2 fpath & "\" & myname & "pdf", fileformat:=wdFormatPDF
    MsgBox "��ɣ�" & Chr(13) & "pdf�ļ�λ�ڸ��ĵ������ļ���"
End Sub

Sub ���Ŀ�ݼ�()
    CustomizationContext = NormalTemplate
    KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF2), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.����"
    FindKey(BuildKeyCode(wdKeyF2)).Execute
End Sub

Sub ����������ݼ�()
    CustomizationContext = NormalTemplate
    KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF3), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.�����������ַ�"
    FindKey(BuildKeyCode(wdKeyF3)).Execute
End Sub

Sub ʹ�ÿ�ݼ�()
    CustomizationContext = NormalTemplate
    KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF2), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.����"
    KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF3), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.�����������ַ�"
    txt = "����ݼ���Ϣ��" & Chr(13) & "F1  ����ѡ��  (��ģʽ��ʹ��)" & Chr(13) & "F2  �������ĸ�ʽ" & Chr(13) & "F3  �����������ַ�"
    MsgBox txt, Title:="��ʾ"
End Sub

Sub ���������ݼ�()
    CustomizationContext = NormalTemplate
    KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF2), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.����"
    KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF3), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.�����������ַ�"
    KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF1), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.��������"
    FindKey(BuildKeyCode(wdKeyF1)).Execute
End Sub

Sub ��������()
    If it <> 1 Then
        Selection.HomeKey
        Selection.Expand Unit:=wdParagraph
        it = 1
        Exit Sub
    End If
    Selection.Move Unit:=wdParagraph
    Selection.Expand Unit:=wdParagraph
    If Selection.Type = wdSelectionColumn Or Selection.Type = wdSelectionRow Then
        Selection.Expand Unit:=wdTable
    ElseIf Selection.Type <> wdSelectionNormal Then
        Do
            Selection.Move Unit:=wdParagraph
            Selection.Expand Unit:=wdParagraph
        Loop Until Selection.Type = wdSelectionNormal
    End If
End Sub

Sub ����()
    txt1 = "���ϲ����մ�ѧ���Ʊ�ҵ���ĸ�ʽ����_1.2��" _
    & Chr(13) & "���ߣ�dumb fox" _
    & Chr(13) & "��ǰ�汾��1.2" _
    & Chr(13) & "�������ڣ�2023.7.15" _
    & Chr(13) & "======================================"
    txt2 = "���°汾����װ����ģ�https://blessonism.github.io" _
    & Chr(13) & "���������ϵ���ߣ�463882408@qq.com" _
    & Chr(13) & "��л����֧�֣�^_^" _
    & Chr(13) & "�ο�С��ͬѧ_������ҵ��ѧ���Ʊ�ҵ���ĸ�ʽ����:https://github.com/xzy103/BjfuPaperFormat"
    MsgBox txt1 & Chr(13) & txt2
End Sub

Sub ������վ()
    Dim doc_Hlink As Document
    Set doc_Hlink = Documents.Add
    Dim hypTemp As Hyperlink
    Set hypTemp = doc_Hlink.Hyperlinks.Add(Address:="https://blessonism.github.io", Anchor:=Selection.Range)
    hypTemp.Follow NewWindow:=False, AddHistory:=True
    doc_Hlink.Close 0
End Sub

Sub ˵����()
txt0 = "�ϲ����մ�ѧ���Ʊ�ҵ���ĸ�ʽ����" & Chr(13)
txt1 = "���ߣ�dumb fox" _
& Chr(13) & "��ǰ�汾��1.2" _
& Chr(13) & "��������2023.7.15" _
& Chr(13) & "======================================"

txt2 = "��ȫ�����á�" _
& Chr(13) & "ȫ��ҳ�߾�ҳü��һ�����ã�ȫ����Ч����������ҳ�߾��ҳü������" _
& Chr(13) & "����ҳ�룺��Ҫ�Ѿ����úø��������ʽ���ٵ��" _
& Chr(13) & "ȫѡ��ѡ��ȫ��" _
& Chr(13) & "ɾ��ȫ�Ŀ��У���ȫ����Ч�������ڶ�ȫ�Ľ����Ű�ǰ" _
& Chr(13) & "�����ĵ���ԭ�㣺��ͬһ�ļ�Ŀ¼������һ����ǰ�ĵ�����" _
& Chr(13) & "���ΪPDF����ͬһ�ļ�Ŀ¼������һ��pdf��ʽ�ĵ�" & Chr(13)

txt3 = "����Ҫ�����ʽ��" _
& Chr(13) & "���Ĵ���⣺��Ҫ��ѡ���ٵ���������ĵı���" _
& Chr(13) & "Ӣ�Ĵ���⣺��Ҫ��ѡ���ٵ���������ĵ�Ӣ�ı���" _
& Chr(13) & "һ�����⣺��Ҫ��ѡ���ٵ��" _
& Chr(13) & "�������⣺��Ҫ��ѡ���ٵ��" _
& Chr(13) & "�������⣺��Ҫ��ѡ���ٵ��" & Chr(13)

txt4 = "��Ŀ¼��ʽ��" _
& Chr(13) & "Ŀ¼���⣺��Ҫ��ѡ���ٵ������Ŀ¼��Ŀ¼����" _
& Chr(13) & "Ŀ¼һ�����⣺��Ҫ��ѡ���ٵ������Ŀ¼�е�һ��������Ŀ" _
& Chr(13) & "Ŀ¼�������⣺��Ҫ��ѡ���ٵ������Ŀ¼�еĶ���������Ŀ" _
& Chr(13) & "Ŀ¼�������⣺��Ҫ��ѡ���ٵ������Ŀ¼�е�����������Ŀ" & Chr(13)

txt5 = "��ժҪ��ؼ��ʡ�" _
& Chr(13) & "����ժҪ_���⣺��Ҫ��ѡ���ٵ����������ժҪ��ժҪ����" _
& Chr(13) & "����ժҪ_���ݣ���Ҫ��ѡ���ٵ����������ժҪ�����ݲ���ժҪ����" _
& Chr(13) & "���Ĺؼ��ʣ���Ҫ��ѡ���ٵ�������������Ĺؼ��ʵĸ�ʽ" _
& Chr(13) & "Ӣ��ժҪ_���⣺�ο�����" _
& Chr(13) & "Ӣ��ժҪ_���ݣ��ο�����" _
& Chr(13) & "Ӣ�Ĺؼ��ʣ��ο�����" & Chr(13)

txt6 = "�����ø�ʽ��" _
& Chr(13) & "���ĸ�ʽ����Ҫ��ѡ���ٵ���������ĵ����Ķ��䣬����ͼƬ�ͱ���Ԫ�أ���ݼ�F2" _
& Chr(13) & "��л/�ο�����/��¼����Ҫ��ѡ���ٵ������Щ���ı�����ʹ��һ������" _
& Chr(13) & "�ο�����_���ģ���Ҫ��ѡ���ٵ��" _
& Chr(13) & "�����뵼ʦ_���ģ���Ҫ��ѡ���ٵ����λ�ڴ������" _
& Chr(13) & "�����뵼ʦ_Ӣ�ģ��ο���һ��" & Chr(13)

txt7 = "�������ͼƬ��" _
& Chr(13) & "ȫ�ı����ӱ��⣺����Ҫѡ�У���ȫ����Ч����ɺ���Ҫ�ֶ������������" _
& Chr(13) & "ȫ��ͼƬ��ӱ��⣺�ο���һ��" _
& Chr(13) & "ȫ�ı���ʽ���ã�����Ҫѡ�У���ȫ�ĵı������Ϊ����Ҫ������߱�" _
& Chr(13) & "���ñ���ʽ����Ҫ��ѡ��ĳһ����ٵ����Ч��ͬ��һ��" _
& Chr(13) & "�����/ͼ�����ʽ����Ҫ��ѡ��ͼ/��ı��ⲿ���ٵ��" & Chr(13)

txt8 = "����ʽ����" _
& Chr(13) & "�����������ַ���ѡ�ж���򽫹��λ����Ҫ���ĵĶ��䣬�ٵ������ݼ�F3" _
& Chr(13) & "ȫ��Ӣ�����������壺����Ҫѡ�У���ȫ����Ч" _
& Chr(13) & "ɾ���ո�ѡ�������ڵ����пո񽫻ᱻɾ������������Ӣ�Ķ��䣩" _
& Chr(13) & "�����ҳ�����Ƚ����λ����Ҫ����ĵط����ٵ��" _
& Chr(13) & "����ֽڷ���ͬ�ϣ�һ��������ҳ���ʱ����ܻ��õ�" & Chr(13)

txt9 = "�����ڱ������" _
& Chr(13) & "������汾���鿴������汾" _
& Chr(13) & "������վ�����ʸò����Ŀ��GitHub�ֿ���վ" _
& Chr(13) & "ʹ��˵���飺����" _
& Chr(13) & "ʹ�ÿ�ݼ�����ݼ���Ϣ�������ݼ�ʧЧ��������һ��" & Chr(13)

txt10 = "����ģʽ��" _
& Chr(13) & "�μ�[��ģʽ]�µ�ʹ��˵��" _
& Chr(13) & Chr(13) & "======================================" & Chr(13)

txt11 = "���°汾����װ����ģ�https://blessonism.github.io" _
& Chr(13) & "���������ϵ���ߣ�463882408.com" _
& Chr(13) & "��л����֧�֣�^_^"

txts = txt1 & Chr(13) & txt2 & Chr(13) & txt3 & Chr(13) & txt4 & Chr(13) & txt5 & Chr(13) & txt6 & Chr(13) & txt7 & Chr(13) & txt8 & Chr(13) & txt9 & Chr(13) & txt10 & Chr(13) & txt11

Path = ActiveDocument.Path
Dim doc As Document
Set doc = Documents.Add
doc.SaveAs Path & "\�ϲ����մ�ѧ���Ʊ�ҵ���ĸ�ʽ����˵����1.0.docx"

With Selection.PageSetup
    .LineNumbering.Active = False
    .Orientation = wdOrientPortrait
    .TopMargin = CentimetersToPoints(2.54)
    .BottomMargin = CentimetersToPoints(2.54)
    .LeftMargin = CentimetersToPoints(3.17)
    .RightMargin = CentimetersToPoints(3.17)
    .Gutter = CentimetersToPoints(0)
    .HeaderDistance = CentimetersToPoints(1.5)
    .FooterDistance = CentimetersToPoints(1.75)
    .PageWidth = CentimetersToPoints(29.7)
    .PageHeight = CentimetersToPoints(41.99)
    .FirstPageTray = wdPrinterDefaultBin
    .OtherPagesTray = wdPrinterDefaultBin
    .SectionStart = wdSectionNewPage
    .OddAndEvenPagesHeaderFooter = False
    .DifferentFirstPageHeaderFooter = False
    .VerticalAlignment = wdAlignVerticalTop
    .SuppressEndnotes = False
    .MirrorMargins = False
    .TwoPagesOnOne = False
    .BookFoldPrinting = False
    .BookFoldRevPrinting = False
    .BookFoldPrintingSheets = 1
    .GutterPos = wdGutterPosLeft
    .LinesPage = 44
    .LayoutMode = wdLayoutModeLineGrid
End With

Selection.Font.Name = "����"
Selection.Font.Size = 18
Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
Selection.Font.Bold = True
Selection.TypeText txt0
Selection.MoveDown
Selection.Font.Name = "����"
Selection.Font.Size = 14
Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
Selection.Font.Bold = False
Selection.TypeText txts
Selection.WholeStory
Selection.HomeKey
doc.Save

End Sub

Sub ��ģʽ˵����()
    txt = "����ģʽʹ��˵����" _
    & Chr(13) & "1  ������Ƶ���Ҫ��ʼ�ĵط���ͨ����ȫ�Ŀ�ͷ" _
    & Chr(13) & "2  �����ģʽ����ߵġ�ִ�С�ͼ��" _
    & Chr(13) & "3  ���ϰ���ݼ�F1������ѡ��ÿ������" _
    & Chr(13) & "4  ÿ��ѡ��һ������ʱ���������Ӧ��ʽ" _
    & Chr(13) & "5  �������Ķ��䣬��ʹ�ÿ�ݼ�F2"
    MsgBox txt
End Sub

'=======================================================

'���´����ǲݸ�
Sub test()
'    On Error GoTo msg
'    n = 2 / 1
'    Exit Sub
'msg:
'    MsgBox "���˵����⣬���������  >_<", Title:="Error", buttons:=vbCritical
'MsgBox Selection.Type
'Selection.Expand Unit:=wdParagraph

'CustomizationContext = NormalTemplate
'KeyBindings.Add KeyCode:=BuildKeyCode(wdKeyF1), KeyCategory:=wdKeyCategoryCommand, Command:="Normal.BjfuPaperFormat.��������"
'FindKey(BuildKeyCode(wdKeyF1)).Execute

End Sub







