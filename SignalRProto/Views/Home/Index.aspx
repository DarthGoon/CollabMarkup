<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ScriptsSection">
    <script type="text/javascript">
        $(function () {
            $.ajaxSetup({ cache: false });

            var protoHub = $.connection.prototypeHub;

            var drawing;
            var canvasCtx = $("#sketch")[0].getContext('2d');

            $("#sketch").on("mousedown", function (e) {
                drawing = true;
                if (!protoHub.User) {
                    protoHub.User = $("#username").val();
                }
                canvasCtx.beginPath();
                protoHub.startDraw();
            });
            $("#sketch").on("mouseup", function (e) {
                drawing = false;
                canvasCtx.closePath();
                protoHub.endDraw();
            });
            $("#sketch").on("mousemove", function (e) {
                var x, y;
                if (drawing) {
                    if (e.offsetX) {
                        x = e.offsetX;
                        y = e.offsetY;
                    } else if (e.layerX) {
                        x = e.layerX;
                        y = e.layerY;
                    }
                    protoHub.sendDrawing(x, y);
                    canvasCtx.lineTo(x, y);
                    canvasCtx.stroke();
                }
            });

            protoHub.rePlay = function (data) {
                if (data.length == 0) {
                    return;
                }
                var newctx = canvasCtx;
                setTimeout(function () {
                    newctx.beginPath();
                    var i = 0;
                    var id = setInterval(function () {
                        if (i < data.length && data[i] != null && data[i] != "") {
                            var coord = data[i].split(':');
                            newctx.lineTo(coord[0], coord[1]);
                            newctx.stroke();
                            i++;
                        } else if (data[i] == "") {
                            newctx.closePath();
                            newctx.beginPath();
                            i++;
                        }
                        else {
                            newctx.closePath();
                            clearInterval(id);
                        }
                    }, 5);
                }, 0);
            };

            protoHub.draw = function (data, user) {
                if (protoHub.User == user) {
                    return;
                }
                var coord = data.split(':');
                canvasCtx.lineTo(coord[0], coord[1]);
                canvasCtx.stroke();
            };

            protoHub.startPath = function (user) {
                if (protoHub.User == user) {
                    return;
                }
                canvasCtx.beginPath();
            };

            protoHub.endPath = function (user) {
                if (protoHub.User == user) {
                    return;
                }
                canvasCtx.closePath();
            };

            $("#clearcanvas").click(function (evt) {
                protoHub.clearCanvas();
                
                canvasCtx.save();
                canvasCtx.setTransform(1, 0, 0, 1, 0, 0);
                canvasCtx.clearRect(0, 0, $("#sketch")[0].width, $("#sketch")[0].height);
                canvasCtx.restore();
            });

            $.connection.hub.start();
        });
    </script>
</asp:Content>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    Enter a Username before you do anything<input type="text" id="username"/>
    <a href="javascript:void(0);" id="clearcanvas">Clear Canvas</a>
    <%--
    <br/>
    <input type="text" id="txtbox"/><a href="javascript:void(0);" id="linkbutton">Send Text</a>
    <textarea id="chatter" rows="10"></textarea>
    <br/>--%>
    <canvas id="sketch" width="800" height="600" style="border: 2px solid black;"></canvas>

</asp:Content>
