Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB3F60712B
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 09:32:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtx546VSgz3chN
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 18:32:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtx4z3V16z2yfg
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 18:32:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VSiUhQS_1666337548;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSiUhQS_1666337548)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 15:32:30 +0800
Date: Fri, 21 Oct 2022 15:32:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Subject: Re: [PATCH] erofs-utils: erofs-utils: lib: fix dev_read
Message-ID: <Y1JLC92jR/q/xjjx@B-P7TQMD6M-0146.local>
References: <20221021064332.357316-1-chenlinxuan@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021064332.357316-1-chenlinxuan@uniontech.com>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 21, 2022 at 02:43:32PM +0800, Chen Linxuan wrote:
> When using `fsck.erofs` to extract some image have a very large file
> inside, for example 2G, my fsck.erofs report some thing like this:
> 
> <E> erofs_io: Failed to read data from device - erofs.image:[4096,
> 2147483648].
> <E> erofs: failed to read data of m_pa 4096, m_plen 2147483648 @ nid 40: -17
> <E> erofs: Failed to extract filesystem
> 
> You can use this script to reproduce this issue.
> 
> mkdir tmp extract
> dd if=/dev/urandom of=tmp/big_file bs=1M count=2048
> 
> mkfs.erofs erofs.image tmp
> fsck.erofs erofs.image --extract=extract
> 
> I found that dev_open will failed if we can not get all data we want
> with one pread call.
> 
> I write this little patch try to fix this issue.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
(I will fix up the subject to
 "erofs-utils: lib: fix dev_read for large files")

Thanks,
Gao Xiang
