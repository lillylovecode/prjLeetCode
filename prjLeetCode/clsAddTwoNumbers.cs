namespace prjLeetCode
{
    internal class clsAddTwoNumbers
    {
        public void Start()
        {
            var l1 = new ListNode() { val = 2, next = new ListNode { val = 4, next = new ListNode { val = 3 } } };
            var l2 = new ListNode() { val = 5, next = new ListNode { val = 6, next = new ListNode { val = 4 } } };
            ListNode result = AddTwoNumbers(l1, l2);
        }

        public ListNode AddTwoNumbers(ListNode l1, ListNode l2)
        {
            #region v1 轉成數字相加
            //string str1 = "";

            //while (l1 != null)
            //{
            //    str1 += l1.val.ToString();
            //    l1 = l1.next;
            //}

            //string str2 = "";

            //while (l2 != null)
            //{
            //    str2 += l2.val.ToString();
            //    l2 = l2.next;
            //}

            //string sum = (Convert.ToInt64(str1) + Convert.ToInt64(str2)).ToString();

            //Console.WriteLine($"sum = {sum}");

            //char[] charArray = sum.ToCharArray();

            //Array.Reverse(charArray);

            //string strCharArray = "";
            //foreach (var i in charArray)
            //{
            //    strCharArray += i;
            //}

            //Console.WriteLine($"strCharArray =[{strCharArray}]");

            //ListNode resNode = new ListNode();

            //addNode(strCharArray, ref resNode);

            //return resNode;
            #endregion
            #region v2 每個節點自己相加(超過10要判斷進位)
            ListNode resNode = new ListNode(0); //reslut
            ListNode temp = resNode;

            //兩節點相加
            int sum = 0;

            while (l1 != null || l2 != null)
            {
                sum /= 10; //sum最多不超過10

                if (l1 != null)
                {
                    sum += l1.val;
                    l1 = l1.next; //換到下一個節點
                }

                if (l2 != null)
                {
                    sum += l2.val;
                    l2 = l2.next;
                }

                temp.next = new ListNode(sum % 10); //判斷進位 0-9存進val
                temp = temp.next;

                //如果有進位就新增下一個節點 val=1
                if (sum / 10 == 1)
                {
                    temp.next = new ListNode(1);
                }                
            }

            return resNode.val == 0 ? resNode.next : resNode;
            #endregion
            //test
        }

        #region v1 function
        //public void addNode(string strCharArray, ref ListNode listNode)
        //{
        //    if (strCharArray.Length > 0)
        //    {
        //        listNode.val = Convert.ToInt32(strCharArray.Substring(0, 1));
        //        strCharArray = strCharArray.Remove(0, 1);
        //        if (strCharArray.Length > 0)
        //        {
        //            listNode.next = new ListNode();
        //            addNode(strCharArray, ref listNode.next);
        //        }
        //    }

        //}
        #endregion 
    }



    public class ListNode
    {
        public int val;
        public ListNode next;
        public ListNode(int val = 0, ListNode next = null)
        {
            this.val = val;
            this.next = next;
        }
    }
}
