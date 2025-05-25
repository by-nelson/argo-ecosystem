package main

import (
	"fmt"
	"log/slog"
	"os"

	"github.com/by-nelson/argo-ecosystem/apps/treeviewer/pkg/localviewer"
	"github.com/jedib0t/go-pretty/v6/list"
	"github.com/spf13/cobra"
	"go.devnw.com/ds/trees/nary"
)

type Options struct {
    Path string
}

var opts Options

var rootCmd = &cobra.Command{
    Use:   "treeviewer",
    Short: "Treeviewer allows getting a tree view of a directory",
    RunE: func(cmd *cobra.Command, args []string) error {
        tree, err := localviewer.ReadLocalPath(opts.Path)
        if err != nil {
            return err
        }
        
        print(tree)
        return nil
    },
}

func Execute() {
    rootCmd.Flags().StringVar(&opts.Path, "path", ".", "path to use for visual tree generation")

    if err := rootCmd.Execute(); err != nil {
        slog.Error("Failed to run command", slog.Any("error", err))
        os.Exit(1)
    }
}

func main() {
    Execute()
}

func print(tree *nary.Tree[string]) {
    writer := list.NewWriter() 
    writer.SetStyle(list.StyleConnectedRounded)
    printRecursive(writer, tree.Root())
    fmt.Println(writer.Render())
}

func printRecursive(writer list.Writer, node *nary.Node[string]) {
    writer.AppendItem(node.Value())
    writer.Indent()
    for _, n := range node.Children() {
        printRecursive(writer, n)  
    }
    writer.UnIndent()
}
