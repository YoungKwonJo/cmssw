#! /bin/bash

export here=$PWD
export reportFile=TrackerGeometryValidation.log

cd $here
echo "Working area:" $here | tee $reportFile
eval `scramv1 runtime -sh`

export referenceDir=/afs/cern.ch/cms/data/CMSSW/Validation/Geometry/reference/Tracker
echo "Reference area:" $referenceDir | tee -a $reportFile

# Create Images/ directory if it does not exist
if [ ! -d Images ]; then
    echo "Creating directory Images/" | tee -a $reportFile
    mkdir Images
    echo "...done" | tee -a $reportFile
fi
#

# Download the source file
if [ ! -e single_neutrino.random.dat ]; then
    echo "Download the Monte Carlo source file..." | tee -a $reportFile
    wget `cat $CMSSW_RELEASE_BASE/src/Validation/Geometry/data/download.url`
    echo "...done" | tee -a $reportFile
fi
#

# Download the reference files and rename them to 'old'
echo "Download the reference 'old' files..." | tee -a $reportFile
cp $referenceDir/matbdg_TkStrct.root     matbdg_TkStrct_old.root 
cp $referenceDir/matbdg_PixBar.root      matbdg_PixBar_old.root 
cp $referenceDir/matbdg_PixFwdPlus.root  matbdg_PixFwdPlus_old.root 
cp $referenceDir/matbdg_PixFwdMinus.root matbdg_PixFwdMinus_old.root 
cp $referenceDir/matbdg_TIB.root         matbdg_TIB_old.root 
cp $referenceDir/matbdg_TIDF.root        matbdg_TIDF_old.root 
cp $referenceDir/matbdg_TIDB.root        matbdg_TIDB_old.root 
cp $referenceDir/matbdg_TOB.root         matbdg_TOB_old.root 
cp $referenceDir/matbdg_TEC.root         matbdg_TEC_old.root 
cp $referenceDir/matbdg_Tracker.root     matbdg_Tracker_old.root 
cp $referenceDir/matbdg_BeamPipe.root    matbdg_BeamPipe_old.root 
echo "...done" | tee -a $reportFile
#

# Run all the Tracker scripts and rename files as 'new'
echo "Run all the scripts to produce the 'new' files..." | tee -a $reportFile
#
echo "Running Tracker Structure..." | tee -a $reportFile
rm -rf TkStrct.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_TkStrct.cfg     > TkStrct.txt
echo "...done" | tee -a $reportFile
echo "Running Pixel Barrel..." | tee -a $reportFile
rm -rf PixBar.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_PixBar.cfg      > PixBar.txt
echo "...done" | tee -a $reportFile
echo "Running Pixel Forward Plus..." | tee -a $reportFile
rm -rf PixFwdPlus.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_PixFwdPlus.cfg  > PixFwdPlus.txt
echo "...done" | tee -a $reportFile
echo "Running Pixel Forward Minus..." | tee -a $reportFile
rm -rf  PixFwdMinus.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_PixFwdMinus.cfg > PixFwdMinus.txt
echo "...done" | tee -a $reportFile
echo "Running TIB..." | tee -a $reportFile
rm -rf TIB.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_TIB.cfg         > TIB.txt
echo "...done" | tee -a $reportFile
echo "Running TID+..." | tee -a $reportFile
rm -rf TIDF.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_TIDF.cfg        > TIDF.txt
echo "...done" | tee -a $reportFile
echo "Running TID-..." | tee -a $reportFile
rm -rf TIDB.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_TIDB.cfg        > TIDB.txt
echo "...done" | tee -a $reportFile
echo "Running TOB..." | tee -a $reportFile
rm -rf TOB.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_TOB.cfg         > TOB.txt
echo "...done" | tee -a $reportFile
echo "Running TEC..." | tee -a $reportFile
rm -rf TEC.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_TEC.cfg         > TEC.txt
echo "...done" | tee -a $reportFile
echo "Running Tracker..." | tee -a $reportFile
rm -rf Tracker.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_Tracker.cfg     > Tracker.txt
echo "...done" | tee -a $reportFile
echo "Running BeamPipe..." | tee -a $reportFile
rm -rf BeamPipe.txt
cmsRun $CMSSW_RELEASE_BASE/src/Validation/Geometry/test/runP_BeamPipe.cfg    > BeamPipe.txt
#
cp matbdg_TkStrct.root     matbdg_TkStrct_new.root 
cp matbdg_PixBar.root      matbdg_PixBar_new.root 
cp matbdg_PixFwdPlus.root  matbdg_PixFwdPlus_new.root 
cp matbdg_PixFwdMinus.root matbdg_PixFwdMinus_new.root 
cp matbdg_TIB.root         matbdg_TIB_new.root 
cp matbdg_TIDF.root        matbdg_TIDF_new.root 
cp matbdg_TIDB.root        matbdg_TIDB_new.root 
cp matbdg_TOB.root         matbdg_TOB_new.root 
cp matbdg_TEC.root         matbdg_TEC_new.root 
cp matbdg_Tracker.root     matbdg_Tracker_new.root 
cp matbdg_BeamPipe.root    matbdg_BeamPipe_new.root 
echo "...done" | tee -a $reportFile
#

# Produce the 'new' plots
echo "Run the Tracker macro MaterialBudget.C to produce the 'new' plots..." | tee -a $reportFile
root -b -q 'MaterialBudget.C("PixBar")'
root -b -q 'MaterialBudget.C("PixFwdPlus")'
root -b -q 'MaterialBudget.C("PixFwdMinus")'
root -b -q 'MaterialBudget.C("TIB")'
root -b -q 'MaterialBudget.C("TIDF")'
root -b -q 'MaterialBudget.C("TIDB")'
root -b -q 'MaterialBudget.C("TOB")'
root -b -q 'MaterialBudget.C("TEC")'
root -b -q 'MaterialBudget.C("TkStrct")'
root -b -q 'MaterialBudget.C("Tracker")'
root -b -q 'MaterialBudget.C("TrackerSum")'
root -b -q 'MaterialBudget.C("Pixel")'
root -b -q 'MaterialBudget.C("Strip")'
root -b -q 'MaterialBudget_TDR.C()'
echo "...done" | tee -a $reportFile
#

# Compare 'old' and 'new' plots
echo "Run the Tracker macro TrackerMaterialBudgetComparison.C to compare 'old and 'new' plots..." | tee -a $reportFile
root -b -q 'TrackerMaterialBudgetComparison.C("PixBar")'
root -b -q 'TrackerMaterialBudgetComparison.C("PixFwdPlus")'
root -b -q 'TrackerMaterialBudgetComparison.C("PixFwdMinus")'
root -b -q 'TrackerMaterialBudgetComparison.C("TIB")'
root -b -q 'TrackerMaterialBudgetComparison.C("TIDF")'
root -b -q 'TrackerMaterialBudgetComparison.C("TIDB")'
root -b -q 'TrackerMaterialBudgetComparison.C("TOB")'
root -b -q 'TrackerMaterialBudgetComparison.C("TEC")'
root -b -q 'TrackerMaterialBudgetComparison.C("TkStrct")'
root -b -q 'TrackerMaterialBudgetComparison.C("Tracker")'
root -b -q 'TrackerMaterialBudgetComparison.C("TrackerSum")'
root -b -q 'TrackerMaterialBudgetComparison.C("Pixel")'
root -b -q 'TrackerMaterialBudgetComparison.C("Strip")'
echo "...done" | tee -a $reportFile
#

# Run the Tracker ModuleInfo analyzer (to compare position/orientation of Tracker Modules)
echo "Run the Tracker ModuleInfo analyzer to print Tracker Module info (position/orientation)..." | tee -a $reportFile
cmsRun $CMSSW_RELEASE_BASE/src/Geometry/TrackerGeometryBuilder/test/trackerModuleInfo.cfg
echo "...done" | tee -a $reportFile
#

# Compare the ModuleInfo.log file with the reference one
echo "Compare the ModuleInfo.log (Tracker Module position/orientation) file with the reference one..." | tee -a $reportFile
if [ -e diff_info.temp ]; then
    rm -rf diff_info.temp
fi
#
diff ModuleInfo.log $referenceDir/ModuleInfo.log > diff_info.temp
if [ -s diff_info.temp ]; then
    echo "WARNING: the module position/orientation is changed, check diff_info.temp file for details" | tee -a $reportFile
else
    echo "Tracker Module position/orientation OK" | tee -a $reportFile
fi
echo "...done" | tee -a $reportFile
#

# Run the Module Numbering (only Microstrip) check algorithm and print the tail
echo "Run the Tracker ModuleNumbering analyzer to print Tracker Numbering check..." | tee -a $reportFile
cmsRun $CMSSW_RELEASE_BASE/src/Geometry/TrackerNumberingBuilder/test/trackerModuleNumbering.cfg
echo "TRACKER MICROSTRIP NUMBERING... LOOK AT THE RESULTS" | tee -a $reportFile
tail -7 ModuleNumbering.log | tee -a $reportFile
if [ -e num.log ]; then
    rm -rf num.log
fi
tail -7 ModuleNumbering.log > num.log
echo "...done" | tee -a $reportFile
#

# Compare the ModuleNumbering.dat file with the reference one
echo "Compare the ModuleNumbering.dat (Tracker Module position/orientation) file with the reference one..." | tee -a $reportFile
if [ -e diff_num.temp ]; then
    rm -rf diff_num.temp
fi
#
diff ModuleNumbering.dat $referenceDir/ModuleNumbering.dat > diff_num.temp
if [ -s diff_num.temp ]; then
    echo "WARNING: the module numbering is changed, check diff_num.temp file for details" | tee -a $reportFile
else
    echo "Tracker Module numbering OK" | tee -a $reportFile
fi
echo "...done" | tee -a $reportFile
#

# Compare the TrackerNumberingComparison.C, to compare the ModuleNumbering.dat file with the reference, element-by-element mapping both files 
echo "Run the TrackerNumberingComparison.C macro" | tee -a $reportFile
cp $referenceDir/ModuleNumbering.dat ModuleNumbering_reference.dat
root -b -q 'TrackerNumberingComparison.C("ModuleNumbering.dat","ModuleNumbering_reference.dat","NumberingInfo.log")'
if [ -s NumberingInfo.log ]; then
    echo "ERROR: a failure in the numbering scheme, see NumberingInfo.log" | tee -a $reportFile
else
    echo "Tracker Numbering Scheme OK" | tee -a $reportFile
fi
echo "...done" | tee -a $reportFile
#

# New test: Check Overlap
echo "Run the Tracker Check Overlap test" | tee -a $reportFile
if [ -e trackerOverlap.log ]; then
    rm -rf trackerOverlap.log
fi
cmsRun $CMSSW_RELEASE_BASE/src/Validation/CheckOverlap/test/data/runTracker.cfg > trackerOverlap.log
grep -A4 'WARNING - ' trackerOverlap.log | tee -a $reportFile
echo "...done" | tee -a $reportFile
#

echo "TRACKER GEOMETRY VALIDATION ENDED... LOOK AT THE RESULTS" | tee -a $reportFile
