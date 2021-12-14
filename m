Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B84473AFC
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 03:55:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCjfF2D8rz304y
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 13:55:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCjf961Fvz2yZt
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 13:54:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0V-aH74h_1639450487; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-aH74h_1639450487) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 14 Dec 2021 10:54:49 +0800
Date: Tue, 14 Dec 2021 10:54:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <huyue2@yulong.com>
Subject: Re: [RFC PATCH v5 1/2] erofs-utils: fuse: support tail-packing
 inline compressed data
Message-ID: <YbgHdzA0FtXa4lHh@B-P7TQMD6M-0146.local>
References: <1fc2694139fa8b217208992c72ec8ef383e3ff9e.1639377756.git.huyue2@yulong.com>
 <YbcqArpVrEXjLzW/@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbcqArpVrEXjLzW/@B-P7TQMD6M-0146.local>
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
Cc: geshifei@coolpad.com, zhangwen@coolpad.com, linux-erofs@lists.ozlabs.org,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 13, 2021 at 07:09:54PM +0800, Gao Xiang wrote:
> Hi Yue,
> 
> On Mon, Dec 13, 2021 at 02:50:54PM +0800, Yue Hu wrote:
> > Add tail-packing inline compressed data support for erofsfuse.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> 
> This version almost looks fine to me, no need to update. I will polish
> it this week.
>

I've applied this patch
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-ztailpacking

Would you mind rebasing [PATCH 2/2] on this and resending? It saves much
time for me. (Actually the development process needs to be based on the
latest dev branch other than on some random commit.)

Thanks,
Gao Xiang
