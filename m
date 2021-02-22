Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A54321BAF
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Feb 2021 16:39:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DkmZl56S0z30RC
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 02:39:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614008383;
	bh=dU8V4zG8/YYWsglVazpIShdGZ/9pItYmNZE3c/PbOzc=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=PKCKeUY/d29ZlwAZkwy7MhXMSil854e27sBBphtfulFAeLazsZqq4x63RO9QEX+Vg
	 ZJZlfRXJM0X+Qs1+oT5Y3ge50o7US4WX9NUbco8T4uUPjcmhrbMf7AVCwDBx/c1791
	 4XL3GeGCyNZPJX0y+BNwfbkyG/iN9Zpql6bzKFzNjYPZQavqBTy1WfmLRuwh1IkCtH
	 d143wvCjXZY9+PzsyguGojRryOQfBG5+zU+C1SQNX01gA4Vd7FLVMYpZmsJAwXiRnV
	 0Xh6zG6M8e/xNFweLRzEKlBLSjT9aWPI3ofFAScD3QweAX/LZBSMc7dwWG6spr6AX9
	 +Q99eXbBOJILA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.14;
 helo=out30-14.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=TJkjwvq7; dkim-atps=neutral
X-Greylist: delayed 305 seconds by postgrey-1.36 at boromir;
 Tue, 23 Feb 2021 02:39:40 AEDT
Received: from out30-14.freemail.mail.aliyun.com
 (out30-14.freemail.mail.aliyun.com [115.124.30.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DkmZh41Gdz30HW
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 02:39:39 +1100 (AEDT)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08770521|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00384754-0.000747931-0.995404;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04400; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UPHtzVK_1614008065; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UPHtzVK_1614008065) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 22 Feb 2021 23:34:26 +0800
Subject: Re: [PATCH v3] erofs-utils: fix battach on full buffer blocks
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
 <20210214160004.6075-1-hsiangkao@aol.com>
Message-ID: <a347332c-9936-f9f5-f4b2-fcc8025973c6@aliyun.com>
Date: Mon, 22 Feb 2021 23:34:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210214160004.6075-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
From: Li GuiFu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/2/15 0:00, Gao Xiang via Linux-erofs wrote:
> From: Hu Weiwen <sehuww@mail.scut.edu.cn>
> 
> When the subsequent erofs_battach() is called on an buffer block of
> which (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' won't be
> updated correctly. This bug can be reproduced by:
> 
> mkdir bug-repo
> head -c 4032 /dev/urandom > bug-repo/1
> head -c 4095 /dev/urandom > bug-repo/2
> head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
> mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
> Then mount this image and see that file `3' in the image is different
> from `bug-repo/3'.
> 
> This patch fix this by:
>  * Handle `oob' and `tail_blkaddr' for the case above properly;
>  * Don't inline tail-packing data for such case, since the tail-packing
>    data is actually in a different block from inode itself even kernel
>    can handle such cases properly.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Reviewed-by: Gao Xiang <hsiangkao@aol.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
