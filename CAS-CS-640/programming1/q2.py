## Nonlinear Data
# 1. Confusion matrix
# 2. Precision
# 3. Recall
# 4. F-1 Score
# 5. Accuracy
# 6. Decision boundary decision boundary

from nnet import *
import matplotlib.pyplot as plt
import numpy as np
import matplotlib

# load the dataset
X = np.genfromtxt('data/dataset1/NonlinearX.csv', delimiter=",")
y = np.genfromtxt('data/dataset1/NonlinearY.csv', delimiter=',')
y = y.astype(int)

def visualize(X, y, model):
    plt.scatter(X[:, 0], X[:, 1], c=y, cmap=plt.cm.Spectral)
    plt.show()
    plot_decision_boundary(lambda x:predict(model, x), X, y)
    plt.title("Linear Dataset")

def evaluateResults(y, yhat):

    all_positives       = y == 1
    all_negatives       = y == 0
    true_positives      = 0
    false_positives     = 0
    true_negatives      = 0
    false_negatives     = 0

    for ii in range(0, len(X)):
        if y[ii] == 1 and yhat[ii] == 1:
            true_positives += 1
        if y[ii] == 1 and yhat[ii] == 0:
            false_negatives += 1
        if y[ii] == 0 and yhat[ii] == 0:
            true_negatives += 1
        if y[ii] == 0 and yhat[ii] == 1:
            false_positives += 1

    precision = true_positives / (true_positives + false_positives)
    recall = true_positives / sum(all_positives)
    F1 = 2 * true_negatives / (2 * true_positives + false_positives + false_negatives)
    accuracy = (true_positives + true_negatives) / (sum(all_positives) + sum(all_negatives))

    print("-----------------")
    print("true positives: ", true_positives)
    print("true negatives: ", true_negatives)
    print("false positives: ", false_positives)
    print("false negatives: ", false_negatives)
    print("precision: ", precision)
    print("recall: ", recall)
    print("F-1 score: ", F1)
    print("accuracy: ", accuracy)
    print(" ")

config = Config()
config.nn_input_dim = 2  # input layer dimensionality
config.nn_output_dim = 2  # output layer dimensionality
config.epsilon = 0.01  # learning rate for gradient descent
config.reg_lambda = 0.01  # regularization strength

# ## Varying number of neurons
# nNodes = [1, 3, 10, 30, 100]
#
# for node_num in nNodes:
#     model = build_model(X, y, config, node_num, num_passes=20000, print_loss=False)
#     # visualize(X, y, model)
#     yhat = predict(model, X)
#     print("Number of Neurons: ", node_num)
#     evaluateResults(y, yhat)
#
## Varying the regularization coefficient
reg_lambda = [0.001, 0.003, 0.01, 0.03, 0.1]

for reg_coeff in reg_lambda:
    config.reg_lambda = reg_coeff
    model = build_model(X, y, config, 10, num_passes=20000, print_loss=False)
    # visualize(X, y, model)
    yhat = predict(model, X)
    print("Regularization Coefficient: ", reg_coeff)
    evaluateResults(y, yhat)

# ## Varying the learning rate
# config.reg_lambda = 0.01
# learning_rate = [0.001, 0.003, 0.01, 0.03, 0.1]
#
# for lrate in learning_rate:
#     config.epsilon = lrate
#     model = build_model(X, y, config, 10, num_passes=20000, print_loss=False)
#     # visualize(X, y, model)
#     yhat = predict(model, X)
#     print("Learning Rate: ", lrate)
#     evaluateResults(y, yhat)
#
# ## Varying the number of epochs
# config.learning_rate = 0.01
# num_epochs = [100, 200, 2000, 10000, 20000]
#
# for ii in num_epochs:
#     model = build_model(X, y, config, 10, num_passes=ii, print_loss=False)
#     # visualize(X, y, model)
#     yhat = predict(model, X)
#     print("Number of Epochs: ", ii)
#     evaluateResults(y, yhat)

## visualize the conditions

# # number of neurons
# model = build_model(X, y, config, 10, num_passes=20000, print_loss=False)
# yhat = predict(model, X)
# visualize(X, y, model)
#
# # regularization coefficient
# config = Config()
# config.nn_input_dim = 2  # input layer dimensionality
# config.nn_output_dim = 2  # output layer dimensionality
# config.epsilon = 0.01  # learning rate for gradient descent
# config.reg_lambda = 0.001  # regularization strength
#
# model = build_model(X, y, config, 10, num_passes=20000, print_loss=False)
# yhat = predict(model, X)
# visualize(X, y, model)

# # learning rate
# config = Config()
# config.nn_input_dim = 2  # input layer dimensionality
# config.nn_output_dim = 2  # output layer dimensionality
# config.epsilon = 0.001  # learning rate for gradient descent
# config.reg_lambda = 0.01  # regularization strength
#
# model = build_model(X, y, config, 10, num_passes=20000, print_loss=False)
# yhat = predict(model, X)
# visualize(X, y, model)
#
# # epoches
# config = Config()
# config.nn_input_dim = 2  # input layer dimensionality
# config.nn_output_dim = 2  # output layer dimensionality
# config.epsilon = 0.001  # learning rate for gradient descent
# config.reg_lambda = 0.01  # regularization strength
#
# model = build_model(X, y, config, 10, num_passes=100, print_loss=False)
# yhat = predict(model, X)
# visualize(X, y, model)
