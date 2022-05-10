Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79852183C
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 15:30:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KyJn60JQpz3bxp
	for <lists+linux-erofs@lfdr.de>; Tue, 10 May 2022 23:30:02 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KyJn14Hz7z3bq3
 for <linux-erofs@lists.ozlabs.org>; Tue, 10 May 2022 23:29:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R421e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0VCrRO54_1652189383; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VCrRO54_1652189383) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 10 May 2022 21:29:46 +0800
Date: Tue, 10 May 2022 21:29:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v11 06/22] cachefiles: enable on-demand read mode
Message-ID: <YnpoxvLk3us94C9I@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
 xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
 zhujia.zj@bytedance.com
References: <20220509074028.74954-7-jefflexu@linux.alibaba.com>
 <20220509074028.74954-1-jefflexu@linux.alibaba.com>
 <3509457.1652187396@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3509457.1652187396@warthog.procyon.org.uk>
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
Cc: joseph.qi@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 willy@infradead.org, linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 linux-fsdevel@vger.kernel.org, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, May 10, 2022 at 01:56:36PM +0100, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
> > Enable on-demand read mode by adding an optional parameter to the "bind"
> > command.
> > 
> > On-demand mode will be turned on when this parameter is "ondemand", i.e.
> > "bind ondemand". Otherwise cachefiles will work in the original mode.
> > 
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Acked-by: David Howells <dhowells@redhat.com>

Thank you very much, David! Thanks for your so much time and patience!

Many thanks!
Gao Xiang
