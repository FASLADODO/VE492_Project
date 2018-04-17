import tensorflow as tf
import gene_chip_data_parsing
import gene_chip_inference
import os


import scipy.io as sio

BATCH_SIZE = 100
LEARNING_RATE_BASE = 0.8
LEARNING_RATE_DECAY = 0.99
REGULARIZATION_RATE = 0.0001
TRAINING_STEPS = 30000
MOVING_AVERAGE_DECAY = 0.99
MODEL_SAVE_PATH = "gene_model/"
MODEL_NAME = "gene_model"


def train(gene):

    x = tf.placeholder(
        tf.float32, [None, gene_chip_inference.INPUT_NODE], name='x-input'
    )
    y_ = tf.placeholder(
        tf.float32, [None, gene_chip_inference.OUTPUT_NODE], name='y-input'
    )

    regularizer = tf.contrib.layers.l2_regularizer(REGULARIZATION_RATE)
    y = gene_chip_inference.inference(x, regularizer)
    global_step = tf.Variable(0, trainable=False)

    variable_averages = tf.train.ExponentialMovingAverage(
        MOVING_AVERAGE_DECAY, global_step
    )
    variable_averages_op = variable_averages.apply(
        tf.trainable_variables()
    )
    cross_entropy = tf.nn.sparse_softmax_cross_entropy_with_logits(
        logits=y, labels=tf.arg_max(y_, 1)
    )
    cross_entropy_mean = tf.reduce_mean(
        cross_entropy
    )
    loss = cross_entropy_mean + tf.add_n(
        tf.get_collection('losses')
    )
    learning_rate = tf.train.exponential_decay(
        LEARNING_RATE_BASE,
        global_step,
        22283 / BATCH_SIZE, LEARNING_RATE_DECAY,
        staircase=True
    )
    train_step = tf.train.GradientDescentOptimizer(learning_rate).minimize(
        loss, global_step=global_step
    )
    with tf.control_dependencies([train_step, variable_averages_op]):
        train_op = tf.no_op(name='train')

        saver = tf.train.Saver()
        with tf.Session() as sess:
            # sess.run(tf.global_variables_initializer())
            tf.global_variables_initializer().run()
            for i in range(TRAINING_STEPS):
                xs, ys = gene.train.next_batch(BATCH_SIZE)
                _, loss_value, step = sess.run(
                    [train_op, loss, global_step], feed_dict={x: xs, y_: ys}
                )
                if i % 1000 == 0:
                    print("After %d training step(s), loss on training batch is %g." % (step, loss_value))
                    saver.save(
                        sess, os.path.join(MODEL_SAVE_PATH, MODEL_NAME), global_step=global_step
                    )


def main(argv=None):
    data_disease_list_bool = sio.loadmat('disease_list_bool.mat')
    data_gene_chip_reduction = sio.loadmat('gene_chip_reduction.mat')
    disease_list_bool = data_disease_list_bool['disease_list_bool']
    gene_chip_reduction = data_gene_chip_reduction['gene_chip_reduction']
    gene = gene_chip_data_parsing.read_data_sets(gene_chip_reduction, disease_list_bool)
    print("*********************")
    print(gene.train.data.dtype)
    train(gene)


if __name__ == '__main__':
    tf.app.run()
