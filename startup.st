StartupPreferencesLoader default executeAtomicItems:
  {
    (StartupAction
      name: 'Set author name'
      code: [ | properties|
        properties := FileStream
          readOnlyFileNamed: 'user-properties'
          do: [:file | STONJSON fromString: file contentsOfEntireFile ].

        Author fullName: (properties at: #author) ]
      runOnce: true).

    (StartupAction
      name: 'Setup fonts'
      code: [
        StandardFonts
          defaultFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 8) forceNotBold.
          GraphicFontSettings resetAllFontToDefault.
          StandardFonts windowTitleFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 9) forceBold.
          StandardFonts codeFont: (LogicalFont familyName: 'Source Code Pro' pointSize: 8) ]
      runOnce: true).

    (StartupAction
      name: 'Set up UI theme'
      code: [ Pharo3Theme beCurrent ]
      runOnce: true).

    (StartupAction
      name: 'Setup syntax highlighting style'
      code: [ SHPreferences setStyleTableNamed: 'Solarized' ]
      runOnce: true).

    (StartupAction
      name: 'Debugger options'
      code: [ Smalltalk tools debugger alwaysOpenFullDebugger: true ]
      runOnce: true).

    (StartupAction
      name: 'Code formatting options'
      code: [
        BIConfigurableFormatter
          newLinesAfterTemporaries: 2;
          newLinesAfterMethodPattern: 2;
          retainBlankLinesBetweenStatements: true;
          newLineBeforeFirstCascade: false;
          newLineBeforeFirstCascade: true;
          yourself ]
      runOnce: true).

    (StartupAction
      name: 'Upgrade FPS to 60'
      code: [ WorldState MinCycleLapse: 16 ]
      runOnce: true).

    (StartupAction
      name: 'Show any startup action errors'
      code: [
        StartupPreferencesLoader default errors
          ifNotEmpty: [ :errors | errors explore ] ]
      runOnce: true).

  }