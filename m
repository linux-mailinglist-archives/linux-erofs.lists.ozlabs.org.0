Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D1197A674
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 19:08:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6rw228Sxz2yQl
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 03:08:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726506493;
	cv=none; b=brgcjMCbCyjATl8AmF6RXXDf98We1zPwrm1ku5fdc3LwICoJhqpvdQChyPk6zMToDsLL7Z1ZCgxcXZUuPpwfx8zq/t0yaOZnzESj0izm3cHoNAdPbq29B0HDH45L4fi9DzuuqxFIp8Yy8m5vMYflK0iy2HAEIh/n71ejcua/d9QPwBjMvzIff6kMlcCwXkWYtp2l68VltUVHHRntFTqyUMvuIQBJyRjKuiiNxAjidbfAkKqSu8mSyP7gK2h7JAgLdDynWTIOiVW4SenwflhqXYFRPTmkSPAKkdL79VSqPY4eyAHzfzOOY+W8lpAe9w5i9K8mV0YD/knehLvm09FY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726506493; c=relaxed/relaxed;
	bh=e/xlYRrSDit/b/g6M8c4bdxRyyK3CLNhHmufMU5+ieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfHbMYHuwmkY/XgNGqo74yNd4pU7cM7izI+GLVN1WLasPW5RD2Tv1dHimMbSjcCZrgwAG5IEx9fNtCZZdgUAJtfVn1G+Fn2o9099U9ywCUcxF2fzvebGoeFA6YuABpnbgTPDG/EXRl2Q8H4zttrqriOdFUUSWGAdGxGNjIMYBpArRl25A4rUjwscHTSAxiIiiwrcpRyy1ye8feC1CTGNb49IWth8YxbLsWzr4exMX/bvmmQXrmazUuqrsuISx8xjpR3oAtiK3C7ui8Q8z73wlw+pGEuO3MBZdsmHloY+BdcEL3M8HhVjWaHg02FSb7tKIv+rxmVHRIdLUe7QdNYAxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=JIdHZtnl; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=JIdHZtnl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6rvv0XZ9z2x9W
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 03:08:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e/xlYRrSDit/b/g6M8c4bdxRyyK3CLNhHmufMU5+ieg=; b=JIdHZtnlwMLdbu7oYdbKGigkqw
	4s1ccsqYW4bnNBcYLSY3BZe0ZJ/kopW5iM2sTrVkXUF4UDsORvVSyYpnLSmQ36LavMlQVljMR/wcI
	PTej5tPu6Wgrs4U9MAze6XiUffWeoCpMikl6Gb1WmMj7wnMT2+YRtvBlyxNXJ5PwGkvMnpTA7ANMy
	93i7Je6/dfBFOtYGaaH48RIaVYTAX0exIEWJ6uddRxIBvbFgY23MynS5G8/GiIjqmJLWI+xNnVWsW
	Gs+rASaVBVMMkqN16nKduyt0D447xA575Ab1H4OZQ+kITSZzADlYgmlyKhNtsHnOYGSbhZWXBKqjn
	JzzcFJ2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqFCj-0000000D14P-0QWH;
	Mon, 16 Sep 2024 17:08:01 +0000
Date: Mon, 16 Sep 2024 18:08:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yiyang Wu <toolmanp@tlmp.cc>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <20240916170801.GO2825852@ZenIV>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916135634.98554-20-toolmanp@tlmp.cc>
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 16, 2024 at 09:56:29PM +0800, Yiyang Wu wrote:
> +/// Lookup function for dentry-inode lookup replacement.
> +#[no_mangle]
> +pub unsafe extern "C" fn erofs_lookup_rust(
> +    k_inode: NonNull<inode>,
> +    dentry: NonNull<dentry>,
> +    _flags: c_uint,
> +) -> *mut c_void {
> +    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
> +    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };

	Ummm...  A wrapper would be highly useful.  And the reason why
it's safe is different - your function is called only via ->i_op->lookup,
the is only one instance of inode_operations that has that ->lookup
method, and the only place where an inode gets ->i_op set to that
is erofs_fill_inode().  Which is always passed erofs_inode::vfs_inode.

> +    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
> +    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });

	Again, that calls for a wrapper - this time not erofs-specific;
inode->i_sb is *always* non-NULL, is assign-once and always points
to live struct super_block instance at least until the call of
destroy_inode().

> +    // SAFETY: this is backed by qstr which is c representation of a valid slice.

	What is that sentence supposed to mean?  Nevermind "why is it correct"...

> +    let name = unsafe {
> +        core::str::from_utf8_unchecked(core::slice::from_raw_parts(
> +            dentry.as_ref().d_name.name,
> +            dentry.as_ref().d_name.__bindgen_anon_1.__bindgen_anon_1.len as usize,

	Is that supposed to be an example of idiomatic Rust?  I'm not
trying to be snide, but my interest here is mostly about safety of
access to VFS data structures.	And ->d_name is _very_ unpleasant in
that respect; the locking rules required for its stability are subtle
and hard to verify on manual code audit.

	Current erofs_lookup() (and your version as well) *is* indeed
safe in that respect, but the proof (from filesystem POV) is that "it's
called only as ->lookup() instance, so dentry is initially unhashed
negative and will remain such until it's passed to d_splice_alias();
until that point it is guaranteed to have ->d_name and ->d_parent stable".

	Note that once you _have_ called d_splice_alias(), you can't
count upon the ->d_name stability - or, indeed, upon ->d_name.name you've
sampled still pointing to allocated memory.

	For directory-modifying methods it's "stable, since parent is held
exclusive".  Some internal function called from different environments?
Well...  Swear, look through the call graph and see what can be proven
for each.

	Expressing that kind of fun in any kind of annotations (Rust type
system included) is not pleasant.  _Probably_ might be handled by a type
that would be a dentry pointer with annotation along the lines "->d_name
and ->d_parent of that one are stable".  Then e.g. ->lookup() would
take that thing as an argument and d_splice_alias() would consume it.
->mkdir() would get the same thing, etc.  I hadn't tried to get that
all way through (the amount of annotation churn in existing filesystems
would be high and hard to split into reviewable patch series), so there
might be dragons - and there definitely are places where the stability is
proven in different ways (e.g. if dentry->d_lock is held, we have the damn
thing stable; then there's a "take a safe snapshot of name" API; etc.).

	I want to reduce the PITA of regular code audits.  If, at
some point, Rust use in parts of the tree reduces that - wonderful.
But then we'd better make sure that Rust-side uses _are_ safe, accurately
annotated and easy to grep for.  Because we'll almost certainly need to
change method calling conventions at some points through all of that.
Even if it's just the annotation-level, any such contract change (it
is doable and quite a few had been done) will require going through
the instances and checking how much massage will be needed in those.
Opaque chunks like the above promise to make that very painful...
