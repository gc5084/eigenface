function [ features ] = extractFeaturesFromData( data , featureType )

    switch featureType
        case 'grayscale'
            features = reshape(data,size(data,1),128*128);
            
        case 'lips'
        rowIdx = 70;
        columnIdx = 35; % row, column
        height = 35;
        width = 60; % heigh, width
        features = extractFeature(data, rowIdx, columnIdx, width, height);
        
        case 'eyes'
            % pixel location
            rowIdx = 1;
            columnIdx = 10;
            height = 35;
            width = 110;
            features = extractFeature(data, rowIdx, columnIdx, width, height);
    
        case 'landmark'
            features = reshape(data,size(data,1),68*2);
    
    end
end