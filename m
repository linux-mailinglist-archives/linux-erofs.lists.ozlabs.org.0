Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B827DB251
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Oct 2023 04:49:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SJfQV6GP8z3c2V
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Oct 2023 14:49:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SJfQM6wW7z30NN
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Oct 2023 14:48:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0Vv57QkY_1698637729;
Received: from 30.221.132.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vv57QkY_1698637729)
          by smtp.aliyun-inc.com;
          Mon, 30 Oct 2023 11:48:51 +0800
Message-ID: <64521447-67a5-675e-cbfb-2f04f445496f@linux.alibaba.com>
Date: Mon, 30 Oct 2023 11:48:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs-utils: lib: tidy up erofs_compress_destsize()
To: linux-erofs@lists.ozlabs.org
References: <20231027070606.1558363-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231027070606.1558363-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/10/27 15:06, Gao Xiang wrote:
> Drop the old workaround logic to prepare for the following development.
> 
> (I've checked the Linux 6.1.53 source code and an AOSP rootfs without
>   any image size change and strange behavior.)
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I found that It could cause a regression on non-0padding (mainly
Linux < 5.3 kernels), the fix is attached as blow:

diff --git a/lib/compress.c b/lib/compress.c
index c2f6e90..4eac363 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -537,8 +537,10 @@ frag_packing:
  				padding = blksz - tailused;

  			/* zero out garbage trailing data for non-0padding */
-			if (!erofs_sb_has_lz4_0padding(sbi))
+			if (!erofs_sb_has_lz4_0padding(sbi)) {
  				memset(dst + compressedsize, 0, padding);
+				padding = 0;
+			}

  			/* write compressed data */
  			erofs_dbg("Writing %u compressed data to %u of %u blocks",

Thanks,
Gao Xiang
