/*
 * Copyright (c) 2016-2019, NVIDIA CORPORATION. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *  * Neither the name of NVIDIA CORPORATION nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <algorithm>
#include <fstream>
#include <iostream>
#include <string>
#include <cstring>
#include <math.h>

#include "nvdla/IType.h"

#include "priv/Check.h"
#include "priv/EngineAST.h"
#include "priv/Layer.h"
#include "priv/Network.h"
#include "priv/Profile.h"
#include "priv/TargetConfig.h"
#include "ErrorMacros.h"



using std::map;
using std::vector;
using std::set;
using std::unordered_set;
using std::string;
using std::endl;
using std::ostream;
using std::stringstream;

namespace nvdla
{
namespace priv
{

ENUM_PARAMETER_STATIC(engine_ast::EngineType,         ENGINE_AST_ENGINE_TYPE_ENUMS,          "EngineASTEngineTypeEnum")
ENUM_PARAMETER_STATIC(engine_ast::EngineOpType,       ENGINE_AST_ENGINE_OP_TYPE_ENUMS,       "EngineASTEngineOpTypeEnum")
ENUM_PARAMETER_STATIC(engine_ast::EdgeType,           ENGINE_AST_EDGE_TYPE_ENUMS,            "EngineASTEdgeTypeEnum")
ENUM_PARAMETER_STATIC(engine_ast::IODirection,        ENGINE_AST_IO_DIRECTION_ENUMS,         "EngineASTIODirectionEnum")
ENUM_PARAMETER_STATIC(engine_ast::OperationEventType, ENGINE_AST_OPERATION_EVENT_TYPE_ENUMS, "EngineASTOperationEventTypeEnum")

ENUM_PARAMETER_STATIC(engine_ast::ConcatAxis,      ENGINE_AST_CONCAT_AXIS_ENUMS,       "ConcatAxisEnum")
ENUM_PARAMETER_STATIC(engine_ast::SplitAxis,       ENGINE_AST_SPLIT_AXIS_ENUMS,        "SplitAxisEnum")
ENUM_PARAMETER_STATIC(engine_ast::ConvolutionMode, ENGINE_AST_CONVOLUTION_MODE_ENUMS,  "ConvolutionModeEnum")
ENUM_PARAMETER_STATIC(engine_ast::SDPMode,         ENGINE_AST_SDP_MODE_ENUMS,          "SDPModeEnum")
ENUM_PARAMETER_STATIC(engine_ast::SDPOpType,       ENGINE_AST_SDP_OP_TYPE_ENUMS,       "SDPOpTypeEnum")
ENUM_PARAMETER_STATIC(engine_ast::SDPActType,      ENGINE_AST_SDP_ACT_TYPE_ENUMS,      "SDPActTypeEnum")
ENUM_PARAMETER_STATIC(engine_ast::SDPALUType,      ENGINE_AST_SDP_ALU_TYPE_ENUMS,      "SDPALUTypeEnum")
ENUM_PARAMETER_STATIC(engine_ast::RubikMode,       ENGINE_AST_RUBIK_MODE_ENUMS,        "RubikModeEnum")

// Initialize static memory collector
engine_ast::MemoryCollector* engine_ast::MemoryCollector::collector = NULL;

NvU32 engine_ast::Node::m_next_id = 0;
NvU32 engine_ast::Edge::m_next_id = 0;

#if 0
//
// though this is templated, it's harder to introduce attributes
// into the dump which aren't built into the base classes being
// used (class N, E here).  e.g.: 'id' isn't required for a node or
// edge class, even though it's referenced here.  the visitor
// scheme allows a more informative dump because point-of-use information
// can be added (it can call methods which are not common to the templated
// dump version).
//
template<class N, class E>
NvDlaError Graph<N, E>::dumpGraphML(string filename, string id)
{
    ofstream ofs = ofstream(filename, ofstream::out);

    ofs << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" << endl;
    ofs << "<graphml xmlns=\"http://graphml.graphdrawing.org/xmlns\"" << endl;
    ofs << "    xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"" << endl;
    ofs << "    xsi:schemaLocation=\"http://graphml.graphdrawing.org/xmlns" << endl;
    ofs << "     http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd\">" << endl;
    ofs << "  <graph id=\"" << id << "\" edgedefault=\"directed\">" << endl;

    for (NodeSetIterator it=nodes().begin(); it!=nodes().end(); it++)
    {
        if (*it == NULL)
            continue;

        ofs << "<node id=\"" << (*it)->id() << "\"/>" << endl;
    }

    for (EdgeSetIterator it=edges().begin(); it!=edges().end(); it++)
    {
        if (*it == NULL)
            continue;

        EdgeAttr* edgeAttr = lookupEdgeAttr(*it);
        NodeSequence nodeSeq0 = edgeAttr->m_nodes[0];
        NodeSequence nodeSeq1 = edgeAttr->m_nodes[1];

        for (NodeSequenceIterator it0=nodeSeq0.begin(); it0!=nodeSeq0.end(); it0++)
        {
            for (NodeSequenceIterator it1=nodeSeq1.begin(); it1!=nodeSeq1.end(); it1++)
            {
                ofs << "<edge source=\"" << (*it0)->id() << "\" target=\"" << (*it1)->id() << "\"/>" << endl;
            }
        }
    }

    ofs << "  </graph>" << endl;
    ofs << "</graphml>" << endl;

    ofs.close();

    return NvDlaSuccess;
}

template NvDlaError Graph<nvdla::priv::canonical_ast::Node, nvdla::priv::canonical_ast::Edge>::dumpGraphML(string filename, string graph_id);
template NvDlaError Graph<nvdla::priv::engine_ast::Node, nvdla::priv::engine_ast::Edge>::dumpGraphML(string filename, string graph_id);
#endif


engine_ast::Graph::~Graph()
{

    for ( size_t g = 0, G = m_graphlets.size(); g != G; ++g)
    {
        delete m_graphlets[g];
    }
    // as the m_resource_mgr is a member, not a reference
    // its destructor will do the following...
    //    vector<memory::Pool> *memPools = m_resource_mgr.memoryPools();
    //    for ( size_t p = 0, P = memPools->size(); p != P; ++p)
    //    {
    //        (*memPools)[p].deallocate();
    //    }
    if ( m_memoryResolver )
    {
        delete m_memoryResolver;
        m_memoryResolver = 0;
    }

    if ( m_lutManager )
    {
        delete m_lutManager;
        m_lutManager = 0;
    }
    if ( m_ordering )
    {
        delete m_ordering;
    }
    if ( m_scored_ordering )
    {
        delete m_scored_ordering;
    }
}
//这个函数完成的是两个graph的转换，通过参数可以看到，输入不仅仅由can_graph,还有编译器的profile和编译目标配置target_config，说明转换后的graph应该反应部分硬件和编译选项的要求
engine_ast::Graph *engine_ast::generateGraph(Profile *profile, TargetConfig *target_config, canonical_ast::Graph *can_graph)
{
    NvDlaError e = NvDlaSuccess;
    vector<engine_ast::Edge *> input_edges;
    vector<engine_ast::Edge *> output_edges;

    vector<canonical_ast::Node *> can_edge_first_nodes, can_edge_second_nodes;
    map<canonical_ast::Node *, engine_ast::Node *> can_to_eng_sink_node_map, can_to_eng_source_node_map;
    map<canonical_ast::Edge *, engine_ast::Edge *> can_to_eng_edge_map;
    vector<canonical_ast::Node *>::const_iterator f, begin, end;
    vector<engine_ast::Node *> first_nodes, second_nodes;
    engine_ast::Graph *eng_graph;

    if ( !profile )
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_BadParameter, "must associate profile with Engine AST generateGraph");
    }

    if ( !target_config )
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_BadParameter, "must associate target_config with Engine AST generateGraph");
    }
    //编译目标是否支持批处理
    if (target_config->isBatchModeCapable())
    {
        NvU32 numBatches = profile->multiBatchSize();
        NvU32 maxBatches = target_config->maxBatchSize();

        if (numBatches > maxBatches)
        {
            ORIGINATE_ERROR_FAIL(NvDlaError_BadValue, "numbatches is greater than allowed maxbatches (%d)", maxBatches);
        }
    }
    // 建立engine_graph对象，参数是profile和target_config
    eng_graph  = new engine_ast::Graph(profile, target_config);
    if ( !eng_graph )
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_InsufficientMemory, "Can't create a new Engine AST");
    }
    //初始化eng_graph的资源，主要是内存池和LutManager，内存池包括GLOBAL_DRAM_POOL，LOCAL_DRAM_POOL
    //如果profile开启了SRAM，那么还有LOCAL_CVSRAM_POOL，这三个mempool的大小由profile参数指定
    e = eng_graph->initGraphResources();
    if (e != NvDlaSuccess)
    {
        delete eng_graph;
        eng_graph = NULL;
        ORIGINATE_ERROR_FAIL(NvDlaError_InsufficientMemory, "Couldn't initialize all graph resources");
    }
    // engine graph 访问计分板
    eng_graph->setScoredOrdering( new ScoredDependencyOrdering(eng_graph) );
    eng_graph->setOrdering(new DependencyOrdering(eng_graph->scoredOrdering()));

    //
    // create edges to mirror the canonical edges.
    // 这里可以看语法树的转换，canonical_ast 的 edge 是被复制到 engine_ast 上的
    for ( set<canonical_ast::Edge *>::iterator cei = can_graph->edges().begin(), CEI = can_graph->edges().end();
          cei != CEI; ++cei )
    {
        //根据canonical_ast::Edge建立engine_ast::Edge对象
        engine_ast::Edge* engine_edge = new engine_ast::Edge(*cei);
        Tensor* engine_tensor = 0;
        if ( !engine_edge )
        {
            delete eng_graph; // blow up
            eng_graph = NULL;
            ORIGINATE_ERROR_FAIL(NvDlaError_InsufficientMemory, "Couldn't transform canonical edge '%s' into engine edge", (*cei)->id().c_str());
        }
      //engine_tensor复制自can_tensor,前面讲过can_tensor其实是clone自network的tensor
      engine_tensor = (*cei)->originalTensor()->clone();
        engine_tensor->setDataFormat(nvdla::DataFormat::NCHW); // all tensors are NCHW unless otherwise specified
        engine_tensor->setNetwork(NULL);                       // get rid of any connections back to the network builder 这里在创建can_tensor的时候已经变成 NULL 了。。

        engine_edge->setGraph(eng_graph); //指定engine_edge的container为eng_graph
        engine_edge->setId(eng_graph->nextEdgeId()); //设定engine_edge的Id，string类型，e-0,e-1等
        engine_edge->setDataEdge(); //设定edge的type为DATA
        engine_edge->setOriginalTensor(engine_tensor); //指定edge关联的tensor

        can_to_eng_edge_map[*cei] = engine_edge; //建立can_edge和engine_edge的关联MAP
        eng_graph->insertEdge(engine_edge); //把engine_edge加入eng_graph的edge列表

    }
    //如果没有指定multibatchsize，则根据network的input tensor的n指定推导multibatchsize
    //如果指定了multibatchsize，那就按照multibatchsize来执行
    if (profile->multiBatchSize() == 0)
    {
        // Patch up profile->multiBatchSize()
        // The compiler should be querying this information from the network instead of the profile

        // Collect the multibatch size of the network, based on the input tensor dimensions
        // 设置输入的维度
        for ( vector<canonical_ast::Edge *>::const_iterator cie = can_graph->inputEdges().begin();
                    cie != can_graph->inputEdges().end(); ++cie)
        {
            engine_ast::Edge *input_edge = can_to_eng_edge_map[*cie];
            Dims4 networkDims = input_edge->originalTensor()->getDimensions();

            //根据input_edge的tensor Dimension的n，设定profile的multibatchsize
          PROPAGATE_ERROR_FAIL(profile->setMultiBatchSize(networkDims.n));
        }
    }

    //
    // create nodes to mirror the canonical nodes
    // 迭代can_graph的所有nodes
    for ( set<canonical_ast::Node *>::iterator cni = can_graph->nodes().begin(), CNI = can_graph->nodes().end();
          cni != CNI; ++cni )
    {
        engine_ast::Graph::EdgeSequence engSrcEdges; //engine_graph的SrcEdges
        engine_ast::Graph::EdgeSequence engSinkEdges; //engine_graph的SinkEdges
        engine_ast::Graph::NodeSequence engNodes; //engine_graph的Nodes
        canonical_ast::Graph::EdgeSequence canSrcEdges = can_graph->nodeEdges(*cni, ast::EdgeSideEnum::SECOND); //can_graph的当前node的inputedge的总和
        canonical_ast::Graph::EdgeSequence canSinkEdges = can_graph->nodeEdges(*cni, ast::EdgeSideEnum::FIRST); //can_graph的当前node的outputedge的总和
        canonical_ast::Graph::EdgeSequenceIterator cei;
        // 这里就是复制一下Src、SinkEdge
        // 找出所有canSrcEdges对应的engine_edge,放入engSrcEdges列表
        for (cei = canSrcEdges.begin(); cei != canSrcEdges.end(); ++cei)
        {
            engSrcEdges.push_back(can_to_eng_edge_map[*cei]);
        }
        // 找出所有canSinkEdges对应的engine_edge,放入engSinkEdges列表
        for (cei = canSinkEdges.begin(); cei != canSinkEdges.end(); ++cei)
        {
            engSinkEdges.push_back(can_to_eng_edge_map[*cei]);
        }
        //从当前的can_node转化出eng_nodes，之所以是end_nodes是因为一个can_node可以对应2，3个eng_nodes
        //转换完毕是否把结果的engNodes挂在eng_graph上？？？需要详细看transformCanNode()函数代码
        e = transformCanNode(eng_graph, *cni, engSrcEdges, engSinkEdges, engNodes);
        if ( e != NvDlaSuccess )
        {
            delete eng_graph; // blow up
            eng_graph = NULL;
            ORIGINATE_ERROR_FAIL(e, "Couldn't transform"
                                    " canonical node '%s' into engine node", (*cni)->id().c_str());
        }
        //n-0:->n-0:dc-conv-0 n-1:bias-0
        //n-1:->n-2:pdp-0
        //n-2:->n-3:dc-conv-1 n-4:bias-1
        //n-3:->n-5:pdp-1
        //n-4:->n-6:fc-0 n-7:bias-2
        //n-5:->n-8:sdp-scale-0 n-9:act-0
        //n-6:->n-10:fc-1 n-11:bias-3
        //n-7:->n-12:cpu-sm-0
        //上面列出的就是transformCanNode()函数的转换结果，可以看到1个can_node有可能转换成2个eng_node
        //是因为can_node是直接对那个network模型的node，而在engine中，一个network模型中的node有可能是
        //需要2个engine前后协同计算才能得到结果，所有这里的eng_node其实已经是映射到硬件上的node了
        if ( eng_graph->debugGraphDump() )
        {
            gLogInfo << (*cni)->id() << ":->";
            for (vector<engine_ast::Node *>::iterator ni = engNodes.begin(); ni != engNodes.end(); ++ni)
            {
                gLogInfo << (*ni)->id() << ":" << (*ni)->name() << " ";
            }
            gLogInfo << std::endl;
        }
    }

  //迭代can_graph的所有inputEdges
  for ( vector<canonical_ast::Edge *>::const_iterator cie = can_graph->inputEdges().begin();
            cie != can_graph->inputEdges().end(); ++cie)
    {
      //找出can_graph的首个inputEdge对应的eng_edge
      engine_ast::Edge *first_edge = can_to_eng_edge_map[can_graph->inputEdges().front()];
      //当前迭代的can_edge对应的eng_edge
      engine_ast::Edge *input_edge = can_to_eng_edge_map[*cie];
      //当前eng_edge对应的tensor格式设定为profile指定的InputDataFormat
      input_edge->originalTensor()->setDataFormat(profile->networkInputDataFormat());
      // 要求所有的inputedge的multibatch参数n必须一致
      // Determine if multibatch parameters are consistent for all input tensors
        if (first_edge->originalTensor()->getDimensions().n != input_edge->originalTensor()->getDimensions().n)
        {
            ORIGINATE_ERROR_FAIL(NvDlaError_BadValue, "Input tensor multibatch dimensions mismatch: %d != %d", first_edge->originalTensor()->getDimensions().n, input_edge->originalTensor()->getDimensions().n);
        }

        Dims4 networkDims = input_edge->originalTensor()->getDimensions();
      //拿所有inputedge的multibatch参数n和profile指定的multibatch参数进行比较，如果不一致
      //则以profile指定的参数为准，并把inputedge中的tensor变量的networkDims.n更新为profile指定的值
        if ( networkDims.n != (NvS32)profile->multiBatchSize() )
        {
            gLogWarning << "Overriding input multibatch size from " << networkDims.n << " to " << profile->multiBatchSize() << endl;
            networkDims.n = profile->multiBatchSize();
            input_edge->originalTensor()->setDimensions(networkDims);
        }

        // if it is IMG input format, ensure #chnls match between model and profile params
        // 如果profile指定的输入IMG tensor的channel数与network提供的networkDims.c不一致
        // 则以profile设定的input tensor的channel值为准，同时更新engine_graph的inputedge对应的tensor
        // 的networkDims.c的值
        if ( profile->networkInputSurfaceFormat().category() == surface::SurfaceCategoryEnum::IMG &&
             networkDims.c != profile->networkInputSurfaceFormat().channelsPerAtom())
        {
            gLogWarning << "Prototxt #chnls (C = "
                        << networkDims.c
                        << ") != Profile #chnls for input ("
                        << profile->networkInputSurfaceFormat().c_str()
                        << ": C = "
                        << (int)profile->networkInputSurfaceFormat().channelsPerAtom()
                        << "). Preferring #chnls from Profile for compiling."
                        << endl;
            networkDims.c = profile->networkInputSurfaceFormat().channelsPerAtom();
            input_edge->originalTensor()->setDimensions(networkDims);

            // copy the tensor scales and offsets to the extra channel if any
            if (input_edge->originalTensor()->getChannelScales().size())
            {
                NvF32 tensorScale  = input_edge->originalTensor()->getChannelScales().at(0);
                std::vector<NvF32> channelScales;
                for (NvU32 cc = 0; cc < (NvU32)networkDims.c; ++cc)
                {
                    channelScales.push_back(tensorScale);
                }
                input_edge->originalTensor()->setChannelScales(channelScales);
            }

            if (input_edge->originalTensor()->getChannelOffsets().size())
            {
                NvF32 tensorOffset = input_edge->originalTensor()->getChannelOffsets().at(0);
                std::vector<NvF32> channelOffsets;
                for (NvU32 cc = 0; cc < (NvU32)networkDims.c; ++cc)
                {
                    channelOffsets.push_back(tensorOffset);
                }
                input_edge->originalTensor()->setChannelOffsets(channelOffsets);
            }
        }
      // 这个bindid好像只是整个图的input和output的edge才设定，这个函数只是设定两个变量而已
      // m_bindDomain = bindDomain; m_bindId = id; bingDomain有input output debug三种
      // 这个bindid也是随着inputedge的增加顺序往后排
        input_edge->setBindId(input_edges.size(), IOD_Input);
        if ( eng_graph->debugBinding() )
        {
            gLogInfo << "EngineAST graph level input edge[" << input_edges.size() << "] is " << input_edge->id() << endl;
            gLogInfo << "input bind id: " << input_edge->bindId() << endl;
        }

        input_edges.push_back( input_edge );
    };

    // 设定整个eng_graph的inputedge列表为input_edges
    if ( input_edges.size() )
    {
        eng_graph->setInputEdges(input_edges);
    }

  //按照以上处理inputedge的方法，处理所有的outputedges
  for ( vector<canonical_ast::Edge *>::const_iterator coe = can_graph->outputEdges().begin();
            coe != can_graph->outputEdges().end(); ++coe)
    {
        engine_ast::Edge *output_edge = can_to_eng_edge_map[*coe];
        output_edge->originalTensor()->setDataFormat(profile->networkOutputDataFormat());

        Dims4 networkDims = output_edge->originalTensor()->getDimensions();
        if ( networkDims.n != (NvS32)profile->multiBatchSize() )
        {
            gLogWarning << "Overriding output multibatch size from " << networkDims.n << " to " << profile->multiBatchSize() << endl;
            networkDims.n = profile->multiBatchSize();
            output_edge->originalTensor()->setDimensions(networkDims);
        }

        output_edge->setBindId(output_edges.size(), IOD_Output);
        if ( eng_graph->debugBinding() )
        {
            gLogInfo << "EngineAST graph level output edge[" << output_edges.size() << "] is " << output_edge->id() << endl;
            gLogInfo << "output bind id: " << output_edge->bindId() << endl;
        }

        output_edges.push_back( output_edge );
    };
  //设定整个eng_graph的outputedge列表为output_edges

  if ( output_edges.size() )
    {
        eng_graph->setOutputEdges(output_edges);
    }
    // 打印所有eng_node的name，编号，以及对应的can_node的name
    // 同时打印每个eng_node的所有input output aux类型的edge
    //libnvdla<3> dc-conv-0/n-0/conv1:
    //libnvdla<3> 	in e-0
    //libnvdla<3> 	out e-11
    //libnvdla<3> 	aux e-9
    //libnvdla<3> bias-0/n-1/conv1:
    //libnvdla<3> 	in e-11
    //libnvdla<3> 	out e-1
    //libnvdla<3> 	aux e-10
    // cache input/output/aux edges of each node into their respective data ports
    if ( eng_graph->debugGraphDump() )
    {
        engine_ast::Graph::NodeSet engineNodes = eng_graph->nodes();
        engine_ast::Graph::NodeSetIterator eni = engineNodes.begin();
        for ( ; eni != engineNodes.end(); ++eni)
        {
            typedef std::vector<Edge*>::const_iterator ESI;

            std::string canNodeName;
            if ((*eni)->canonicalNode() == NULL)
            {
                canNodeName = "(No canonical node)";
            }
            else
            {
                canNodeName = (*eni)->canonicalNode()->name();
            }
            gLogInfo << (*eni)->name() << "/" << (*eni)->id() << "/"
                     << canNodeName << ":" << endl;
            for (ESI ii = (*eni)->inputEdges().begin(); ii != (*eni)->inputEdges().end(); ++ii)
                gLogInfo << "\tin " << (*ii)->id() << endl;
            for (ESI ii = (*eni)->outputEdges().begin(); ii != (*eni)->outputEdges().end(); ++ii)
                gLogInfo << "\tout " << (*ii)->id() << endl;
            for (ESI ii = (*eni)->auxEdges().begin(); ii != (*eni)->auxEdges().end(); ++ii)
                gLogInfo << "\taux " << (*ii)->id() << endl;
        }
    }

    eng_graph->ordering()->generate();
    eng_graph->markClean();

    // force N = 1 for all non-Aux tensors represented by non-bindable edges;
    // until we allow contiguous non-bindable tensors for multi-batch
    {
        engine_ast::Graph::EdgeSequence engineEdges = eng_graph->orderedEdges();
        for (engine_ast::Graph::EdgeSequenceIterator eei = engineEdges.begin(); eei != engineEdges.end(); ++eei)
        {
            if (!(*eei)->bindable() && !(*eei)->isAuxEdge() && (*eei)->originalTensor())
            {
                Dims4 nonBindableTensorDims = (*eei)->originalTensor()->getDimensions();
                if ( eng_graph->debugGraphDump() )
                {
                    if (nonBindableTensorDims.n != 1)
                        gLogInfo << "Forcing batch size '1' for non-bindable non-aux edge " << (*eei)->id() << endl;
                }
                nonBindableTensorDims.n = 1;
                (*eei)->originalTensor()->setDimensions(nonBindableTensorDims);
            }
        }
    }
    return eng_graph;

fail:
    return NULL;
}
//transformCanConvOp完成conv类型的canNode到engNode的转换操作
static NvDlaError transformCanConvOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode, //输入是一个canNode
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes //输出是一个或多个engNodes
)
{
    NvDlaError e = NvDlaSuccess;
    bool isWG = false;
    bool isInputBindable  = false;
    bool isOutputBindable = false;
    canonical_ast::ConvolutionNode* canConvNode        = NULL;
    engine_ast::ConvCoreNode* engConvNode              = NULL;
    engine_ast::SDPNode* adjointSDPNode                = NULL;
    engine_ast::Edge* engSrcEdge                       = NULL;
    engine_ast::Edge* engSinkEdge                      = NULL;
    engine_ast::Edge* convAuxEdge                      = NULL;
    engine_ast::Edge* sdpAuxEdge                       = NULL;
    canonical_ast::Graph::EdgeSequence canInputEdges   = canNode->graph()->inputEdges();
    canonical_ast::Graph::EdgeSequence canOutputEdges  = canNode->graph()->outputEdges();

    //转换操作只支持conv的输入输出edge都是1的类型
    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Conv operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge     = engSrcEdges[0]; //实际上engSrcEdges[]数组也只有一个元素
    engSinkEdge    = engSinkEdges[0]; //实际上engSinkEdge[]数组也只有一个元素
    //canNode转换为canConvNode
    canConvNode    = canonical_ast::NodeFactory::nodeCast<canonical_ast::ConvolutionNode*>(canNode);
    //根据canConvNode构造engConvNode<这条语句后面单独解析>
    engConvNode    = engine_ast::NodeFactory::newConvCoreConvolutionOpNode(canConvNode, engGraph);
  //adjointSDPNode是由engConvNode根据canConvNode创建的，创建完毕直接和engConvNode进行关联
    adjointSDPNode = engConvNode->addSDPJointOpNode(canConvNode);
  //设定adjointSDPNode工作模式，因为SDP引擎功能较多
  adjointSDPNode->params().setConvMode(engConvNode->params().convMode());

    ASSERT( canNode->inputEdges().size() == 1 );
    ASSERT( canNode->outputEdges().size() == 1 );
    //判断当前要转换的节点的输入edge是否是整个graph的输入edge
    isInputBindable  = std::find(canInputEdges.begin(), canInputEdges.end(), canNode->inputEdges().at(0)) != canInputEdges.end();
    //判断当前要转换的节点的输出edge是否是整个graph的输出edge
    isOutputBindable = std::find(canOutputEdges.begin(), canOutputEdges.end(), canNode->outputEdges().at(0)) != canOutputEdges.end();
    //判断engConvNode的conv模式是否是WINOGRAD
    isWG             = engConvNode->params().convMode() == engine_ast::ConvolutionModeEnum::CONV_WINOGRAD;
    //WINOGRAD模式的conv操作不适合作为系统的输入或者输出节点
    if (isWG && (isInputBindable || isOutputBindable))
    {
        gLogWarning << "Can't use WG mode with bindable surfaces. Falling back to CONV_DIRECT for "
                    << engConvNode->name() << endl;
        isWG = false;
        engConvNode->setName("dc-conv-" + engConvNode->name().substr(engConvNode->name().find("wg-conv-") + 8));
        engConvNode->params().setConvMode(engine_ast::ConvolutionModeEnum::CONV_DIRECT);
        adjointSDPNode->params().setConvMode(engine_ast::ConvolutionModeEnum::CONV_DIRECT);
    }
    //把engSrcEdge连接到刚刚创建的engConvNode的输入edge侧
    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engConvNode);
    //把engSinkEdge连接到刚刚创建的adjointSDPNode的输出edge侧
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, adjointSDPNode);
    //为engConvNode创建并关联auxEdge，这个auxEdge用来向conv节点输入weight数据
    PROPAGATE_ERROR_FAIL(engConvNode->nodeAuxEdge(&convAuxEdge));
    //为adjointSDPNode创建并关联auxEdge，这个auxEdge用来向sdp节点输入bias数据
    PROPAGATE_ERROR_FAIL(adjointSDPNode->nodeAuxEdge(&sdpAuxEdge));

    PROPAGATE_ERROR_FAIL(engConvNode->populateEdgePorts());
    transformedEngNodes.push_back(engConvNode); //把engConvNode加入函数返回node列表中

    PROPAGATE_ERROR_FAIL(adjointSDPNode->populateEdgePorts());
    transformedEngNodes.push_back(adjointSDPNode); //把adjointSDPNode加入函数返回node列表中

    if (isWG)
    {
        PROPAGATE_ERROR_FAIL(engConvNode->determineWinogradParams());
        PROPAGATE_ERROR_FAIL(adjointSDPNode->determineWinogradParams(engConvNode));
    }

fail:
    return e;
}

static NvDlaError transformCanFCOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::FullyConnectedNode* canFCNode = NULL;
    engine_ast::ConvCoreNode* engFCNode          = NULL;
    engine_ast::SDPNode* adjointSDPNode          = NULL;
    engine_ast::Edge* engSrcEdge                 = NULL;
    engine_ast::Edge* engSinkEdge                = NULL;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support FC operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge     = engSrcEdges[0];
    engSinkEdge    = engSinkEdges[0];
    canFCNode      = canonical_ast::NodeFactory::nodeCast<canonical_ast::FullyConnectedNode*>(canNode);
    engFCNode      = engine_ast::NodeFactory::newConvCoreFullyConnectedOpNode(canFCNode, engGraph);
    adjointSDPNode = engFCNode->addSDPJointOpNode(canFCNode);
    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engFCNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, adjointSDPNode);

    PROPAGATE_ERROR_FAIL(engFCNode->populateEdgePorts());
    transformedEngNodes.push_back(engFCNode);

    PROPAGATE_ERROR_FAIL(adjointSDPNode->populateEdgePorts());
    transformedEngNodes.push_back(adjointSDPNode);

fail:
    return e;
}

/**
 * Attaches unit scale op before given node to handle rescaling.
 *
 * This function is useful whenever a node doesn't want to do rescaling within itself
 *  (like ReLU).
 *
 * For instance say NodeA doesn't want to handle its rescaling (just to avoid complexity)
 *  input scaling factor NodeA (say ReLU)  = Si
 *  output scaling factor NodeA (say ReLU) = So
 *
 * Conversion:
 *  ReLU  = unit scale node(per-channel) + ReLU
 *  Where,
 *      input scaling factor of unit scale node  = Si
 *      output scaling factor of unit scale node/input scaling factor of ReLU  = So
 *      output scaling factor of ReLU = So
 *
 * This would introduce new unit scale node (per-channel) that handles rescaling and
 * NodeA is free from doing the same.
 *
 * CAUTION: This function does the rescaling before the actual operation (ReLU).
 *          Such rescaling is fine in cases like ReLU. To be used with care.
 *
 **/
static NvDlaError prependScaleOpForRescaling
(
    engine_ast::Graph *engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;

    engine_ast::SDPScaleOpNode* engSDPScaleNode = NULL;
    surface::SurfacePrecision computePrecision  = engGraph->profile()->computePrecision();
    engine_ast::Edge* engSrcEdge                = NULL;
    engine_ast::Edge* scaleSinkEdge             = NULL;

    Tensor* inTensor = NULL;
    Tensor* outTensor = NULL;

    Dims4 scaleDims;
    engine_ast::SDPMode scaleMode = engine_ast::SDPModeEnum::SDP_MODE_PER_CHANNEL; // Force it to per-channel

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Activation operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    if (computePrecision.v() != surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT8)
    {
        /* Rescaling applicable for only int8 */
        goto fail;
    }

    /* Create a new sdp node */
    engSDPScaleNode = engine_ast::NodeFactory::newSDPScaleOpNode(NULL, engGraph);

    /* Create an output tensor for newscale node and uses the same as that next canNode */
    outTensor = canNode->outputEdges().at(0)->originalTensor()->clone();
    outTensor->setTensorType(TensorType::kIO);

    /* Determine the scaling dimension based on scale mode */
    inTensor = canNode->inputEdges().at(0)->originalTensor();
    scaleDims.n = 1;
    scaleDims.c = inTensor->getDimensions().c;
    scaleDims.h = 1;
    scaleDims.w = 1;

    /* Update the params of engScaleNode. */
    engSDPScaleNode->populateWithUnitScaleParams(scaleMode, scaleDims);

    /* create an new edge from output of scale to input of canNode */
    engSrcEdge  = engSrcEdges[0];
    scaleSinkEdge = engGraph->addDataEdge((engine_ast::Edge*)0,
                            (engine_ast::Node*)0,
                            (engine_ast::Node*)0,
                            outTensor);
    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engSDPScaleNode);
    engGraph->appendNodeToEdge(scaleSinkEdge, ast::EdgeSideEnum::FIRST, engSDPScaleNode);

    PROPAGATE_ERROR_FAIL(engSDPScaleNode->populateEdgePorts());
    transformedEngNodes.push_back(engSDPScaleNode);
fail:
    return e;
}

static NvDlaError transformCanActOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::ActivationNode* canActNode   = NULL;
    engine_ast::SDPActivationOpNode* engActNode = NULL;
    engine_ast::Edge* engSrcEdge                = NULL;
    engine_ast::Edge* engSinkEdge               = NULL;
    engine_ast::Graph::NodeSequence rescaleEngNodes;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Activation operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge  = engSrcEdges[0];
    engSinkEdge = engSinkEdges[0];

    canActNode  = canonical_ast::NodeFactory::nodeCast<canonical_ast::ActivationNode*>(canNode);
    if (canActNode->params().activationType() == ActivationType::kRELU)
    {
        PROPAGATE_ERROR_FAIL(prependScaleOpForRescaling(engGraph,
                            canNode,
                            engSrcEdges,
                            engSinkEdges,
                            rescaleEngNodes));

        if (rescaleEngNodes.size() > 0)
        {
            ASSERT(rescaleEngNodes.size() == 1);
            for (NvU32 ii = 0; ii < rescaleEngNodes.size(); ii++)
            {
                transformedEngNodes.push_back(rescaleEngNodes.at(ii));
            }

            // New src edge becomes scales output edge.
            engSrcEdge = engGraph->nodeEdges(rescaleEngNodes.back(), ast::EdgeSideEnum::FIRST).at(0);
        }
    }

    engActNode  = engine_ast::NodeFactory::newSDPActivationOpNode(canActNode, engGraph);

    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engActNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engActNode);

    PROPAGATE_ERROR_FAIL(engActNode->populateEdgePorts());
    transformedEngNodes.push_back(engActNode);

fail:
    return e;
}

static NvDlaError transformCanPoolingOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::PoolingNode* canPoolNode = NULL;
    engine_ast::PDPNode* engPDPNode         = NULL;
    engine_ast::Edge* engSrcEdge            = NULL;
    engine_ast::Edge* engSinkEdge           = NULL;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Pooling operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge  = engSrcEdges[0];
    engSinkEdge = engSinkEdges[0];
    canPoolNode = canonical_ast::NodeFactory::nodeCast<canonical_ast::PoolingNode*>(canNode);
    engPDPNode  = engine_ast::NodeFactory::newPDPNode(canPoolNode, engGraph);

    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engPDPNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engPDPNode);

    PROPAGATE_ERROR_FAIL(engPDPNode->populateEdgePorts());
    transformedEngNodes.push_back(engPDPNode);

fail:
    return e;
}

static NvDlaError transformCanLRNOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::LRNNode* canLRNNode   = NULL;
    engine_ast::CDPLRNOpNode* engLRNNode = NULL;
    engine_ast::Edge* engSrcEdge         = NULL;
    engine_ast::Edge* engSinkEdge        = NULL;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support LRN operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge  = engSrcEdges[0];
    engSinkEdge = engSinkEdges[0];
    canLRNNode  = canonical_ast::NodeFactory::nodeCast<canonical_ast::LRNNode*>(canNode);
    engLRNNode  = engine_ast::NodeFactory::newCDPLRNOpNode(canLRNNode, engGraph);

    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engLRNNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engLRNNode);

    PROPAGATE_ERROR_FAIL(engLRNNode->populateEdgePorts());
    transformedEngNodes.push_back(engLRNNode);

fail:
    return e;
}

static NvDlaError transformCanScaleOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e       = NvDlaSuccess;
    bool isCPUOp    = false;
    bool isBiasTerm = false;
    Weights power;
    canonical_ast::ScaleNode* canScaleNode      = NULL;
    engine_ast::CPUScaleOpNode* engCPUScaleNode = NULL;
    engine_ast::SDPScaleOpNode* engSDPScaleNode = NULL;
    engine_ast::SDPNode* adjointEngSDPBiasNode  = NULL;
    engine_ast::Edge* engSrcEdge                = NULL;
    engine_ast::Edge* engSinkEdge               = NULL;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Scale operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge   = engSrcEdges[0];
    engSinkEdge  = engSinkEdges[0];

    canScaleNode = canonical_ast::NodeFactory::nodeCast<canonical_ast::ScaleNode*>(canNode);

    power = canScaleNode->params().power();
    if ((power.count > 0) && (*reinterpret_cast<float*>(const_cast<void*>(power.values)) != 0.0f))
    {
        engCPUScaleNode = engine_ast::NodeFactory::newCPUScaleOpNode(canScaleNode, engGraph);
        engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engCPUScaleNode);
        engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engCPUScaleNode);
        isCPUOp = true;
    }
    else
    {
        engSDPScaleNode = engine_ast::NodeFactory::newSDPScaleOpNode(canScaleNode, engGraph);
        engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engSDPScaleNode);
        if (canScaleNode->params().hasBiasTerm())
        {
            adjointEngSDPBiasNode = engSDPScaleNode->addSDPBiasOpNode(canNode);
            engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, adjointEngSDPBiasNode);
            isBiasTerm = true;
        }
        else
        {
            engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engSDPScaleNode);
            isBiasTerm = false;
        }
    }

    if (isCPUOp)
    {
        PROPAGATE_ERROR_FAIL(engCPUScaleNode->populateEdgePorts());
        transformedEngNodes.push_back(engCPUScaleNode);
    }
    else
    {
        PROPAGATE_ERROR_FAIL(engSDPScaleNode->populateEdgePorts());
        transformedEngNodes.push_back(engSDPScaleNode);
        if (isBiasTerm)
        {
            PROPAGATE_ERROR_FAIL(adjointEngSDPBiasNode->populateEdgePorts());
            transformedEngNodes.push_back(adjointEngSDPBiasNode);
        }
    }

fail:
    return e;
}

static NvDlaError transformCanBNOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::BatchNormNode* canBNNode = NULL;
    engine_ast::SDPBatchNormOpNode* engBNNode = NULL;
    engine_ast::Edge* engSrcEdge                = NULL;
    engine_ast::Edge* engSinkEdge               = NULL;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Batch Norm operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge  = engSrcEdges[0];
    engSinkEdge = engSinkEdges[0];
    canBNNode   = canonical_ast::NodeFactory::nodeCast<canonical_ast::BatchNormNode*>(canNode);
    engBNNode   = engine_ast::NodeFactory::newSDPBatchNormOpNode(canBNNode, engGraph);

    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engBNNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engBNNode);

    PROPAGATE_ERROR_FAIL(engBNNode->populateEdgePorts());
    transformedEngNodes.push_back(engBNNode);

fail:
    return e;
}

static NvDlaError transformCanSoftMaxOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::SoftMaxNode* canSMNode = NULL;
    engine_ast::CPUSoftMaxOpNode* engSMNode = NULL;
    engine_ast::Edge* engSrcEdge                = NULL;
    engine_ast::Edge* engSinkEdge               = NULL;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Softmax operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge  = engSrcEdges[0];
    engSinkEdge = engSinkEdges[0];
    canSMNode = canonical_ast::NodeFactory::nodeCast<canonical_ast::SoftMaxNode*>(canNode);
    engSMNode = engine_ast::NodeFactory::newCPUSoftMaxOpNode(canSMNode, engGraph);

    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engSMNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engSMNode);

    PROPAGATE_ERROR_FAIL(engSMNode->populateEdgePorts());
    transformedEngNodes.push_back(engSMNode);

fail:
    return e;
}

static NvDlaError transformCanDeconvOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::DeconvolutionNode* canDeconvNode = NULL;
    engine_ast::ConvCoreNode* engDeconvNode         = NULL;
    engine_ast::SDPNode* adjointSDPNode             = NULL;
    engine_ast::Edge* engSrcEdge                    = NULL;
    engine_ast::Edge* engSinkEdge                   = NULL;

    if (engSrcEdges.size() != 1 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support Deconv operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrcEdge     = engSrcEdges[0];
    engSinkEdge    = engSinkEdges[0];
    canDeconvNode  = canonical_ast::NodeFactory::nodeCast<canonical_ast::DeconvolutionNode*>(canNode);
    engDeconvNode  = engine_ast::NodeFactory::newConvCoreDeconvolutionOpNode(canDeconvNode, engGraph);
    adjointSDPNode = engDeconvNode->addSDPJointOpNode(canDeconvNode);

    engGraph->appendNodeToEdge(engSrcEdge, ast::EdgeSideEnum::SECOND, engDeconvNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, adjointSDPNode);

    PROPAGATE_ERROR_FAIL(engDeconvNode->populateEdgePorts());
    transformedEngNodes.push_back(engDeconvNode);

    PROPAGATE_ERROR_FAIL(adjointSDPNode->populateEdgePorts());
    transformedEngNodes.push_back(adjointSDPNode);
    //TODO: a deconv op may also need some of the Rubik Eng magic. Add the rubik node accordingly

fail:
    return e;
}

static NvDlaError transformCanConcatOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::ConcatenationNode* canConcatNode = NULL;
    engine_ast::ConcatenationNode* engConcatNode    = NULL;
    engine_ast::Graph::EdgeSequenceIterator eni;

    canConcatNode = canonical_ast::NodeFactory::nodeCast<canonical_ast::ConcatenationNode*>(canNode);
    engConcatNode = engine_ast::NodeFactory::newConcatNode(canConcatNode, engGraph);

    for (eni = engSrcEdges.begin(); eni != engSrcEdges.end(); ++eni)
    {
        engGraph->appendNodeToEdge(*eni, ast::EdgeSideEnum::SECOND, engConcatNode);
    }

    for (eni = engSinkEdges.begin(); eni != engSinkEdges.end(); ++eni)
    {
        engGraph->appendNodeToEdge(*eni, ast::EdgeSideEnum::FIRST, engConcatNode);
    }

    PROPAGATE_ERROR_FAIL(engConcatNode->populateEdgePorts());
    transformedEngNodes.push_back(engConcatNode);

fail:
    return e;
}

static NvDlaError transformCanEWOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::ElementWiseNode* canEWNode   = NULL;
    engine_ast::SDPElementWiseOpNode* engEWNode = NULL;
    engine_ast::Edge* engSrc1Edge               = NULL;
    engine_ast::Edge* engSrc2Edge               = NULL;
    engine_ast::Edge* engSinkEdge               = NULL;

    if (engSrcEdges.size() != 2 || engSinkEdges.size() != 1)
    {
        ORIGINATE_ERROR_FAIL(NvDlaError_NotSupported, "Don't support EW operation with input edges (%d) != 1 or "
                                                   "output edges (%d) != 1", engSrcEdges.size(), engSinkEdges.size());
    }

    engSrc1Edge  = engSrcEdges[0];
    engSrc2Edge  = engSrcEdges[1];
    engSinkEdge = engSinkEdges[0];
    canEWNode   = canonical_ast::NodeFactory::nodeCast<canonical_ast::ElementWiseNode*>(canNode);
    engEWNode   = engine_ast::NodeFactory::newSDPElementWiseOpNode(canEWNode, engGraph);

    engGraph->appendNodeToEdge(engSrc1Edge, ast::EdgeSideEnum::SECOND, engEWNode);
    engGraph->appendNodeToEdge(engSrc2Edge, ast::EdgeSideEnum::SECOND, engEWNode);
    engGraph->appendNodeToEdge(engSinkEdge, ast::EdgeSideEnum::FIRST, engEWNode);

    PROPAGATE_ERROR_FAIL(engEWNode->populateEdgePorts());
    transformedEngNodes.push_back(engEWNode);

fail:
    return e;
}

static NvDlaError transformCanSplitOp
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;
    canonical_ast::SplitNode* canSplitNode = NULL;
    engine_ast::SplitNode* engSplitNode    = NULL;
    engine_ast::Graph::EdgeSequenceIterator eni;

    canSplitNode = canonical_ast::NodeFactory::nodeCast<canonical_ast::SplitNode*>(canNode);
    engSplitNode = engine_ast::NodeFactory::newSplitNode(canSplitNode, engGraph);

    for (eni = engSrcEdges.begin(); eni != engSrcEdges.end(); ++eni)
    {
        engGraph->appendNodeToEdge(*eni, ast::EdgeSideEnum::SECOND, engSplitNode);
    }

    for (eni = engSinkEdges.begin(); eni != engSinkEdges.end(); ++eni)
    {
        engGraph->appendNodeToEdge(*eni, ast::EdgeSideEnum::FIRST, engSplitNode);
    }

    PROPAGATE_ERROR_FAIL(engSplitNode->populateEdgePorts());
    transformedEngNodes.push_back(engSplitNode);

fail:
    return e;
}

NvDlaError engine_ast::transformCanNode
(
    engine_ast::Graph* engGraph,
    canonical_ast::Node *canNode,
    engine_ast::Graph::EdgeSequence engSrcEdges,
    engine_ast::Graph::EdgeSequence engSinkEdges,
    engine_ast::Graph::NodeSequence& transformedEngNodes
)
{
    NvDlaError e = NvDlaSuccess;

    switch (canNode->canonicalOpType().v())
    {
        case canonical_ast::CONVOLUTION:
            PROPAGATE_ERROR_FAIL(transformCanConvOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::FULLY_CONNECTED:
            PROPAGATE_ERROR_FAIL(transformCanFCOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::ACTIVATION:
            PROPAGATE_ERROR_FAIL(transformCanActOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::POOLING:
            PROPAGATE_ERROR_FAIL(transformCanPoolingOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::LRN:
            PROPAGATE_ERROR_FAIL(transformCanLRNOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::SCALE:
            PROPAGATE_ERROR_FAIL(transformCanScaleOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::BATCH_NORM:
            PROPAGATE_ERROR_FAIL(transformCanBNOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::SOFTMAX:
            PROPAGATE_ERROR_FAIL(transformCanSoftMaxOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::DECONVOLUTION:
            PROPAGATE_ERROR_FAIL(transformCanDeconvOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::CONCATENATION:
            PROPAGATE_ERROR_FAIL(transformCanConcatOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::ELEMENTWISE:
            PROPAGATE_ERROR_FAIL(transformCanEWOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        case canonical_ast::SPLIT:
            PROPAGATE_ERROR_FAIL(transformCanSplitOp(engGraph, canNode, engSrcEdges, engSinkEdges, transformedEngNodes)); break;
        default:
             ORIGINATE_ERROR_FAIL(NvDlaError_BadParameter, "Unexpected canonical node '%s' of type '%s' ",
                                                         canNode->id().c_str(), canNode->canonicalOpType().c_str());
    }

fail:
    return e;
}


//----------------------------------------------------------------------
//                           serialization
//----------------------------------------------------------------------
bool engine_ast::serializeTo(WisdomContainerEntry *)
{
    // tbd
    return false;
}

bool engine_ast::deserializeFrom(WisdomContainerEntry *)
{
    // tbd
    return false;
}

ostream &engine_ast::outputJson(engine_ast::Graph *, ostream &os)
{
    // tbd
    return os;
}

ostream &engine_ast::outputJson(engine_ast::Graph *g, engine_ast::Edge *edge, ostream &os)
{
    string delim("");
    NodeSequence srcs = g->upstreamNodes(edge);
    NodeSequence tgts = g->downstreamNodes(edge);

    // note: the (void*) cast hack is to be certain the ids given are unique.
    // nodes already had a property like that.  but edges didn't.

    os << "{\"class\":\"edge\", \"id\" : \"e-" << std::hex << (void*)edge << std::dec <<
        "\", \"name\":\"" << edge->id()<<
        "\", \"type\":\"" << edge->edgeType().c_str() << "\", ";

    os << "\"sources\":[";

    for ( NodeSequence::const_iterator si = srcs.begin(); si != srcs.end(); ++si)
    {
        os << delim << "\"" << (*si)->name() << "\""; delim = ", ";
    }
    delim="";
    os << "], \"targets\":[";

    for ( NodeSequence::const_iterator ti = tgts.begin(); ti != tgts.end(); ++ti)
    {
        os << delim << "\"" << (*ti)->name() << "\""; delim = ", ";
    }
    os << "]}";
    return os;
}
ostream &engine_ast::outputJson(engine_ast::Graph *, engine_ast::Node *node, ostream &os)
{
    os << "{\"class\":\"node\", \"id\" : \"" << node->name() <<
        "\",\"name\":\"" << node->id() <<
        "\",\"className\":\"" << node->className() <<
        "\"}";
    return os;
}

NvU16 engine_ast::ASTToEMUInterface::getDataFormat(EMUInterface* emu_if, surface::SurfaceFormat sf, NvU32 mem_atomic_size)
{
    NvU16 emu_if_df = 0xFF;
    switch(sf.v()) {
        case surface::SurfaceFormatEnum::NVDLA_FEATURE_DATA_INT8:
            emu_if_df = emu_if->bufferDescAccessor(0).format_INT8();
            if (mem_atomic_size == 8)
                emu_if_df = emu_if->bufferDescAccessor(0).format_INT8_8();
            break;
        case surface::SurfaceFormatEnum::NVDLA_FEATURE_DATA_INT16: emu_if_df = emu_if->bufferDescAccessor(0).format_INT16(); break;
        case surface::SurfaceFormatEnum::NVDLA_FEATURE_DATA_FP16: emu_if_df = emu_if->bufferDescAccessor(0).format_FF16(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong surface format provided %s", sf.c_str());
    }

    return emu_if_df;
}

NvU8 engine_ast::ASTToDLAInterface::getConvCorePrecision(DLAInterface* dla_if, surface::SurfacePrecision sp)
{
    NvU8 dla_if_sp = 0xFF;
    switch(sp.v()) {
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_FP16:  dla_if_sp = dla_if->convOpDescAccessor(0).inPrecision_FP16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT16: dla_if_sp = dla_if->convOpDescAccessor(0).inPrecision_Int16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT8:  dla_if_sp = dla_if->convOpDescAccessor(0).inPrecision_Int8(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong surface precision provided %s", sp.c_str());
    }
    return dla_if_sp;
}

NvU8 engine_ast::ASTToDLAInterface::getSDPPrecision(DLAInterface* dla_if, surface::SurfacePrecision sp)
{
    NvU8 dla_if_sp = 0xFF;
    switch(sp.v()) {
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_FP16:  dla_if_sp = dla_if->sdpOpDescAccessor(0).srcPrecision_FP16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT16: dla_if_sp = dla_if->sdpOpDescAccessor(0).srcPrecision_Int16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT8:  dla_if_sp = dla_if->sdpOpDescAccessor(0).srcPrecision_Int8(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong surface precision provided %s", sp.c_str());
    }
    return dla_if_sp;
}

NvU8 engine_ast::ASTToDLAInterface::getSDPActType(DLAInterface* dla_if, engine_ast::SDPActType sat)
{
    NvU8 dla_if_sat = 0xFF;
    switch(sat.v()) {
        case engine_ast::SDPActTypeEnum::SDP_ACT_TYPE_RELU: dla_if_sat = dla_if->sdpOpAccessor(0).act_RelU(); break;
        case engine_ast::SDPActTypeEnum::SDP_ACT_TYPE_SIGMOID:
        case engine_ast::SDPActTypeEnum::SDP_ACT_TYPE_TANH: dla_if_sat = dla_if->sdpOpAccessor(0).act_LUT(); break;
        case engine_ast::SDPActTypeEnum::SDP_ACT_TYPE_NONE: dla_if_sat = dla_if->sdpOpAccessor(0).act_None(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong SDP Activation type provided %s", sat.c_str());
    }
    return dla_if_sat;
}

NvU8 engine_ast::ASTToDLAInterface::getSDPMode(DLAInterface* dla_if,
                                            engine_ast::SDPMode smode)
{
    NvU8 dla_if_smode = 0xFF;
    switch(smode.v()) {
        case engine_ast::SDPModeEnum::SDP_MODE_PER_LAYER:
            dla_if_smode = dla_if->sdpOpAccessor(0).mode_PerLayer();
            break;
        case engine_ast::SDPModeEnum::SDP_MODE_PER_CHANNEL:
            dla_if_smode = dla_if->sdpOpAccessor(0).mode_PerKernel();
            break;
        case engine_ast::SDPModeEnum::SDP_MODE_PER_ELEMENT:
            dla_if_smode = dla_if->sdpOpAccessor(0).mode_PerPoint();
            break;
        default:
            REPORT_ERROR(NvDlaError_BadParameter,
                        "Wrong SDP mode provided %s",
                        smode.c_str());
    }
    return dla_if_smode;
}

NvU8 engine_ast::ASTToDLAInterface::getSDPEnable(DLAInterface* dla_if, bool enabled)
{
    NvU8 dla_if_enable = 0;
    if (enabled)
    {
        dla_if_enable = 1;
    }

    return dla_if_enable;
}

NvU8 engine_ast::ASTToDLAInterface::getSDPALUType(DLAInterface* dla_if, engine_ast::SDPALUType sat)
{
    NvU8 dla_if_sat = 0xFF;
    switch(sat.v()) {
        case engine_ast::SDPALUTypeEnum::SDP_ALU_TYPE_MAX: dla_if_sat = dla_if->sdpOpAccessor(0).ALUType_Max(); break;
        case engine_ast::SDPALUTypeEnum::SDP_ALU_TYPE_MIN: dla_if_sat = dla_if->sdpOpAccessor(0).ALUType_Min(); break;
        case engine_ast::SDPALUTypeEnum::SDP_ALU_TYPE_SUM: dla_if_sat = dla_if->sdpOpAccessor(0).ALUType_Sum(); break;
        case engine_ast::SDPALUTypeEnum::SDP_ALU_TYPE_EQL: dla_if_sat = dla_if->sdpOpAccessor(0).ALUType_Eql(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong SDP ALU type provided %s", sat.c_str());
    }
    return dla_if_sat;
}

NvU8 engine_ast::ASTToDLAInterface::getSDPOpType(DLAInterface* dla_if, engine_ast::SDPOpType sat)
{
    NvU8 dla_if_sat = 0xFF;
    switch(sat.v()) {
        case engine_ast::SDPOpTypeEnum::SDP_OP_TYPE_NONE: dla_if_sat = dla_if->sdpOpAccessor(0).type_None(); break;
        case engine_ast::SDPOpTypeEnum::SDP_OP_TYPE_MUL: dla_if_sat = dla_if->sdpOpAccessor(0).type_Mul(); break;
        case engine_ast::SDPOpTypeEnum::SDP_OP_TYPE_ADD: dla_if_sat = dla_if->sdpOpAccessor(0).type_Add(); break;
        case engine_ast::SDPOpTypeEnum::SDP_OP_TYPE_BOTH: dla_if_sat = dla_if->sdpOpAccessor(0).type_Both(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong SDP Op type provided %s", sat.c_str());
    }
    return dla_if_sat;
}

NvU8 engine_ast::ASTToDLAInterface::getPDPPrecision(DLAInterface* dla_if, surface::SurfacePrecision sp)
{
    NvU8 dla_if_sp = 0xFF;
    switch(sp.v()) {
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_FP16:  dla_if_sp = dla_if->pdpOpDescAccessor(0).precision_FP16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT16: dla_if_sp = dla_if->pdpOpDescAccessor(0).precision_Int16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT8:  dla_if_sp = dla_if->pdpOpDescAccessor(0).precision_Int8(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong surface precision provided %s", sp.c_str());
    }
    return dla_if_sp;
}

NvU8 engine_ast::ASTToDLAInterface::getCDPPrecision(DLAInterface* dla_if, surface::SurfacePrecision sp)
{
    NvU8 dla_if_sp = 0xFF;
    switch(sp.v()) {
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_FP16:  dla_if_sp = dla_if->cdpOpDescAccessor(0).inPrecision_FP16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT16: dla_if_sp = dla_if->cdpOpDescAccessor(0).inPrecision_Int8(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT8:  dla_if_sp = dla_if->cdpOpDescAccessor(0).inPrecision_Int8(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong surface precision provided %s", sp.c_str());
    }
    return dla_if_sp;
}

NvU8 engine_ast::ASTToDLAInterface::getPDPMode(DLAInterface* dla_if, nvdla::PoolingType pt)
{
    NvU8 dla_if_pm = 0xFF;
    switch(pt.v()) {
        case nvdla::PoolingType::kAVERAGE: dla_if_pm = dla_if->pdpOpDescAccessor(0).poolMode_AVG(); break;
        case nvdla::PoolingType::kMAX:     dla_if_pm = dla_if->pdpOpDescAccessor(0).poolMode_MAX(); break;
        case nvdla::PoolingType::kMIN:     dla_if_pm = dla_if->pdpOpDescAccessor(0).poolMode_MIN(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong pooling type provided %s", pt.c_str());
    }
    return dla_if_pm;
}

NvS8 engine_ast::ASTToDLAInterface::getEngineType(DLAInterface* dla_if, EngineType et)
{
    NvS8 dla_if_et = -1;

    switch (et.e())
    {
        case EngineTypeEnum::BDMA: dla_if_et        = dla_if->commonOpDescAccessor(0).opType_BDMA(); break;
        case EngineTypeEnum::CDP:  dla_if_et        = dla_if->commonOpDescAccessor(0).opType_CDP(); break;
        case EngineTypeEnum::SDP:  dla_if_et        = dla_if->commonOpDescAccessor(0).opType_SDP(); break;
        case EngineTypeEnum::PDP:  dla_if_et        =  dla_if->commonOpDescAccessor(0).opType_PDP(); break;
        case EngineTypeEnum::CONVOLUTION: dla_if_et =  dla_if->commonOpDescAccessor(0).opType_CONV(); break;
        case EngineTypeEnum::RUBIK:       dla_if_et =  dla_if->commonOpDescAccessor(0).opType_RUBIK(); break;

            // these are emu/cpu/sw engine types which don't map to hardware engines
        case EngineTypeEnum::SPLIT:
        case EngineTypeEnum::CONCATENATION:
        case EngineTypeEnum::CPU:
        case EngineTypeEnum::MULTI_OPS:
            return -1;

        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong EngineType provided %s", et.c_str());
    }
    return dla_if_et;
}

NvU8 engine_ast::ASTToDLAInterface::getOperationEventType(DLAInterface* dla_if, OperationEventType oet)
{
    NvU8 dla_if_cet = 0xFF;
    switch (oet.e()) {
        case OperationEventTypeEnum::OP_PROGRAMMED:       dla_if_cet = dla_if->consumerAccessor(0).event_OpProgrammed(); break;
        case OperationEventTypeEnum::OP_ENABLED:          dla_if_cet = dla_if->consumerAccessor(0).event_OpEnabled(); break;
        case OperationEventTypeEnum::OP_COMPLETED:        dla_if_cet = dla_if->consumerAccessor(0).event_OpCompleted(); break;
        case OperationEventTypeEnum::OP_CDMA_WEIGHT_DONE: dla_if_cet = dla_if->consumerAccessor(0).event_OpCDMAWeightDone(); break;
        case OperationEventTypeEnum::OP_CDMA_DATA_DONE:   dla_if_cet = dla_if->consumerAccessor(0).event_OpCDMADataDone(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong OperationEventType provided %d", oet.v());
    }
    return dla_if_cet;
}

NvU8 engine_ast::ASTToDLAInterface::getDataFormat(DLAInterface* dla_if, surface::SurfaceFormat sf)
{
    NvU8 dla_if_df = 0xFF;
    switch (sf.v()) {
        case surface::SurfaceFormatEnum::NVDLA_IMG_R8:                  dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R10:                 dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R10(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R12:                 dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R12(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R16:                 dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R16(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R16_I:               dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R16_I(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R16_F:               dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R16_F(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A16B16G16R16:        dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A16B16G16R16(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_X16B16G16R16:        dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_X16B16G16R16(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A16B16G16R16_F:      dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A16B16G16R16_F(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A16Y16U16V16:        dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A16Y16U16V16(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_V16U16Y16A16:        dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_V16U16Y16A16(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A16Y16U16V16_F:      dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A16Y16U16V16_F(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A8B8G8R8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A8B8G8R8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A8R8G8B8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A8R8G8B8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_B8G8R8A8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_B8G8R8A8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R8G8B8A8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R8G8B8A8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_X8B8G8R8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_X8B8G8R8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_X8R8G8B8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_X8R8G8B8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_B8G8R8X8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_B8G8R8X8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R8G8B8X8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R8G8B8X8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A2B10G10R10:         dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A2B10G10R10(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A2R10G10B10:         dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A2R10G10B10(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_B10G10R10A2:         dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_B10G10R10A2(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_R10G10B10A2:         dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_R10G10B10A2(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A2Y10U10V10:         dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A2Y10U10V10(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_V10U10Y10A2:         dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_V10U10Y10A2(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_A8Y8U8V8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_A8Y8U8V8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_V8U8Y8A8:            dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_V8U8Y8A8(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y8___U8V8_N444:      dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y8___U8V8_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y8___V8U8_N444:      dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y8___V8U8_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y10___U10V10_N444:   dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y10___U10V10_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y10___V10U10_N444:   dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y10___V10U10_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y12___U12V12_N444:   dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y12___U12V12_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y12___V12U12_N444:   dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y12___V12U12_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y16___U16V16_N444:   dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y16___U16V16_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_IMG_Y16___V16U16_N444:   dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_T_Y16___V16U16_N444(); break;
        case surface::SurfaceFormatEnum::NVDLA_FEATURE_DATA_INT8:
        case surface::SurfaceFormatEnum::NVDLA_FEATURE_DATA_INT16:
        case surface::SurfaceFormatEnum::NVDLA_FEATURE_DATA_FP16:       dla_if_df = dla_if->convOpDescAccessor(0).dataFormat_FEATURE(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Unsupported surface format provided %s", sf.c_str());
    }
    return dla_if_df;
}

NvU8 engine_ast::ASTToDLAInterface::getRubikPrecision(DLAInterface* dla_if, surface::SurfacePrecision sp)
{
    NvU8 dla_if_sp = 0xFF;
    switch(sp.v()) {
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_FP16:  dla_if_sp = dla_if->rubikOpDescAccessor(0).precision_FP16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT16: dla_if_sp = dla_if->rubikOpDescAccessor(0).precision_Int16(); break;
        case surface::SurfacePrecisionEnum::NVDLA_PRECISION_INT8:  dla_if_sp = dla_if->rubikOpDescAccessor(0).precision_Int8(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong surface precision provided %s", sp.c_str());
    }
    return dla_if_sp;
}

NvU8 engine_ast::ASTToDLAInterface::getRubikMode(DLAInterface* dla_if, RubikMode rm)
{
    NvU8 dla_if_rm = 0xFF;
    switch(rm.v()) {
        case RubikModeEnum::RUBIK_MODE_CONTRACT: dla_if_rm = dla_if->rubikOpDescAccessor(0).mode_Contract(); break;
        case RubikModeEnum::RUBIK_MODE_SPLIT:    dla_if_rm = dla_if->rubikOpDescAccessor(0).mode_Split(); break;
        case RubikModeEnum::RUBIK_MODE_MERGE:    dla_if_rm = dla_if->rubikOpDescAccessor(0).mode_Merge(); break;
        default: REPORT_ERROR(NvDlaError_BadParameter, "Wrong rubik mode provided %s", rm.c_str());
    }
    return dla_if_rm;
}
}; // nvdla::priv
}; // nvdla
