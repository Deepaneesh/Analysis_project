# Cleaning the Environment ==============================================================
%reset -sf
%whos     # Checking the Environment

# Set constants ==========================================================================

from scripts.constant import *

# Loading the functions in python 
from scripts.function import *

# Creating the projects folders ==========================================================

create_project_folders(dirs= ('input',
                               f'input/{edition}',
                               f'input/{edition}/Labour_force',
                               f'input/{edition}/employed',
                               f'input/{edition}/unemployed',
                               'output',
                               'scripts',
                               'plot'))

# Downloading the data from the world bank

if download_data:
    from scripts.data_download import wb_data_download

    wb_data_download(start_year=start_year,
                     end_year=end_year,
                     edition=edition)
