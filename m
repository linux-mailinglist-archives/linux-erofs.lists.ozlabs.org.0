Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A4497A6A
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 09:34:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jj3F11Mpcz30QB
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 19:34:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jj3Dw1kpNz2xF9
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jan 2022 19:34:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V2gQ.wI_1643013242; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V2gQ.wI_1643013242) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 24 Jan 2022 16:34:04 +0800
Date: Mon, 24 Jan 2022 16:34:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: fix fsdax partition offset handling
Message-ID: <Ye5kehup+iQ3g+q/@B-P7TQMD6M-0146.local>
References: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
 <d424369b-c559-bf63-bbb3-71886f1799c9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d424369b-c559-bf63-bbb3-71886f1799c9@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 24, 2022 at 03:11:35PM +0800, Chao Yu wrote:
> On 2022/1/13 13:18, Gao Xiang wrote:
> > After seeking time on testing today upstream fsdax, I found it
> > actually doesn't work well as below:
> > 
> > [  186.492983] ------------[ cut here ]------------
> > [  186.493629] WARNING: CPU: 1 PID: 205 at fs/iomap/iter.c:33 iomap_iter+0x2f6/0x310
> > 
> > The problem is that m_dax_part_off should be applied to physical
> > addresses and very sorry about that I didn't catch this eariler.
> > 
> > Anyway, let's fix it up now. Also, I need to find a way to set up
> > a standalone testcase to look after this later.
> > 
> > Fixes: de2051147771 ("fsdax: shift partition offset handling into the file systems")
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks for the review! I will send this together with other misc
fixes this or next week..

Thanks,
Gao Xiang

> 
> Thanks,
