Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBEE97ABA4
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 08:49:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726555740;
	bh=Vun4PO28i0mmsLNX3QTNk55JwdaRwjIisdNr9s6W8dM=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=b/NGL8C4jh4fJh6VqYjN4suIBMbGpX+MwV62Lhx+++6fz/ATgenEqIvat48C6pXC2
	 P1mup07DyOxrjmwQ5I+MLGdilN0kXLx/svATZ2euUFiL/xsl2Gdu68p3Ckt2j5InXI
	 idLED6gRYxFaqMD5GMZb4nmILuqX9jOVeIhJGs+IGx3D+Pn0GXQcc+SAtwTvnjfzGD
	 HX15FKaCGWV2LUQK+OOX1ePcNs7R29VIfhSD4LinwATq0wnqZZGs0BpjRvWr2C9EOo
	 Cl3yqCWrBVvpRQfL14zY/Pb+A1zPTuLJg6CtaarVi0xvXz+HKbAnoPDeIljpjL6m93
	 br4FLrEKb6jDQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7C700ch9z2yMt
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 16:49:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726555737;
	cv=none; b=RQm0yvxq9e+xpeNS/KRSsnbV17yoJyLj+E8r+5zM5zTskmDrawd+a3UQcfZHAdbB9h7b2+7jvjgUpztOkC4ABFDLEhQ86EkupZy6j5SWvEbjUMoSx9hRwBTru5et+38LJEulbU3jJZBnLdx43Ll6pK+C/N8iJx1+Zpzi3X3o/1qei6s6P5Dl0mIeeGgahSadIZomFLPJfYru9qFmJlXENMZWSvFFNgPIAJDvySonznZX0Z0ulJ5Xk61BVbLWXvh0augZd/dcKMdh0iRQMFNaYtR52TaFc1God01oRgVcFUx95LbFmDdyvJJ0OJdyUyiwAe9LE8rPflr3JG6PZlr1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726555737; c=relaxed/relaxed;
	bh=Vun4PO28i0mmsLNX3QTNk55JwdaRwjIisdNr9s6W8dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt4omrwAymKkBLcV9WO7E7GAhor5swi0nO0AP5nnQ2FPv/6RAI2jX7SRVHfeDgCo//CL/GtHt52/gxyIMybgeBlwpRlpQTlfCd1UZUTUclkycpw4hPNYZVRd+QYDwQBm4pB/7q3vy3Spvr+pmn6Dri10RmbpQUlN67zzKZnA9Ls+hFPxvshLYdMsHccI6Uqtm7Ut+8Wwy3cOLGEcmA7F77RLmpRAcpUOA/OTcXJs+0dL+0TDKUZ+vNEgoCb1ZegdhtX7wApvGbXOYSU2WNx0I9za3UvD/WhpvO8rLrPxI/1uOrISzgBDIC8IR+ukODPmvHxmgdTwsHCtbAzaz2mkCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=UlY6F3xS; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=UlY6F3xS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7C6x2bwWz2xWt
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 16:48:57 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6049697D1;
	Tue, 17 Sep 2024 02:48:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726555733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Vun4PO28i0mmsLNX3QTNk55JwdaRwjIisdNr9s6W8dM=;
	b=UlY6F3xSPENoOScyRvJyD/lb0LsHJnxP5PAj9oQJksih2Zy6kPXaVqlKOm/6Sc1GlxgcGR
	L/C87vKY8I77AVCk5ZD9ejeV607hMzhOophmgBaKEzP0C+89UcflczYE93rvW6Kr/G30Hs
	TLJGlqNuVHEgfxQoPgIIT8w68akuSPcQgYJXDVxir0fcm6XnwTL2nwymyrbcbV1kojHjfL
	wGSyh+3y5eSrgXaB2SkZaUMuWDCPTeZoZ9sxvFYtwAzajUGlr8tuN+1k0LCH3+8qbHw9PW
	0CDSA1RbYQ73J9Xgm4THjv/dUb91fAq3A2Mqo5G6nZcAVdQEva6kCG74xXmpEQ==
Date: Tue, 17 Sep 2024 14:48:34 +0800
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
 <20240916170801.GO2825852@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916170801.GO2825852@ZenIV>
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 16, 2024 at 06:08:01PM GMT, Al Viro wrote:
> On Mon, Sep 16, 2024 at 09:56:29PM +0800, Yiyang Wu wrote:
> > +/// Lookup function for dentry-inode lookup replacement.
> > +#[no_mangle]
> > +pub unsafe extern "C" fn erofs_lookup_rust(
> > +    k_inode: NonNull<inode>,
> > +    dentry: NonNull<dentry>,
> > +    _flags: c_uint,
> > +) -> *mut c_void {
> > +    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
> > +    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
> 
> 	Ummm...  A wrapper would be highly useful.  And the reason why
> it's safe is different - your function is called only via ->i_op->lookup,
> the is only one instance of inode_operations that has that ->lookup
> method, and the only place where an inode gets ->i_op set to that
> is erofs_fill_inode().  Which is always passed erofs_inode::vfs_inode.
> 
So my original intention behind this is that all vfs_inodes come from
that erofs_iget function and it's always gets initialized in this case
And this just followes the same convention here. I can document this
more precisely.
> > +    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
> > +    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
> 
> 	Again, that calls for a wrapper - this time not erofs-specific;
> inode->i_sb is *always* non-NULL, is assign-once and always points
> to live struct super_block instance at least until the call of
> destroy_inode().
>

Will be modified correctly, I'm not a native speaker and I just can't
find a better way, I will take my note here.
> > +    // SAFETY: this is backed by qstr which is c representation of a valid slice.
> 
> 	What is that sentence supposed to mean?  Nevermind "why is it correct"...
> 
> > +    let name = unsafe {
> > +        core::str::from_utf8_unchecked(core::slice::from_raw_parts(
> > +            dentry.as_ref().d_name.name,
> > +            dentry.as_ref().d_name.__bindgen_anon_1.__bindgen_anon_1.len as usize,
> 
> 	Is that supposed to be an example of idiomatic Rust?  I'm not
> trying to be snide, but my interest here is mostly about safety of
> access to VFS data structures.	And ->d_name is _very_ unpleasant in
> that respect; the locking rules required for its stability are subtle
> and hard to verify on manual code audit.
> 
Yeah, this code is pretty messed up. I just cannot find a better
way to use this qstr in dentry. So the original C qstr is this.

```c
struct qstr {
	union {
		struct {
			HASH_LEN_DECLARE;
		};
		u64 hash_len;
	};
	const unsigned char *name;
};

```
The original C code can use this pretty easily.

```C
int erofs_namei(struct inode *dir, const struct qstr *name, erofs_nid_t *nid,
		unsigned int *d_type)
{
	int ndirents;
	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
	struct erofs_dirent *de;
	struct erofs_qstr qn;

	if (!dir->i_size)
		return -ENOENT;

	qn.name = name->name;
	qn.end = name->name + name->len;
	buf.mapping = dir->i_mapping;

```

But after bindgen, since Rust does not support any kinds of anonymous
unions here it just converts to this.

```rust
#[repr(C)]
#[derive(Copy, Clone)]
pub struct qstr {
    pub __bindgen_anon_1: qstr__bindgen_ty_1,
    pub name: *const core::ffi::c_uchar,
}

#[repr(C)]
#[derive(Copy, Clone)]
pub union qstr__bindgen_ty_1 {
    pub __bindgen_anon_1: qstr__bindgen_ty_1__bindgen_ty_1,
    pub hash_len: u64_,
}

```
And it just somehow degrades to this pure mess. :(
I know this is stupid :(

> 	Current erofs_lookup() (and your version as well) *is* indeed
> safe in that respect, but the proof (from filesystem POV) is that "it's
> called only as ->lookup() instance, so dentry is initially unhashed
> negative and will remain such until it's passed to d_splice_alias();
> until that point it is guaranteed to have ->d_name and ->d_parent stable".
> 
> 	Note that once you _have_ called d_splice_alias(), you can't
> count upon the ->d_name stability - or, indeed, upon ->d_name.name you've
> sampled still pointing to allocated memory.
> 
> 	For directory-modifying methods it's "stable, since parent is held
> exclusive".  Some internal function called from different environments?
> Well...  Swear, look through the call graph and see what can be proven
> for each.

Sorry for my ignorance.
I mean i just borrowed the code from the fs/erofs/namei.c and i directly
translated that into Rust code. That might be a problem that also
exists in original working C code.

> 	Expressing that kind of fun in any kind of annotations (Rust type
> system included) is not pleasant.  _Probably_ might be handled by a type
> that would be a dentry pointer with annotation along the lines "->d_name
> and ->d_parent of that one are stable".  Then e.g. ->lookup() would
> take that thing as an argument and d_splice_alias() would consume it.
> ->mkdir() would get the same thing, etc.  I hadn't tried to get that
> all way through (the amount of annotation churn in existing filesystems
> would be high and hard to split into reviewable patch series), so there
> might be dragons - and there definitely are places where the stability is
> proven in different ways (e.g. if dentry->d_lock is held, we have the damn
> thing stable; then there's a "take a safe snapshot of name" API; etc.).

That's kinda interesting, I originally thought that VFS will make sure
its d_name / d_parent is stable in the first place.
Again, I just don't have a full picture or understanding of VFS and my
code is just basic translation of original C code, Maybe we can address
this later.

> 	I want to reduce the PITA of regular code audits.  If, at
> some point, Rust use in parts of the tree reduces that - wonderful.
> But then we'd better make sure that Rust-side uses _are_ safe, accurately
> annotated and easy to grep for.

Yeah, even a small portion of VFS gets abstracted can get things work
smoothly, like inode and dentry data structure. From my understanding
Rust can make some of stability issues you have mentioned
compilation errors if it's correctly annotated.

> Because we'll almost certainly need to
> change method calling conventions at some points through all of that.
> Even if it's just the annotation-level, any such contract change (it
> is doable and quite a few had been done) will require going through
> the instances and checking how much massage will be needed in those.
> Opaque chunks like the above promise to make that very painful...

Certainly needs a lot of energy and efforts.
WE just need a guy who has full grasp of a lot of filesystems and Rust
to solve this stuff altogether to avoid the abstraction degraded
into some toy concepts.
