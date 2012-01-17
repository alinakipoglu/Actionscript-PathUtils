

# Installation

	1 - Install Bin/FlashCurveToPathSequenceExporter.mxp using Adobe Extension Manager (min CS4)

# Exporting a PathSequence

	1 - Open a new document in Flash.
	2 - Draw a path.
	3 - Select path (or a part from it)
	4 - Go to Command Menu and click to FlashCurveToPathSequence.
	5 - Enter Class name.
	6 - Enter Package name (optional, leave it empty if you don't want to specify a package name).
	7 - Select a destination folder to export (some where you put all exported PathSequence sources)
	8 - This will export an ActionScript Class file contains selected path data and ready to use!

# Using Exported PathSequences

	1 - Link your project with Bin/PathUtilsLibrary.swc or Source/src.
	2 - Include Actionscript Class exported with FlashCurveToPathSequence command.
	3 - Instantiate and use getDeltaPosition method to get position every time you want to use this class.
	