Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC8874890
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 08:21:34 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=I3u7exF8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tr1243cTMz3dVN
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 18:21:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=I3u7exF8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tr11v6rplz3c1g
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 18:21:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8w8rejYB9PBmKB0DYtImdRxvM7rQ/tJG4QSkTuHYLXw=; b=I3u7exF8LYo6EnYsylcAmUSP+Z
	R0i7G9s8p9OgKJN6jlZEfFTBNB+jIFnUR2Lfe+LMXnV1DiqReY6K+WzE/3TFxRtOWELmj2CYfDslt
	2gyw22XfQUJ+JtsoAg63qUO7FmSMcl6Hp+1CuLtV1n5KaUrc+IPZKYeSMBrnW1ra+nuJY8k1VSx4Z
	lDGuSBayME4GraArPrhR2obfaG+oUcwaJU4FKq0Rl2Q8b68HSjbdBfK3y267PwUK24ePKDf0osb9T
	LVY5we2/bTF4Tp3weeVUVNxuH3EGW+4c7PmAi/fC0hYmQrR11bKHhVw1fb/O0IRUGsioIkaRPhQzt
	Z+CFRwkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ri841-003FW0-06;
	Thu, 07 Mar 2024 07:21:13 +0000
Date: Thu, 7 Mar 2024 07:21:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Message-ID: <20240307072112.GC538574@ZenIV>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
 <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
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

On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
> > > +int erofs_anon_register_fs(void)
> > > +{
> > > +	return register_filesystem(&erofs_anon_fs_type);
> > > +}
> > What for?  The only thing it gives you is an ability to look it up by
> > name.  Which is completely pointless, IMO,
> The helper function here is to avoid extern erofs_anon_fs_type(), because
> we define it in fscache.c, but also use it in super.c. Moreover, we don't
> need
> to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we

You don't need to register it at all.

The one and only effect of register_filesystem() is making file_system_type
instance visible to get_fs_type() (and making it show up in /proc/filesystems).

That's it.  If you want to have it looked up by name (e.g. for userland
mounts), you need to register.  If not, you do not need to do that.

Note that kern_mount() take a pointer to struct file_system_type,
not its (string) name.  So all you get from registration is an extra line
in /proc/filesystems.  What's the point?
