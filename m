Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A942D001
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 03:43:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVBxg0XBXz2ym5
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 12:43:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RONdr3F/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.11; helo=m12-11.163.com; envelope-from=zbestahu@163.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=RONdr3F/; dkim-atps=neutral
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by lists.ozlabs.org (Postfix) with ESMTP id 4HVBxW5w7jz2yKN
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Oct 2021 12:43:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=XKVvQ
 n2X6uzeWYHLBs62kSCazfOZ5OQzKPuckB59ymw=; b=RONdr3F/hZ+unWXyMyhBa
 n1t6oR7+Xpv+1jrQbTlZMDW44XTUz2rqFbpTBVEwLE+GCb/ZU2Jzi/zKVBQAGUOC
 lkeJZxzDH57xxf3YiKmpFxe0kX+RN2GRKPJXjd7YzSXIAA2DBiSf37AV8Hlyjo7e
 FWa3dncjxqeQ3zDP3DhZ0Q=
Received: from localhost (unknown [218.94.48.178])
 by smtp7 (Coremail) with SMTP id C8CowACHfY0ki2dhl9gG1w--.29353S2;
 Thu, 14 Oct 2021 09:43:01 +0800 (CST)
Date: Thu, 14 Oct 2021 09:42:59 +0800
From: Yue Hu <zbestahu@163.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix the per-CPU buffer decompression for small
 output size
Message-ID: <20211014094259.00004ac5.zbestahu@163.com>
In-Reply-To: <YWcDNrHBYTQIq6x+@B-P7TQMD6M-0146.local>
References: <20211013092906.1434-1-zbestahu@gmail.com>
 <YWbIWydks+wpuNij@B-P7TQMD6M-0146.local>
 <20211013211005.7bd9fc08.zbestahu@163.com>
 <YWcDNrHBYTQIq6x+@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C8CowACHfY0ki2dhl9gG1w--.29353S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1xCrWrJFWrXr48Gw45Wrg_yoW8XFW3pr
 WSkFy0ka4FqryUAr4Utr18ZFW3t3yxKr40q39YqFyrXF9Igrs3Gryktr48Wrs7X3Wru3Za
 yw4jganIv3y5CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0oGQUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBLwQsEVUMOfTVtQABsj
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
Cc: linux-kernel@vger.kernel.org, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 14 Oct 2021 00:03:02 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Wed, Oct 13, 2021 at 09:10:05PM +0800, Yue Hu wrote:
> > Hi Xiang,
> > 
> > On Wed, 13 Oct 2021 19:51:55 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > Hi Yue,
> > > 
> > > On Wed, Oct 13, 2021 at 05:29:05PM +0800, Yue Hu wrote:  
> > > > From: Yue Hu <huyue2@yulong.com>
> > > > 
> > > > Note that z_erofs_lz4_decompress() will return a positive value if
> > > > decompression succeeds. However, we do not copy_from_pcpubuf() due
> > > > to !ret. Let's fix it.
> > > > 
> > > > Signed-off-by: Yue Hu <huyue2@yulong.com>    
> > > 
> > > Thanks for catching this. This is a valid issue, but it has no real
> > > impact to the current kernels since such pcluster in practice will be
> > > !inplace_io and trigger "if (nrpages_out == 1 && !rq->inplace_io) {"
> > > above for upstream strategies.
> > > 
> > > Our customized lz4 implementation will return 0 if success instead, so
> > > it has no issue to our previous products as well.  
> > 
> > Yes, i just find the issue when i try to implement a new feature of
> > tail-packing inline compressed data. No problem in my current version.  
> 
> Yeah, please help update the return value of z_erofs_lz4_decompress()
> and get rid of such unneeded fast path.

OK, will update in next version.

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks.
> >   
> > > 
> > > For such cases, how about updating z_erofs_lz4_decompress() to return
> > > 0 if success instead rather than outputsize. Since I'll return 0 if
> > > success for LZMA as well.
> > > 
> > > Thanks,
> > > Gao Xiang  
> >   

