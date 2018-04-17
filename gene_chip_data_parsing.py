import collections

from tensorflow.contrib.learn.python.learn.datasets import base
# from tensorflow.python.framework import dtype
from tensorflow.python.framework import random_seed
# from tensorflow.python.util.deprecation import deprecated

from tensorflow.python.framework import dtypes
# from tensorflow.python.framework import random_seed
# from tensorflow.python.framework import gfile
# from tensorflow.python.util.deprecation import deprecated

import numpy

class DataSet(object):

    def __init__(self,
                 data,
                 labels,
                 dtype=dtypes.float32,
                 reshape=True,
                 seed=None):
        seed1, seed2 = random_seed.get_seed(seed)
        numpy.random.seed(seed1 if seed is None else seed2)
        dtype = dtypes.as_dtype(dtype).base_dtype
        if dtype not in (dtypes.uint8, dtypes.float32):
            raise TypeError(
                'Invalide dtype %r, expected unit8 or float32' % dtype
            )
        else:
            self._num_examples = data.shape[0]
            if dtype == dtypes.float32:
                data = data.astype(numpy.float32)

        self._data = data
        self._labels = labels
        self._epochs_completed = 0
        self._index_in_epoch = 0

    @property
    def data(self):
        return self._data

    @property
    def labels(self):
        return self._labels

    @property
    def num_examples(self):
        return self._num_examples

    @property
    def epoches_completed(self):
        return self._epochs_completed

    def next_batch(self, batch_size, shuffle=True):
        start = self._index_in_epoch
        if self._epochs_completed == 0 and start == 0 and shuffle:
            perm0 = numpy.arange(self._num_examples)
            numpy.random.shuffle(perm0)
            self._data = self.data[perm0]
            self._labels = self.labels[perm0]

        if start+batch_size > self._num_examples:
            self._epochs_completed += 1

            rest_num_examples = self._num_examples - start
            data_rest_part = self._data[start:self._num_examples]
            labels_rest_part = self._labels[start:self._num_examples]

            if shuffle:
                perm = numpy.arange(self._num_examples)
                numpy.random.shuffle(perm)
                self._data = self.data[perm]
                self._labels = self.labels[perm]

            start = 0
            self._index_in_epoch = batch_size - rest_num_examples
            end = self._index_in_epoch
            data_new_part = self._data[start:end]
            labels_new_part = self._labels[start:end]
            return numpy.concatenate((data_rest_part, data_new_part), axis=0), numpy.concatenate(
                (labels_rest_part, labels_new_part), axis=0)

        else:
            self._index_in_epoch += batch_size
            end = self._index_in_epoch
            return self._data[start:end], self._labels[start:end]

def read_data_sets(gene_chip_reduction,
                   disease_list_bool,
                   dtype=dtypes.float32,
                   reshape=True,
                   validation_size=300,
                   test_size=5000,
                   seed=None):
    # if fake_data:
    #
    #     def fake():
    #         return Dataset(
    #             [], [], fake_data=True, one_hot=one_hot, dtype=dtype, seed=seed
    #         )
    #     train = fake()
    #     validation = fake()
    #     test = fake()
    #     return base.Datasets(train=train, validation=validation, test=test)

    validation_data=gene_chip_reduction[:validation_size]
    validation_labels=disease_list_bool[:validation_size]

    train_data=gene_chip_reduction[validation_size:test_size]
    train_labels=disease_list_bool[validation_size:test_size]

    test_data=gene_chip_reduction[test_size:]
    test_labels=disease_list_bool[test_size:]

    options = dict(dtype=dtype, reshape=reshape, seed=seed)

    train = DataSet(train_data, train_labels, **options)
    validation = DataSet(validation_data, validation_labels, **options)
    test = DataSet(test_data, test_labels, **options)

    return base.Datasets(train=train, validation=validation, test=test)