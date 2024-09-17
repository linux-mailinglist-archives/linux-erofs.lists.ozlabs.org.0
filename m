Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1997ABE5
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 09:15:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7CjJ5wMcz2yMv
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 17:15:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726557314;
	cv=none; b=WEVVU8Vpj0uv6NNF4HNvoqBjsdmfGPVU9mBKMCZcySGZgyG3/I61AIzEDNkpnjoinn7RAUi05lZ28wPWQRi2QTr3vdpzLjRke1Rcx9frZ5pKa+vnF0YKU9PKWx4znPzpD6bv9J3ciHNvRwL1iZG4mX4bQNZMQl0eaOJyVPZv8iUrfnYPXuR6fQPqHhGjj7ixwdKJMqnTlKYw/MqHOCiRrt6vRIwDUg24cRKvPOS4tLq1zFSzsd0B4jChb3CRhBeNbF2RplRAk+Pn99XI2Q2UWeZ/GbfTQNO1CmJMsxz2PH8FQThd7+00MJyJVTW8k3vS8e0ScvMp1bHT9uE0CvU/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726557314; c=relaxed/relaxed;
	bh=aHmQE7AUQfpWpDBPMmGmaaJMlBjlx8yVsf52qbqS98k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjnW7KYnV7+ETST7bMF83gJufjE/qYdC25jBl2sqvvn9HaPZVHqq7biueNakTD160dYJQJZgewSaEDCnAAFsREIOIcAtYHGXVDYlaWXGeiG37bq4irbfrRmyPtkbhDLBv292Yr+s4GK5BGBitrVj2hZ52GBvgLRjQJaeoE9UhToy/SMzx6xMJnRGAEQeOTyr2L9F7b43GsvuTCWTrtCsUcYgKNgOU3B4o+ZCO9JIdsy5CFcYcpQeRa4gGFZwxfeJ02svoeaqapI5tR9+5qinSG1YUx4TWblfX+fo5qfZohmJrU+a2k03N4G6nmjDNHSh9E0kqt7SmDq3IX9A1xUUtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JBsVrCkU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JBsVrCkU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7Cj947Cjz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 17:15:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726557301; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aHmQE7AUQfpWpDBPMmGmaaJMlBjlx8yVsf52qbqS98k=;
	b=JBsVrCkUji0WCaOzPMXTgOujrDiO8+VYZrAgaxArhqSj12WFg7Kb7TMuu24h0okGrymWpora77mhL85CJ266IdlJP+Kb6zCVx0HP7Fbp+dyHK54wb+L6SJhbQB+FO7alhIa7NoiGYdM5DoEOBqHLBlaKbhXGc0xXWkmdQa3DCxY=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFACzIr_1726557298)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 15:15:00 +0800
Message-ID: <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
Date: Tue, 17 Sep 2024 15:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
To: Yiyang Wu <toolmanp@tlmp.cc>, Al Viro <viro@zeniv.linux.org.uk>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc> <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2024/9/17 14:48, Yiyang Wu wrote:
> On Mon, Sep 16, 2024 at 06:08:01PM GMT, Al Viro wrote:
>> On Mon, Sep 16, 2024 at 09:56:29PM +0800, Yiyang Wu wrote:
>>> +/// Lookup function for dentry-inode lookup replacement.
>>> +#[no_mangle]
>>> +pub unsafe extern "C" fn erofs_lookup_rust(
>>> +    k_inode: NonNull<inode>,
>>> +    dentry: NonNull<dentry>,
>>> +    _flags: c_uint,
>>> +) -> *mut c_void {
>>> +    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
>>> +    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
>>
>> 	Ummm...  A wrapper would be highly useful.  And the reason why
>> it's safe is different - your function is called only via ->i_op->lookup,
>> the is only one instance of inode_operations that has that ->lookup
>> method, and the only place where an inode gets ->i_op set to that
>> is erofs_fill_inode().  Which is always passed erofs_inode::vfs_inode.
>>
> So my original intention behind this is that all vfs_inodes come from
> that erofs_iget function and it's always gets initialized in this case
> And this just followes the same convention here. I can document this
> more precisely.

I think Al just would like a wrapper here, like the current C EROFS_I().

>>> +    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
>>> +    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
>>
>> 	Again, that calls for a wrapper - this time not erofs-specific;
>> inode->i_sb is *always* non-NULL, is assign-once and always points
>> to live struct super_block instance at least until the call of
>> destroy_inode().
>>
> 
> Will be modified correctly, I'm not a native speaker and I just can't
> find a better way, I will take my note here.

Same here, like the current EROFS_I_SB().

>>> +    // SAFETY: this is backed by qstr which is c representation of a valid slice.
>>
>> 	What is that sentence supposed to mean?  Nevermind "why is it correct"...
>>
>>> +    let name = unsafe {
>>> +        core::str::from_utf8_unchecked(core::slice::from_raw_parts(
>>> +            dentry.as_ref().d_name.name,
>>> +            dentry.as_ref().d_name.__bindgen_anon_1.__bindgen_anon_1.len as usize,
>>

...

> 
>> 	Current erofs_lookup() (and your version as well) *is* indeed
>> safe in that respect, but the proof (from filesystem POV) is that "it's
>> called only as ->lookup() instance, so dentry is initially unhashed
>> negative and will remain such until it's passed to d_splice_alias();
>> until that point it is guaranteed to have ->d_name and ->d_parent stable".

Agreed.

>>
>> 	Note that once you _have_ called d_splice_alias(), you can't
>> count upon the ->d_name stability - or, indeed, upon ->d_name.name you've
>> sampled still pointing to allocated memory.
>>
>> 	For directory-modifying methods it's "stable, since parent is held
>> exclusive".  Some internal function called from different environments?
>> Well...  Swear, look through the call graph and see what can be proven
>> for each.
> 
> Sorry for my ignorance.
> I mean i just borrowed the code from the fs/erofs/namei.c and i directly
> translated that into Rust code. That might be a problem that also
> exists in original working C code.

As for EROFS (an immutable fs), I think after d_splice_alias(), d_name is
still stable (since we don't have rename semantics likewise for now).

But as the generic filesystem POV, d_name access is actually tricky under
RCU walk path indeed.

> 
>> 	Expressing that kind of fun in any kind of annotations (Rust type
>> system included) is not pleasant.  _Probably_ might be handled by a type
>> that would be a dentry pointer with annotation along the lines "->d_name
>> and ->d_parent of that one are stable".  Then e.g. ->lookup() would
>> take that thing as an argument and d_splice_alias() would consume it.
>> ->mkdir() would get the same thing, etc.  I hadn't tried to get that
>> all way through (the amount of annotation churn in existing filesystems
>> would be high and hard to split into reviewable patch series), so there
>> might be dragons - and there definitely are places where the stability is
>> proven in different ways (e.g. if dentry->d_lock is held, we have the damn
>> thing stable; then there's a "take a safe snapshot of name" API; etc.).
> 
> That's kinda interesting, I originally thought that VFS will make sure
> its d_name / d_parent is stable in the first place.
> Again, I just don't have a full picture or understanding of VFS and my
> code is just basic translation of original C code, Maybe we can address
> this later.

d_alloc will allocate an unhashed dentry which is almost unrecognized
by VFS dcache (d_name is stable of course).

After d_splice_alias() and d_add(), rename() could change d_name.  So
either we take d_lock or with rcu_read_lock() to take a snapshot of
d_name in the RCU walk path.  That is my overall understanding.

But for EROFS, since we don't have rename, so it doesn't matter.

Thanks,
Gao Xiang
