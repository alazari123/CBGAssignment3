%Part 1 Start
idArray = [""];
nameArray = [""];
spaceArray = [""];
relationshipArray = [""];
GOFile = fopen("CBGGO.txt");
i = 1;
goGraph = digraph;
while ~feof(GOFile)
   currLine = fgetl(GOFile);
   if currLine == "[Term]"
      idString = fgetl(GOFile);
      %following link used for function fget1
      %https://www.mathworks.com/help/matlab/ref/fgets.html
      justID = extractAfter(idString, "id: ");
      %following link used for extracting needed data
      %https://www.mathworks.com/help/stateflow/ref/
      %extractafter.html#mw_45ffdabd-7a4c-46bb-a575-23af8a630215
      justIDStr = convertCharsToStrings(justID);
      %following linked used for char to str function
      %https://www.mathworks.com/help/matlab/ref/convertcharstostrings.html
      idArray(end + 1) = justIDStr;
      %following link used for adding elements to end of array
      %https://www.mathworks.com/matlabcentral/answers/283821-
      %add-single-element-to-array-or-vector
      nameString = fgetl(GOFile);
      justName = extractAfter(nameString, "name: ");
      justNameStr = convertCharsToStrings(justName);
      nameArray(end + 1) = justNameStr;
      spaceString = fgetl(GOFile);
      justSpace = extractAfter(spaceString, "namespace: ");
      justSpaceStr = convertCharsToStrings(justSpace);
      spaceArray(end + 1) = justSpaceStr;
      goGraph = addnode(goGraph, idArray(1, end));
   end
   checkRelationship = extractBefore(currLine, ":");
   if checkRelationship == "is_a"
      justRelationship = extractAfter(currLine, "is_a: ");
      justRelationshipStr = convertCharsToStrings(justRelationship);
      relationshipArray(end + 1) = justRelationshipStr;
      %goGraph = addnode(goGraph, relationshipArray(1, end));
      goGraph = addedge(goGraph,idArray(1, end),relationshipArray(1, end));
   end
   if checkRelationship == "relationship"
      justRelationship = extractAfter(currLine, "relationship: part_of ");
      justRelationshipStr = convertCharsToStrings(justRelationship);
      relationshipArray(end + 1) = justRelationshipStr;
      %goGraph = addnode(goGraph, relationshipArray(1, end));
      goGraph = addedge(goGraph,idArray(1, end),relationshipArray(1, end));
   end
   %following code removes empty string from start of array
   %and does it early for time management purposes
   %adapted from following link
   %https://www.mathworks.com/matlabcentral/answers/
   %289860-remove-first-element-of-array-and-add-element-to-the-end-fifo-array
   if i == 1
       idArray = idArray(2:end);
       nameArray = nameArray(2:end);
       spaceArray = spaceArray(2:end);
       relationshipArray = relationshipArray(2:end);
       i = 2;
   end
end
%Part 1 end

