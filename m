Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251718843F
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2019 22:45:46 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 464y1g0T79zDrGx
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Aug 2019 06:45:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 464y1Q5vfwzDrFD
 for <linux-erofs@lists.ozlabs.org>; Sat, 10 Aug 2019 06:45:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r3dsx6QVmSUscYTWrHVh0F7zwcjR91dpsterxBkUC8s=; b=TLJg1pKD9j6YHm/H37OhEVDOl
 8da2sYlD4V5mVM84jMZdKOKy9/DTnFcQjQW0txNN/sjDRCo8WEoF9cWP2tFIGMAumjDEpKavemMRs
 4s14f9uX8lSxORoFI9iIpY5fljFbZNmKKgUpZNQRurkaZtGWiuGjmwnbKC9c6mv1UqaDrz7BPhyw3
 /AI+Ae+NXenu8vna83hq60qECoatL4uG0fG6u0J2CGrE/Nk7dvKys9fLrf+BbEwaa3bGahn4rhzTU
 DPkfLQuLi4oSQV4zomrIgQPE8vhPr06zoiEVlT2IfCBMIvVHcjCfLhXoktwK4JN0cdeyh32lj4cMF
 5m5xYhuaA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hwBlF-000213-GK; Fri, 09 Aug 2019 20:45:17 +0000
Date: Fri, 9 Aug 2019 13:45:17 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>, Dave Chinner <david@fromorbit.com>,
 Goldwyn Rodrigues <RGoldwyn@suse.com>, "hch@lst.de" <hch@lst.de>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190809204517.GR5482@bombadil.infradead.org>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808054936.GA5319@sol.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> >     1. decrypt->verity->decompress
> > 
> >     2. verity->decompress->decrypt
> > 
> >     3. decompress->decrypt->verity
> > 
> >    1. and 2. could cause less computation since it processes
> >    compressed data, and the security is good enough since
> >    the behavior of decompression algorithm is deterministic.
> >    3 could cause more computation.
> > 
> > All I want to say is the post process is so complicated since we have
> > many selection if encryption, decompression, verification are all involved.
> > 
> > Maybe introduce a core subset to IOMAP is better for long-term
> > maintainment and better performance. And we should consider it
> > more carefully.
> > 
> 
> FWIW, the only order that actually makes sense is decrypt->decompress->verity.

That used to be true, but a paper in 2004 suggested it's not true.
Further work in this space in 2009 based on block ciphers:
https://arxiv.org/pdf/1009.1759

It looks like it'd be computationally expensive to do, but feasible.

> Decrypt before decompress, i.e. encrypt after compress, because only the
> plaintext can be compressible; the ciphertext isn't.
