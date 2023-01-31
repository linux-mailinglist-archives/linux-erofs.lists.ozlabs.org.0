Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936868227A
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 04:03:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P5VGp0bKdz3cKb
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 14:02:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.6; helo=out30-6.freemail.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 302 seconds by postgrey-1.36 at boromir; Tue, 31 Jan 2023 14:02:53 AEDT
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P5VGj72jsz2yNs
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Jan 2023 14:02:53 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VaUevXk_1675133864;
Received: from 30.221.128.249(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VaUevXk_1675133864)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 10:57:45 +0800
Message-ID: <88a3f06f-8c06-112b-5952-28cd673f138d@linux.alibaba.com>
Date: Tue, 31 Jan 2023 10:57:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 096/171] Correct SPL use of FS_EROFS
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230130144324.206208-1-sjg@chromium.org>
 <20230130144324.206208-97-sjg@chromium.org>
From: Huang Jianan <jnhuang@linux.alibaba.com>
In-Reply-To: <20230130144324.206208-97-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Tom Rini <trini@konsulko.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


在 2023/1/30 22:42, Simon Glass 写道:
> This converts 1 usage of this option to the non-SPL form, since there is
> no SPL_FS_EROFS defined in Kconfig
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   fs/erofs/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 58af6a68e41..ef94d2db45d 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -obj-$(CONFIG_$(SPL_)FS_EROFS) = fs.o \
> +obj-$(CONFIG_FS_EROFS) = fs.o \
>   				super.o \
>   				namei.o \
>   				data.o \

Looks good to me.
Reviewed-by: Huang Jianan <jnhuang95@gmail.com>

Thanks,
Jianan
