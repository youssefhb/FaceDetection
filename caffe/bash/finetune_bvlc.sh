#../../caffe/build/tools/caffe train --solver=feret_quick_solver.prototxt --snapshot=feret_quick_iter_6000.solverstate
#../../caffe/build/tools/caffe train --solver=feret_quick_solver.prototxt


#../../caffe/build/tools/caffe train --solver=Feret_train_val.prototxt  -weights  ../../caffe/models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel


#../../caffe/build/tools/caffe train -solver solver-finetune.prototxt  -weights ../../caffe/models/bvlc_alexnet/bvlc_alexnet.caffemodel   --snapshot=FineTuneFeret_iter_10000.solverstate

../../caffe/build/tools/caffe train -solver solver-finetune.prototxt   --snapshot=FineTuneFeret_iter_10000.solverstate

