import onnx

model_path = './model/janken.onnx'


def main():
    # ONNX形式のモデルを読み込む
    model = onnx.load(model_path)

    # モデル（グラフ）を構成するノードを全て出力する
    print("====== Nodes ======")
    for i, node in enumerate(model.graph.node):
        print("[Node #{}]".format(i))
        print(node)

    # モデルの入力データ一覧を出力する
    print("====== Inputs ======")
    for i, input in enumerate(model.graph.input):
        print("[Input #{}]".format(i))
        print(input)

    # モデルの出力データ一覧を出力する
    print("====== Outputs ======")
    for i, output in enumerate(model.graph.output):
        print("[Output #{}]".format(i))
        print(output)


if __name__ == "__main__":
    main()
