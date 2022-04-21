Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4EC50A801
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 20:22:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kkm8t1f3zz2yPj
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 04:22:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.1;
 helo=out199-1.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
X-Greylist: delayed 308 seconds by postgrey-1.36 at boromir;
 Fri, 22 Apr 2022 04:21:58 AEST
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com
 [47.90.199.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kkm8k1grVz2yPj
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 04:21:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VAh.Br2_1650564996; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VAh.Br2_1650564996) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Apr 2022 02:16:38 +0800
Date: Fri, 22 Apr 2022 02:16:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: EMFILE/ENFILE mitigation needed in erofs?
Message-ID: <YmGfhFQshWOkAqNG@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
 JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
 xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
References: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com>
 <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1447543.1650552898@warthog.procyon.org.uk>
 <1484181.1650563860@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1484181.1650563860@warthog.procyon.org.uk>
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
 fannaihao@baidu.com, willy@infradead.org, linux-kernel@vger.kernel.org,
 tianzichen@kuaishou.com, linux-fsdevel@vger.kernel.org,
 zhangjiachen.jaycee@bytedance.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Thu, Apr 21, 2022 at 06:57:40PM +0100, David Howells wrote:
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
> > 2. Our user daemon will configure rlimit-nofile to a reasonably large
> > (e.g. 1 million) value, so that it won't fail when trying to allocate fds.
> 
> There's a system-wide limit also; simply increasing the rlimit won't override
> that.

Yes, I suggest that we should add some words to document this
to system administrators to take care of `/proc/sys/fs/file-max',
but I think it's typically not a problem about our on-demand cases.

Since each cookie equals to an erofs device, so not too many erofs
devices (much like docker layers) for one erofs images and they
are all handled when mounting (which needs privilege permissions.)

And due to this, fscache dir can be easily backed up, restored, and
transfered since they are really golden erofs image files.

Thanks,
Gao Xiang

> 
> David
