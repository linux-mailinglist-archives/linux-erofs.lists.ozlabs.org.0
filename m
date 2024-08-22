Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844295ADD0
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2024 08:42:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqDCb43Kmz2yjR
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2024 16:42:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=faXicmcq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WqDCX5Tgpz2yGf
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2024 16:42:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724308946; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/TEjJg1I0GY/zm8x44TBeZAab8V/IW5s160lNw1qqcU=;
	b=faXicmcqJCScqkXsnk2cT2pEWOej/pqEF+Ww0DxroOqT8JjBEE43YCqlkR8vhn7RmJ2JK8Hi2HmfV4dMXO7TWvf0bvfd+UwqkNDxG7AL6h/dIlnyU8ZrYUsiYTBZ0xNpHmPt1CiIzstyMBxJ9rybb74skKMbe/8YUX0tJOCrSMA=
Received: from 30.221.130.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDOEXYB_1724308943)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 14:42:24 +0800
Message-ID: <517ca52f-7886-4e05-a977-59094892422f@linux.alibaba.com>
Date: Thu, 22 Aug 2024 14:42:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Prevent entering an infinite loop when i is 0
To: liujinbao1 <jinbaoliu365@gmail.com>, xiang@kernel.org
References: <20240822062749.4012080-1-jinbaoliu365@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240822062749.4012080-1-jinbaoliu365@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/8/22 14:27, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When i=0 and err is not equal to 0,
> the while(-1) loop will enter into an
> infinite loop. This patch avoids this issue.

Missing your Signed-off-by here.

> ---
>   fs/erofs/decompressor.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index c2253b6a5416..1b2b8cc7911c 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>   	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>   		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>   		if (err) {
> +			if (!i)
> +				return err;
>   			while (--i)
>   				if (z_erofs_decomp[i])
>   					z_erofs_decomp[i]->exit();


Thanks for catching this, how about the following diff (space-demaged).

If it looks good to you, could you please send another version?

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..c9b2bc1309d2 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)

  int __init z_erofs_init_decompressor(void)
  {
-       int i, err;
+       int i, err = 0;

         for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
                 err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
-               if (err) {
+               if (err && i)
                         while (--i)
                                 if (z_erofs_decomp[i])
                                         z_erofs_decomp[i]->exit();
-                       return err;
-               }
         }
-       return 0;
+       return err;
  }
