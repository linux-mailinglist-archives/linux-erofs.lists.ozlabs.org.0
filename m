Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F21971C31
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 16:14:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2TP13FKqz2yTs
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 00:14:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725891283;
	cv=none; b=K6EmNvl9oNkGM492GSpVm6oskzR9kaUpbPur3Byz0BxXihISIcsUVxX34jzlI/VDQ230t+a3AmjwrQAZ8pmaJPQ5S0FQUHWDQZ34gJBRXIjV62pM21lnCfU8z09eWvHxsBzF3/C8tPoeu7tZdoB9NOvD2pnuSvd3g/3/33gSp1KVPGf8Eh0Y5A/cDWUlqKzlQnJf7E5E/9YrKTmkFqW7slI7/6amOoVqOBcdUmdyUjZlLAzdM1yfxjWMCnSub+oT9X1QT/czNYSYzUw7bL3fZILrhYAULn7CY0PakOmPZBoXljofLsoRj9um63vGlfr0VfbcNMmRHJI3rWSW3DYYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725891283; c=relaxed/relaxed;
	bh=IAcwvzoMydeLjuaop0xgeZzWUw7A+pNuIS0p1YukCJw=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=F49dK2vDwXYZ9TVx3Jysi7Op6WjAsIFZiq1lwTCZHbdIg6QbHAzrTbKm5R9F+8qEmmaNn4E2c5ay/xGLKubsrdsNpvAioYJ70cEAU/7X+DF89jk1roSXLQ76vzKJrR96bWene+VK6bkeUh143kCVHSL0SB8c/5cEt9j0i2ehiPqnYZK52UDfOgr2k/+pEBplcl9ZL1D8XBpKhsGyX1E1jmrM9wcWtvDGnle9GHs6nle769wtLTbKyMniMdldW1bFeMCLtrmMvhbDNRfwLFLPmHVDWHSE5tP/5/nwJE+U4Tk1Rhl5rNe7gMR8mq2Nnlm8BtsI6LXHHP8t6thWyRYwCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yYLecxUL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yYLecxUL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2TNx4qymz2yNf
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 00:14:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725891275; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IAcwvzoMydeLjuaop0xgeZzWUw7A+pNuIS0p1YukCJw=;
	b=yYLecxULzmdY9LR+gX+M1Aav1QPEBnsrwP39WWlzR3w0EgEl45rgQkbxEPj8xS3S+Ur+nuNuuRqwawop7Uea2ckFTD0veBPnsHtA7kRBqx1cR0V8LRF8LlVGMNbgzPY9a64uBnd5b+1T7gZ2sVd6ZVmmMhGUCDSmE3BqLzQBCOA=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEfKqoU_1725891274)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 22:14:35 +0800
Message-ID: <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
Date: Mon, 9 Sep 2024 22:14:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/9 21:58, Colin Walters wrote:
> 
> 
> On Mon, Sep 9, 2024, at 9:21 AM, Gao Xiang wrote:
>>
>> It can be bigger.
>>
>> Like ext4, EROFS supports PAGE_SIZE symlink via page_get_link()
>> (non-fastsymlink cases), but mostly consider this as 4KiB though
>> regardless of on-disk block sizes.

Let me rephrase it more clearer...

For each EROFS logical block read (e.g 4KiB), EROFS will
only generate one filesystem physical block read instead
of two or more physical block read.

Symlink files just like regular files, so it doesn't allow
the inline tail crosses physical block boundary (which
means an 8KiB I/O is needed), see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/data.c?h=v6.10#n103

In that case,
EROFS_INODE_FLAT_INLINE (2) shouldn't be used and
EROFS_INODE_FLAT_PLAIN(0) need to be used instead in order
to contain full data.

But the fast symlink handling has an issue: it should
fall back to non-fastsymlink path instead of erroring out
directly.


> 
> But symlink targets can't be bigger than PATH_MAX which has always been 4KiB right? (Does Linux support systems with sub-4KiB pages?)

Yes, I think 4KiB is the minimum page size of Linux, so
in practice the maximum size of generic Linux is
PATH_MAX(4KiB).

> 
> I guess let me ask it a different way: Since we're removing a sanity check here I just want to be sure that the constraints are still handled.

It seems page_get_link() doesn't check this, but it
will add trailing `\0` to the end buffer (PAGE_SIZE - 1),
so at least it won't crash the kernel.

> 
> Hmm, skimming through the vfs code from vfs_readlink() I'm not seeing anything constraining the userspace buffer length which seems surprising.
> 
> Ah interesting, XFS has
> #define XFS_SYMLINK_MAXLEN	1024
> and always constrains even its kmalloc invocation to that.


Not quite sure about hard limitation in EROFS
runtime, we could define

#define EROFS_SYMLINK_MAXLEN	4096

But since symlink i_size > 4096 only due to crafted
images (and not generated by mkfs) and not crash, so
either way (to check or not check in kernel) is okay
to me.

Thanks,
Gao Xiang

> 

