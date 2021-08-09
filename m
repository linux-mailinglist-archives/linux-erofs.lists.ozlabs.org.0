Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA83E3E19
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Aug 2021 05:06:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GjgwC4l71z30Bv
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Aug 2021 13:06:35 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gjgw64mZ8z2xts
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 Aug 2021 13:06:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UiLXKxy_1628478382; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UiLXKxy_1628478382) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 Aug 2021 11:06:23 +0800
Date: Mon, 9 Aug 2021 11:06:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "weiyongjun (A)" <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] erofs: make symbol 'erofs_iomap_ops' static
Message-ID: <YRCbrtHZjo9oZfol@B-P7TQMD6M-0146.local>
References: <20210808063343.255817-1-weiyongjun1@huawei.com>
 <YQ/ZxZkNCtWGO6X4@B-P7TQMD6M-0146.local>
 <4ddfb962-97fc-28b0-0006-197574a1ec00@kernel.org>
 <82bae76e-8811-22d4-0b75-f58df1153def@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82bae76e-8811-22d4-0b75-f58df1153def@huawei.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hulk Robot <hulkci@huawei.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 09, 2021 at 10:49:31AM +0800, weiyongjun (A) wrote:
> 
> 在 2021/8/9 7:56, Chao Yu 写道:
> > On 2021/8/8 21:19, Gao Xiang wrote:
> > > On Sun, Aug 08, 2021 at 06:33:43AM +0000, Wei Yongjun wrote:
> > > > The sparse tool complains as follows:
> > > > 
> > > > fs/erofs/data.c:150:24: warning:
> > > >   symbol 'erofs_iomap_ops' was not declared. Should it be static?
> > > > 
> > > > This symbol is not used outside of data.c, so marks it static.
> > 
> > Thanks for the patch, I guess it will be better to fix in original patch
> > if you don't mind.
> 
> 
> Yes, better to fix in original patch.

Ok, I'll merge this into the original patch this tomorrow.
(Anyway, thanks for the report!)

Thanks,
Gao Xiang

> 
> Regards.
