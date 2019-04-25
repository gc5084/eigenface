function [ imagesData shapeData, map] = LoadImages( databaseDirectory )
%LoadImages Given the directory of the database. 
%This function read all the emotions in the database and return 2 variables.
%imagesData: contains a Nx128x128 with the N images of the database
%shapeData: contains a Nx68x2 with the N shapes of the database

fStart = 0; %7
fEnd = 7;

    %compute the total number of images in the DB
    totalNumberImages = 0;
    for cnt = fStart:fEnd
        pathEmotion = [databaseDirectory '/' num2str(cnt)]; 
        files = ListFiles(pathEmotion);
        totalNumberImages = totalNumberImages + numel(files);
    end
    
    % For better performance, assign number of array before using.
    imagesData = zeros(totalNumberImages,128,128);
    shapeData = zeros(totalNumberImages,68,2);

    %Iterate over all the emotions' folders to list all files' objects.
    numberImage = 1;
    for cnt = fStart:fEnd
        pathImage = [databaseDirectory '/' num2str(cnt)];    
        %List the images files
        files = ListFiles(pathImage);
        for i = 1:numel(files)
            [path name extenstion] = fileparts(files(i).name); 
            pathFile = [pathImage '/' name ];
            %fprintf("Reading file %s\n", pathFile);
            %read image file
            image = imread([pathFile '.tiff']);
            %read shape file
            shape = dlmread([pathFile '.txt']);
            %store grayscale image
            imagesData(numberImage,:,:) = image;
            %store shape
            shapeData(numberImage,:,:) = shape;            
            numberImage = numberImage + 1;
        end
        
    end
    fprintf("End of reading image files (%0f) images \n", totalNumberImages);
end

