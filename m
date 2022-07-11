Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3756FDFC
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 12:03:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LhKFn2dgMz3by2
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 20:03:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LhKFc4yfHz30Lb
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 20:03:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VJ-Y7wy_1657533763;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJ-Y7wy_1657533763)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 18:02:45 +0800
Date: Mon, 11 Jul 2022 18:02:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [RFC PATCH 0/3] erofs-utils: compressed fragments feature
Message-ID: <Ysv1QyAvxfmiRECJ@B-P7TQMD6M-0146.local>
References: <cover.1657528899.git.huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1657528899.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zbestahu@163.com, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Mon, Jul 11, 2022 at 05:09:55PM +0800, Yue Hu wrote:
> In order to achieve greater compression ratio, let's introduce
> compressed fragments feature which can merge tail of per-file or the
> whole files into one special inode to reach the target.
> 
> And we can also set pcluster size to fragments inode for different
> compression requirments.
> 
> In this patchset, we also improve the uncompressed data layout of
> compressed files. Just write it from 'clusterofs' instead of 0 since it
> can benefit from in-place I/O. For now, it only goes with fragments.
> 
> The main idea above is from Xiang.
> 

I just took a preliminary try and it seems work, but in order to form it
better, I have to postpone it for the next version of 5.20 (6.0?)
since I'm still working on cleaning up and rolling hash deduplication.

Thanks,
Gao Xiang
