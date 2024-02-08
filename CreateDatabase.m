
dataBase=cell(5,1);

for i=1:5
  dataBase{i}=imread(['Images/Database/' int2str(i) '.jpg ']);
end

save dataBase dataBase

