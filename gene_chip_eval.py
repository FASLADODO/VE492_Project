# -*- coding: utf-8 -*-

import time
import tensorflow as tf

import gene_chip_inference
import gene_chip_data_parsing
import gene_chip_train

import scipy.io as sio

EVAL_INTERVAL_SECS = 10

def evaluate(gene):
    with tf.Graph().as_default() as g:
        x = tf.placeholder(
            tf.float32, [None, gene_chip_inference.INPUT_NODE], name='x-input'
        )
        y_ = tf.placeholder(
            tf.float32, [None, gene_chip_inference.OUTPUT_NODE], name='y-input'
        )
        validate_feed = {x: gene.validation.data,
                         y_: gene.validation.labels}

        y = gene_chip_inference.inference(x, None)

        correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
        accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

        variable_averages = tf.train.ExponentialMovingAverage(
            gene_chip_train.MOVING_AVERAGE_DECAY
        )
        variables_to_restore = variable_averages.variables_to_restore()
        saver = tf.train.Saver(variables_to_restore)

        while True:
            with tf.Session() as sess:
                ckpt = tf.train.get_checkpoint_state(
                    gene_chip_train.MODEL_SAVE_PATH
                )
                if ckpt and ckpt.model_checkpoint_path:
                    saver.restore(sess, ckpt.model_checkpoint_path)
                    global_step = ckpt.model_checkpoint_path \
                                      .split('/')[-1].split('-')[-1]
                    accuracy_score = sess.run(accuracy,
                                              feed_dict=validate_feed)
                    print("After %s training step(s), validation "
                          "accuracy = %g" % (global_step, accuracy_score))
                else:
                    print('No checkpoint file found')
                    return
                time.sleep(EVAL_INTERVAL_SECS)

def main(argv=None):
    # data_disease_list_bool = sio.loadmat('disease_list_bool_mat.mat')
    # data_disease_list_bool = sio.loadmat('disease_list_bool_mat_random.mat')
    data_disease_list_bool = sio.loadmat('disease_list_bool_mat_random_200.mat')

    # data_gene_chip_reduction = sio.loadmat('gene_chip_reduction.mat')
    # data_gene_chip_reduction = sio.loadmat('gene_chip_reduction_norm.mat')
    # data_gene_chip_reduction = sio.loadmat('gene_chip_reduction_norm_random.mat')
    data_gene_chip_reduction = sio.loadmat('gene_chip_reduction_norm_random_200.mat')

    # disease_list_bool = data_disease_list_bool['disease_list_bool_mat']
    # disease_list_bool = data_disease_list_bool['disease_list_bool_mat_random']
    disease_list_bool = data_disease_list_bool['disease_list_bool_mat_random_200']

    # gene_chip_reduction = data_gene_chip_reduction['gene_chip_reduction']
    # gene_chip_reduction = data_gene_chip_reduction['gene_chip_reduction_norm']
    # gene_chip_reduction = data_gene_chip_reduction['gene_chip_reduction_norm_random']
    gene_chip_reduction = data_gene_chip_reduction['gene_chip_reduction_norm_random_200']

    gene = gene_chip_data_parsing.read_data_sets(gene_chip_reduction, disease_list_bool)

    evaluate(gene)

if __name__ == '__main__':
    tf.app.run()