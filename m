Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 12246464A09
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 09:44:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3t15703Dz306D
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 19:44:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3t121B1Rz303Z
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Dec 2021 19:44:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UyzaapR_1638348222; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UyzaapR_1638348222) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 01 Dec 2021 16:43:44 +0800
Date: Wed, 1 Dec 2021 16:43:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: update AUTHORS
Message-ID: <Yac1vEtEOjP1kZ0A@B-P7TQMD6M-0146.local>
References: <20211201082746.1642-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201082746.1642-1-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, yh@oppo.com, guanyuwei@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Dec 01, 2021 at 04:27:46PM +0800, Huang Jianan wrote:
> Add myself to the AUTHORS file.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  AUTHORS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/AUTHORS b/AUTHORS
> index 812042a..6b41df8 100644
> --- a/AUTHORS
> +++ b/AUTHORS
> @@ -1,6 +1,7 @@
>  EROFS USERSPACE UTILITIES
>  M: Li Guifu <bluce.lee@aliyun.com>
>  M: Gao Xiang <xiang@kernel.org>
> +M: Huang Jianan <huangjianan@oppo.com>

Thanks for your time on erofs-utils.
Let's work on EROFS together. :)

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
