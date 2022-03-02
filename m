Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF14C9BB1
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 04:04:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7f8v0cdxz3bdP
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 14:04:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7f8j2N3Jz3bYY
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Mar 2022 14:04:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V60eo0v_1646190234; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V60eo0v_1646190234) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 02 Mar 2022 11:03:56 +0800
Date: Wed, 2 Mar 2022 11:03:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Message-ID: <Yh7emmP7TkMZ+Q8B@B-P7TQMD6M-0146.local>
References: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
 <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
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
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Mar 02, 2022 at 10:49:47AM +0800, Chao Yu wrote:
> On 2022/2/22 11:31, Gao Xiang wrote:
> > z_idataoff here is an absolute physical offset, so it should use
> > erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
> > cause the decompresion failure.
> > 
> > Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks Chao. Yeah, I will submit it this week..

Thanks,
Gao Xiang

> 
> Thanks,
