package net.abauchu.utils
{
	public class Rope
	{
		private var fibreList:Array;
		private var onRopeCutCallback:Function;
		private var onRopeCutCallbackParameters:Array;
		
		/**
		 * Constructor
		 * 
		 * @param fibre_list A array filled with names. So you can cut specific fibres later.
		 * @param on_rope_cut The function that will get called when all the fibres have been cut. 
		 * @param on_rope_cut_parameters Parameters to pass to on_rope_cut. 
		 */
		public function Rope(fibre_list:Array, on_rope_cut:Function, on_rope_cut_parameters:Array = null)
		{
			if (fibre_list == null) { throw new ArgumentError("fibre_list can't be null"); }
			if (fibre_list.length == 0) { throw new ArgumentError("fibre_list can't be empty"); }
			if (on_rope_cut == null) { throw new ArgumentError("on_rope_cut can't be null"); }
			
			fibreList = fibre_list.concat();
			onRopeCutCallback = on_rope_cut;
			onRopeCutCallbackParameters = on_rope_cut_parameters;
		}
		
		/**
		 * Cuts a specific fibre. If there's no fibre left, the user callback is executed.
		 * Nothing happens if there's no fibre called @param fibre_name.
		 * 
		 * @param fibre_name The name of the fibre.
		 */
		public function cutFibre(fibre_name:String):Boolean
		{
			var index:int = fibreList.indexOf(fibre_name);
			
			if (index == -1) { return false; }
			
			fibreList.splice(index, 1);
			
			if (fibreList.length == 0)
			{
				onRopeCutCallback.apply(null, onRopeCutCallbackParameters);
				return true;
			}
			
			return false;
		}
		
		public function toString():String
		{
			return "Rope fibres: [" + fibreList.toString() + "]";
		}
	}
}
