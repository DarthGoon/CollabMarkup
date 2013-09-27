using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SignalRProto.Models
{
    public static class FauxDb
    {
        private static Queue<string> holder = new Queue<string>();

        public static void Push(string coords)
        {
            holder.Enqueue(coords);
        }

        public static string[] Pull()
        {
            return holder.ToArray();
        }

        public static void Clear()
        {
            holder = new Queue<string>();
        }
    }
}