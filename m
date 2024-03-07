Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D491874785
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 06:07:44 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=X3+nzqBK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tqy3d5xf2z3dVL
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Mar 2024 16:07:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=X3+nzqBK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tqy3T491lz3d31
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Mar 2024 16:07:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uyw322A03RBS5tbmGT647PAFtATngAMN6Haf+EFXJ4w=; b=X3+nzqBKmPLMoRnNLworhQCBjI
	/POHGz/irBPUC6/tQ+RC7hAnb0TDjMdaPgT1wQ3NI+4M3RHDyXSSaoHooaJfdvqK4SIg9c3palj5R
	1FHa3Bam8Zw4E9SKFhm+iFHkjyjkt/n6DnIJ1Zvd3KmsUHQub1h4XddPOPJpgxHYJuvOeqZwGYbaG
	2CcD3tKIT6yugEKnWscSJYkK9R2Ar7dUk3S1fcR+Wk9F2CqOcavJrkDqyd8QNga1fZoiGWJ+jCB6e
	mOLRcKdwS3v7DR0sf6cFlcdr3grq7MexW8tHWqwnVm0YM+E1aZhetqP+rJwnKBN9fuQrWih+mSNq+
	193xzFOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ri5yP-003Byp-1g;
	Thu, 07 Mar 2024 05:07:17 +0000
Date: Thu, 7 Mar 2024 05:07:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Message-ID: <20240307050717.GB538574@ZenIV>
References: <20240307024459.883044-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307024459.883044-1-libaokun1@huawei.com>
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

On Thu, Mar 07, 2024 at 10:44:59AM +0800, Baokun Li wrote:

> +static int erofs_anon_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &erofs_anon_context_ops;
> +	return 0;
> +}


ITYM
        struct pseudo_fs_context *ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
	return ctx ? 0 : -ENOMEM;

and to hell with erofs_anon_context_ops, along with its fill_super, calls
of simple_fill_super(), etc.  Unless I'm missing something, you are not
even creating dentries here, let alone making them possible to look up.

> +static void erofs_kill_pseudo_sb(struct super_block *sb)
> +{
> +	kill_anon_super(sb);
> +}

*blink*

What's wrong with simply using kill_anon_super as ->kill_sb?

> +int erofs_anon_register_fs(void)
> +{
> +	return register_filesystem(&erofs_anon_fs_type);
> +}

What for?  The only thing it gives you is an ability to look it up by
name.  Which is completely pointless, IMO,

>  	if (!erofs_pseudo_mnt) {
> -		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
> +		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);

... since you are getting to it by direct reference to file_system_type
anyway.  Same unregistering, of course...
