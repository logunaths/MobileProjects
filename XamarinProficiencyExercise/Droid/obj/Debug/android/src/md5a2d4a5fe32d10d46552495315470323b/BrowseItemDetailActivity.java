package md5a2d4a5fe32d10d46552495315470323b;


public class BrowseItemDetailActivity
	extends md5a2d4a5fe32d10d46552495315470323b.BaseActivity
	implements
		mono.android.IGCUserPeer
{
/** @hide */
	public static final String __md_methods;
	static {
		__md_methods = 
			"n_onCreate:(Landroid/os/Bundle;)V:GetOnCreate_Landroid_os_Bundle_Handler\n" +
			"n_onStart:()V:GetOnStartHandler\n" +
			"n_onStop:()V:GetOnStopHandler\n" +
			"";
		mono.android.Runtime.register ("TestSample.Droid.BrowseItemDetailActivity, TestSample.Droid", BrowseItemDetailActivity.class, __md_methods);
	}


	public BrowseItemDetailActivity ()
	{
		super ();
		if (getClass () == BrowseItemDetailActivity.class)
			mono.android.TypeManager.Activate ("TestSample.Droid.BrowseItemDetailActivity, TestSample.Droid", "", this, new java.lang.Object[] {  });
	}


	public void onCreate (android.os.Bundle p0)
	{
		n_onCreate (p0);
	}

	private native void n_onCreate (android.os.Bundle p0);


	public void onStart ()
	{
		n_onStart ();
	}

	private native void n_onStart ();


	public void onStop ()
	{
		n_onStop ();
	}

	private native void n_onStop ();

	private java.util.ArrayList refList;
	public void monodroidAddReference (java.lang.Object obj)
	{
		if (refList == null)
			refList = new java.util.ArrayList ();
		refList.add (obj);
	}

	public void monodroidClearReferences ()
	{
		if (refList != null)
			refList.clear ();
	}
}
