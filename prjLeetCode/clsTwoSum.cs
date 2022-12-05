namespace prjLeetCode
{
    internal class clsTwoSum
    {
        public void Start()
        {
            //test case
            int[] nums = { 3, 2, 4 };
            int target = 6;

            //main
            var result = TwoSum(nums, target);

            //result
            Console.Write("result = {");
            for (var i = 0; i < result.Length; i++)
            {
                if (i != result.Length - 1)
                    Console.Write(i + ",");
                else
                    Console.Write(i);
            }
            Console.Write("}");
            Console.WriteLine();
        }

        public int[] TwoSum(int[] nums, int target)
        {
            for (var i = 0; i < nums.Length; i++)
            {
                for (var j = i + 1; j < nums.Length; j++)
                {
                    if (nums[i] + nums[j] == target)
                    {
                        return new int[] { i, j };
                    }
                }
            }
            return new int[] { 0, 0 };
        }
    }
}

