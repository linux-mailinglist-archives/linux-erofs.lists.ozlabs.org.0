Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E2022874A08
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 09:46:27 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=IBzj6REx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr2w12s3vz3dX6
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 19:46:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=IBzj6REx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr2vx3CnVz2yVd
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 19:46:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oieFStbvkFT9rV4WJJTmWpFLLGbMeU8DfdLJw5moAO4=; b=IBzj6REx7hZVeSsZnjVykFhDBj
	EFlWxMO2SWBcKgMNNLnfEcmqFBMtKbWlbhEdWrUNlgsESlSvwa0hHQoqxTvrOE9s9hod6lp4WHdmH
	382pU3oEAH+9CFHmrRo2vqEWoAE9P9qGzpfYcM6jZacC2c7/bJZEReeQW2A7zNde08Qm5RFBKWZLt
	80W7svy6sJjflWQqFc67lJAQzn6jjc2BVFqXkLYkE78tCePMr8r4IDMTZmMFLnzDWJyFrRJhWn4cO
	mZqlq5Ca9Wlrrm2RYxMbI0qfsP3P/GrSSje3xOYyX20akrp5lu1OAt8doPxEkOb8rOB/iZ9zxtxzf
	CQDjQihw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ri9OC-003Hj7-1h;
	Thu, 07 Mar 2024 08:46:08 +0000
Date: Thu, 7 Mar 2024 08:46:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Message-ID: <20240307084608.GD538574@ZenIV>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
 <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
 <20240307072112.GC538574@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307072112.GC538574@ZenIV>
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
Cc: chengzhihao1@huawei.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Mar 07, 2024 at 07:21:12AM +0000, Al Viro wrote:
> On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
> > > > +int erofs_anon_register_fs(void)
> > > > +{
> > > > +	return register_filesystem(&erofs_anon_fs_type);
> > > > +}
> > > What for?  The only thing it gives you is an ability to look it up by
> > > name.  Which is completely pointless, IMO,
> > The helper function here is to avoid extern erofs_anon_fs_type(), because
> > we define it in fscache.c, but also use it in super.c. Moreover, we don't
> > need
> > to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
> 
> You don't need to register it at all.
> 
> The one and only effect of register_filesystem() is making file_system_type
> instance visible to get_fs_type() (and making it show up in /proc/filesystems).
> 
> That's it.  If you want to have it looked up by name (e.g. for userland
> mounts), you need to register.  If not, you do not need to do that.
> 
> Note that kern_mount() take a pointer to struct file_system_type,
> not its (string) name.  So all you get from registration is an extra line
> in /proc/filesystems.  What's the point?

PS: at one point I considered renaming it to something that would sound
less vague, but the best variant I'd been able to come up with was
"publish_filesystem()", which is not much better and has an extra problem -
how do you describe the reverse of that?  "withdraw_filesystem()"?
Decided that it wasn't worth the amount of noise and headache...
