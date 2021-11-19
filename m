Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82424567FF
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 03:19:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HwL364m6kz2ywv
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 13:19:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HwL315fZfz2xsp
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Nov 2021 13:19:36 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R761e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UxG4NYB_1637288357; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UxG4NYB_1637288357) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 19 Nov 2021 10:19:19 +0800
Date: Fri, 19 Nov 2021 10:19:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs: fix deadlock when shrink erofs slab
Message-ID: <YZcJpDs3FKpSfzAE@B-P7TQMD6M-0146>
References: <20211118135844.3559-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118135844.3559-1-huangjianan@oppo.com>
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

On Thu, Nov 18, 2021 at 09:58:44PM +0800, Huang Jianan wrote:
> We observed the following deadlock in the stress test under low
> memory scenario:
> 
> Thread A                               Thread B
> - erofs_shrink_scan
>  - erofs_try_to_release_workgroup
>   - erofs_workgroup_try_to_freeze -- A
>                                        - z_erofs_do_read_page
>                                         - z_erofs_collection_begin
>                                          - z_erofs_register_collection
>                                           - erofs_insert_workgroup
>                                            - xa_lock(&sbi->managed_pslots) -- B
>                                            - erofs_workgroup_get
>                                             - erofs_wait_on_workgroup_freezed -- A
>   - xa_erase
>    - xa_lock(&sbi->managed_pslots) -- B
> 
> To fix this, it need to hold the xa lock before freeze the workgroup
> beacuse we will operate xarry. So let's hold the lock before access
  ^ because               ^ xarray

> each workgroup, just like when we using the radix tree before.
> 
> Fixes: 64094a04414f ("erofs: convert workstn to XArray")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

