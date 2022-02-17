Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45524B9BC1
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 10:10:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jzpty1kb3z3cBs
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 20:10:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jzptp3NF2z3bc6
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Feb 2022 20:09:51 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0V4jiEYG_1645088981; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V4jiEYG_1645088981) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Feb 2022 17:09:43 +0800
Date: Thu, 17 Feb 2022 17:09:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v2 0/2] erofs-utils: refine tailpcluster compression
 approach
Message-ID: <Yg4Q1WNDHT0rKojy@B-P7TQMD6M-0146.local>
References: <20220216122845.47819-1-hsiangkao@linux.alibaba.com>
 <20220217164323.000019f1.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217164323.000019f1.zbestahu@gmail.com>
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
Cc: geshifei@coolpad.com, liuchao@coolpad.com, zhangwen@coolpad.com,
 Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 17, 2022 at 04:43:23PM +0800, Yue Hu wrote:
> On Wed, 16 Feb 2022 20:28:43 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Hi,
> > 
> > This patchset refines tailpcluster compression. Firstly, instead of
> > compressing into many 4KiB pclusters, it compresses into 2 pclusters
> > as I already mentioned in the previous comment [1].
> > 
> > Secondly, it fixes up EOF lclusters which was disabled on purpose before
> > in order to achieve better inlining performance for small compressed data,
> > which matches the new kernel fix [2].
> > 
> > Still take linux-5.10.87 as an example (75368 inodes in total):
> > linux-5.10.87 (erofs, lz4hc,9 4k tailpacking)	391696384 => 331292672
> > linux-5.10.87 (erofs, lz4hc,9 8k tailpacking)	368807936 => 321961984
> > linux-5.10.87 (erofs, lz4hc,9 16k tailpacking)	345649152 => 313344000
> > linux-5.10.87 (erofs, lz4hc,9 32k tailpacking)  338649088 => 309055488
> > 
> > (There is still another improvement working in progress..)
> > 
> > Thanks,
> > Gao Xiang
> > 
> > [1] https://lore.kernel.org/r/YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local 
> > [2] https://lore.kernel.org/r/20220203190203.30794-1-xiang@kernel.org
> > 
> > changes since v1 (reported by Yue Hu):
> >  - fall back to uncompressed data if EOF lcluster inline is no possible;
> >  - fix `ret' signedness.
> > 
> > Gao Xiang (2):
> >   erofs-utils: lib: get rid of a redundent compress round
> >   erofs-utils: lib: refine tailpcluster compression approach
> > 
> >  include/erofs/compress.h |   1 +
> >  include/erofs/internal.h |   4 +
> >  lib/compress.c           | 156 +++++++++++++++++++++++++++------------
> >  lib/inode.c              |   9 ++-
> >  4 files changed, 119 insertions(+), 51 deletions(-)
> > 
> 
> Tested-by: Yue Hu <huyue2@yulong.com>

Thanks for the confirmation on your side.

Thanks,
Gao Xiang
