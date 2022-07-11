Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7856FDB0
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 11:59:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LhK9v2rVRz3by8
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 19:59:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.12; helo=out199-12.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 310 seconds by postgrey-1.36 at boromir; Mon, 11 Jul 2022 19:59:43 AEST
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LhK9q2k7xz3btp
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 19:59:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VJ-A9FR_1657533108;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJ-A9FR_1657533108)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 17:51:50 +0800
Date: Mon, 11 Jul 2022 17:51:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Li He <lihe@uniontech.com>
Subject: Re: [PATCH] erofs-utils: fuse: support offset when read image
Message-ID: <YsvytKxpkz/H7Auy@B-P7TQMD6M-0146.local>
References: <YsuejqlGUUp3cC4S@B-P7TQMD6M-0146.local>
 <20220711085459.19730-1-lihe@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711085459.19730-1-lihe@uniontech.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 11, 2022 at 04:54:59PM +0800, Li He wrote:
> Add --offset to erofsfuse to skip bytes at the start of the image file.
> 
> Signed-off-by: Li He <lihe@uniontech.com>
> ---
> We should add offset to fuse_operations so erofsfuse can parse it from
> command line. fuse_opt_parse can not parse cfg directly.

Oh, I forgot that, looks good to me now!

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
