Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F794E2A57
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 15:21:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMcH105gcz30Md
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 01:21:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMcGs0551z306S
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 01:20:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7r08HY_1647872438; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7r08HY_1647872438) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 21 Mar 2022 22:20:40 +0800
Date: Mon, 21 Mar 2022 22:20:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [Linux-cachefs] [PATCH v5 03/22] cachefiles: introduce on-demand
 read mode
Message-ID: <YjiJtrOEBa7p/8M2@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, joseph.qi@linux.alibaba.com,
 torvalds@linux-foundation.org, chao@kernel.org,
 tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, gregkh@linuxfoundation.org,
 luodaowen.backend@bytedance.com, xiang@kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 eguan@linux.alibaba.com
References: <YjiAVezd5B9auhcP@casper.infradead.org>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <1029982.1647872043@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1029982.1647872043@warthog.procyon.org.uk>
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
Cc: gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Mar 21, 2022 at 02:14:03PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Why do you have a separate rwlock when the xarray already has its own
> > spinlock?  This is usually a really bad idea.
> 
> Jeffle wants to hold a lock across the CACHEFILES_DEAD check and the xarray
> access.
> 
> However, he tells xarray to do a GFP_KERNEL alloc whilst holding the rwlock:-/

Yeah, sorry, there are trivial mistakes due to sleep in atomic
contexts (sorry that I didn't catch them earlier..)

Thanks,
Gao Xiang

> 
> David
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
