Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663E48D737
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jan 2022 13:09:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JZNXX0pBnz2yyK
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jan 2022 23:09:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JZNXQ2r2Qz2xY3
 for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jan 2022 23:09:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0V1jRj.0_1642075754; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V1jRj.0_1642075754) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 13 Jan 2022 20:09:15 +0800
Date: Thu, 13 Jan 2022 20:09:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [Linux-cachefs] [PATCH v1 05/23] netfs: add inode parameter to
 netfs_alloc_read_request()
Message-ID: <YeAWaRLdw8hTujLX@B-P7TQMD6M-0146.local>
Mail-Followup-To: JeffleXu <jefflexu@linux.alibaba.com>,
 David Howells <dhowells@redhat.com>, tao.peng@linux.alibaba.com,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 eguan@linux.alibaba.com, gerry@linux.alibaba.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-6-jefflexu@linux.alibaba.com>
 <9eafb56b-809c-c340-5627-a54a6265122b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9eafb56b-809c-c340-5627-a54a6265122b@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jan 13, 2022 at 11:10:57AM +0800, JeffleXu wrote:
> Hi David,
> 
> What would you think about this cleanup? We need this in prep for the
> following fscache-based on-demand reading feature. It would be great if
> it could be cherry picked in advance.
> 
> I also simplify the commit message as suggested by Gao Xiang. I could
> resend a v2 patch with the updated commit message if you'd like.
> 
>     netfs: add inode parameter to netfs_alloc_read_request()
> 
>     Make the @file parameter optional, and derive inode from the @folio
>     parameter instead.
> 
>     @file parameter can't be removed completely, since it also works as
>     the private data of ops->init_rreq().
> 
>     Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Hi,

IMHO, How about the following message:

netfs: make @file optional in netfs_alloc_read_request()

Make the @file parameter optional, and derive inode from the @folio
parameter instead in order to support file system internal requests.

@file parameter can't be removed completely, since it also works as
the private data of ops->init_rreq().

Thanks,
Gao Xiang
