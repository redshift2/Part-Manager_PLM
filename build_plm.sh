mkdir parts-manager
cd parts-manager
git clone https://github.com/redshift2/Parts_Manager_PLM.git
git clone https://github.com/redshift2/Parts_manager_intranet_module.git
git clone https://github.com/redshift2/PM_module_user_management.git
git clone https://github.com/redshift2/PM_module_workspace.git
git clone https://github.com/redshift2/PM_module_materials.git
cd Parts_manager_intranet_module/app/
ln -s ../../Parts_Manager_PLM plm
ln -s ../../PM_module_user_management crew
ln -s ../../PM_module_workspace workspace
ln -s ../../PM_module_materials materials
cd ..
./gradlew bootJar
cp server/build/libs/server-0.6.jar ../..
cd ..
