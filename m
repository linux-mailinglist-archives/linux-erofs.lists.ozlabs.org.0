Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0577629649
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 11:50:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NBNJ758zZz3cKY
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Nov 2022 21:50:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NBNJ341GTz3cFP
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Nov 2022 21:50:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VUtE0x-_1668509434;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VUtE0x-_1668509434)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 18:50:36 +0800
Date: Tue, 15 Nov 2022 18:50:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Siddh Raman Pant <code@siddh.me>
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Message-ID: <Y3Nu+TNRp6Fv3L19@B-P7TQMD6M-0146.local>
Mail-Followup-To: Siddh Raman Pant <code@siddh.me>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	linux-erofs <linux-erofs@lists.ozlabs.org>
References: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
 <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>, linux-erofs <linux-erofs@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 15, 2022 at 03:39:38PM +0530, Siddh Raman Pant via Linux-erofs wrote:
> On Tue, 15 Nov 2022 08:54:47 +0530, Gao Xiang wrote:
> > I just wonder if we should return -EINVAL for post-EOF cases or
> > IOMAP_HOLE with arbitrary length?
> 
> Since it has been observed that length can be zeroed, and we
> must stop, I think we should return an error appropriately.
> 
> For a read-only filesystem, we probably don't really need to
> care what's after the EOF or in unmapped regions, nothing can
> be changed/extended. The definition of IOMAP_HOLE in iomap.h
> says it stands for "no blocks allocated, need allocation".

For fiemap implementation, yes.  So it looks fine to me.

Let's see what other people think.  Anyway, I'd like to apply it later.

Thanks,
Gao Xiang

> 
> Alternatively, we can return error iff the length of the
> extent with holes is zero, like here.
> 
> Thanks,
> Siddh
