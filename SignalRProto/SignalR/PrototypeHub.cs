using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using SignalR.Hubs;
using SignalRProto.Models;

namespace SignalRProto.SignalR
{
    [HubName("prototypeHub")]
    public class PrototypeHub : Hub, IConnected
    {
        public void SendText(string data)
        {
            var line = string.Format("{0:HH:mm:ss} {2}: {1}", DateTime.Now, data, Caller.User);
            FauxDb.Push(line);
            Clients.displayData(line);
        }

        public void SendDrawing(string x, string y)
        {
            var coords = string.Format("{0}:{1}", x, y);
            FauxDb.Push(coords);
            Clients.draw(coords, Caller.User);
        }

        public void ClearCanvas()
        {
            FauxDb.Clear();
        }

        public void StartDraw()
        {
            Clients.startPath(Caller.User);
        }

        public void EndDraw()
        {
            FauxDb.Push(string.Empty);
            Clients.endPath(Caller.User);
        }

        public Task Connect()
        {
            return Caller.rePlay(FauxDb.Pull());
        }

        public Task Reconnect(IEnumerable<string> groups)
        {
            return null;
        }
    }
}