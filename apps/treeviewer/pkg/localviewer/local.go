package localviewer

import (
	"os"

	"go.devnw.com/ds/trees/nary"
)

func ReadLocalPath(path string)  (*nary.Tree[string],  error) {
    f, err := os.OpenFile(path, os.O_RDONLY, 0644)
    if err != nil {
        return nil, err
    }

    children, err := getChildrenPaths(f)
    if err != nil {
        return nil, err
    }

    tree := nary.New(f.Name())
    for _, child := range children {
        err = readLocalPathRecursive(path, child, tree.Root())
        if err != nil {
            return nil, err
        }
    }

    return tree, nil
}

func readLocalPathRecursive(parent, path string, node *nary.Node[string]) error {
    f, err := os.OpenFile(parent + "/" + path, os.O_RDONLY, 0644)
    if err != nil {
        return err
    }

    children, err := getChildrenPaths(f)
    if err != nil {
        return err
    }

    tree := nary.New(path)
    for _, child := range children {
        err = readLocalPathRecursive(parent + "/" + path, child, tree.Root())
        if err != nil {
            return err
        }
    }


    node.AddChildren(tree.Root())
    return nil 
}

func getChildrenPaths(file *os.File) ([]string, error) {
    info, err := file.Stat()
    if err != nil {
        return nil, err
    }

    if info.IsDir() {
        children, err := file.Readdirnames(0)
        if err != nil {
            return nil, err
        }

        return children, nil
    }

    return []string{}, nil
}
