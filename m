Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABE97AC1B
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 09:32:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7D4d3vVcz2yMt
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 17:32:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726558317;
	cv=none; b=EyAE+ouvzQKsLHwU/xNS/JgaJqX+5djx5T/59Q9/flMgW+xJ+dYA4EwNElRxM711apnE9XXx7eR5rC/uEtZXAYa5DF/zcHiAnfHUpaGXbAFGV459veWOG5IFiiQoSm5TgvbLIxdLF+4JHEgjEbIAuqfJ1BhoC1ytIvzaB2yNs471JELn2udK8amEQV9Dicb3P+j6yzLiFgkfaiYMcb+8kxZXxeuOZVmSTAd+QeuTfd0kPyj4SVUHcJI08ia3ZDRaPexFdErnAjnvm2Ni8UbEE1kMsYUsCDTOINf9UTPlOUQwKPmEDGB4by77rPj6i8o4EvYIvn55Apd65EOcc633jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726558317; c=relaxed/relaxed;
	bh=aIMhUWWq9rqgGhPY2VuiSSHKl/hha3jBQJx8yropvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTq4Reg0SCUqBZNsjQ103GLW/h3WpldmqPMB9m9ajjYj0PayGgQGivOcOQFNHDt7zUEhgS2eQAorMN6fCl8QU6rziXnfoA9pG1UeVegOeki6oXKVVH5bFkj9/GIxUv3fer+e2UTHOaxUJJeSpu36n3/J/WO/7AaI3lpTEm/P+S2T9CtlJXTVSuhI9RcFZ/SXNEmlkPahDFH8Ff0o2tTKr2aBcksBmQs+HJ4JD94DZ6/W0F/CWxUyfv5vY/Fv8vFDxhx7tTq2LPwUAk1BMY9zRjtsVGrpxikO7GHumShY3WkJv/wG2jYls0bDH4O7NYs3VcsQUgMfMdB7REs87pNRUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=uKU/XHaD; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=uKU/XHaD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7D4Y3czyz2xb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 17:31:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aIMhUWWq9rqgGhPY2VuiSSHKl/hha3jBQJx8yropvhE=; b=uKU/XHaDlrrCrGvkBP1Hb3jFyw
	lfuTfqWG3i769JpiZuDgrQa3f93FWfUCFsW5W1s8nOF3VylS+mKgIbGex5PX0FOud1T1xH1o5RZK2
	oTKrNRYuEHpT/o6oHutO6d1cTMgvMiH4Yr7HZmsR5iHNGk0YDtAq5WEeGrKt9Ga9e+TjCVODpvyj/
	9o8KYL1edUcA+z9tPkKATd8MOBGaDIxWUsRhyp5ZTpAGk5D9Ozngs2qCp49kSmMYWeTVASJLtNGP0
	xi8khufRgQCA1yyXB55L3zuIjVyLviejrudXqHfK2LUcTSi1KhmWybuOV9ULwkOo16VFCugvbQrRx
	iDQYH1Dg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqSgg-0000000D88n-00RL;
	Tue, 17 Sep 2024 07:31:50 +0000
Date: Tue, 17 Sep 2024 08:31:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Message-ID: <20240917073149.GD3107530@ZenIV>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc>
 <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
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

On Tue, Sep 17, 2024 at 03:14:58PM +0800, Gao Xiang wrote:

> > Sorry for my ignorance.
> > I mean i just borrowed the code from the fs/erofs/namei.c and i directly
> > translated that into Rust code. That might be a problem that also
> > exists in original working C code.
> 
> As for EROFS (an immutable fs), I think after d_splice_alias(), d_name is
> still stable (since we don't have rename semantics likewise for now).

Even on corrupted images?  If you have two directories with entries that
act as hardlinks to the same subdirectory, and keep hitting them on lookups,
it will have to transplant the subtree between the parents.

> But as the generic filesystem POV, d_name access is actually tricky under
> RCU walk path indeed.

->lookup() is never called in RCU mode.

> > That's kinda interesting, I originally thought that VFS will make sure
> > its d_name / d_parent is stable in the first place.
> > Again, I just don't have a full picture or understanding of VFS and my
> > code is just basic translation of original C code, Maybe we can address
> > this later.
> 
> d_alloc will allocate an unhashed dentry which is almost unrecognized
> by VFS dcache (d_name is stable of course).
> 
> After d_splice_alias() and d_add(), rename() could change d_name.  So
> either we take d_lock or with rcu_read_lock() to take a snapshot of
> d_name in the RCU walk path.  That is my overall understanding.

No, it's more complicated than that, sadly.  ->d_name and ->d_parent are
the trickiest parts of dentry field stability.

> But for EROFS, since we don't have rename, so it doesn't matter.

See above.  IF we could guarantee that all filesystem images are valid
and will remain so, life would be much simpler.
