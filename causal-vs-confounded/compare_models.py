# Authors: Sebastian Pölsterl
# The code is under the Artistic License 2.0.
# If using this code, make sure you agree and accept this license.

from os import get_exec_path
from os.path import abspath, dirname, exists, join
import subprocess
import tempfile
import h5py
import pandas as pd
from sklearn.preprocessing import StandardScaler


def _find_rscript():
    path_dirs = get_exec_path()
    for adir in path_dirs:
        path = join(adir, "Rscript")
        if exists(path):
            return path
    raise RuntimeError("Rscript executable was not found.")


_R_PATH = _find_rscript()
_SCRIPT_PATH = join(abspath(dirname(__file__)), "compare_models.R")


def compare_models(X, Y, DZ, normalize=True):
    """Runs both both the X -> Y and X <- Z -> Y models on the data and returns the scores obtained for both."""

    if normalize:
        X = StandardScaler().fit(X).transform(X)
        Y = Y.reshape(-1, 1)
        Y = StandardScaler().fit(Y).transform(Y)

    with tempfile.TemporaryDirectory() as tempdir:
        XY_path = join(tempdir, "DATA.h5")
        with h5py.File(XY_path, mode="w") as f:
            g = f.create_group("data")
            g.create_dataset("X", data=X)
            g.create_dataset("Y", data=Y)

        result_path = join(tempdir, "result.csv")
        subprocess.check_call(
            [_R_PATH, _SCRIPT_PATH, str(DZ), XY_path, result_path],
            cwd=dirname(_SCRIPT_PATH),
        )

        results = pd.read_csv(result_path, index_col=0).rename_axis("iter", axis=0).reset_index()

    return results
