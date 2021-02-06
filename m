Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5201311E70
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Feb 2021 16:30:20 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DXx7F6T4CzDwlQ
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Feb 2021 02:30:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612625417;
	bh=yg1dV7vSEKAMvtNJJkgGEa4ha64J9Qj3xjU27/21hRM=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Dm+5MfeoE/Kv0jQyRZiJdZmpoDGhBm+8vBs89NgN6xs5GDA88Cwn8+iGqQO2o/xpP
	 W1P6N3TZ/SX42ZkMIXc3fxsXmo/H+nM1RdepztwM1zRjXo3dje4tU+r01JUq3lHpC0
	 QUdul003+28kpyYRB6/6iXVp4NA7vxCV/DbP7TVMGs0PgqgJ8vh0J/AP4tLDaYliIj
	 4yUfdfRy+I6ZDg8gh0ZKivlcCrwa0aDFGXfLqcl6ZN4qxT5HjTIUnDBGng3j2iCxE1
	 UGE5i23TG9JDj6qsSovLFXWmb+I1wLubB+9MfZMaGCXruEjUJ7Ym/XquAEOjyCkY22
	 M+LqQP/XU4DWQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.17;
 helo=out30-17.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=a2JR2vpH; dkim-atps=neutral
Received: from out30-17.freemail.mail.aliyun.com
 (out30-17.freemail.mail.aliyun.com [115.124.30.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DXx702jgszDwjS
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Feb 2021 02:30:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1612625383; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=LroNBf1Bjy0E9vJha6Zm/rb4peQvkW5VG7hEmuGmTSc=;
 b=a2JR2vpHJrGEhY9u0kxoPTu9apuGIlLFw4ksPjSpZT19yfd++/v1+2Xh1wELv2UOVe3VhHbdEugnayqXv2FTDGSFE7s0lrzth8L7fXyJk+j++Pxa6rEUJZSV86pX8srjfOjomT2MO9iBEGBlMRA1Ktm/6IVk67Hw3HsMNKaO9yY=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08008137|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.00565184-0.00050276-0.993845;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04423; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---0UO0KAK3_1612625380; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UO0KAK3_1612625380) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 06 Feb 2021 23:29:40 +0800
Subject: Re: [PATCH v7 3/3] erofs-utils: optimize buffer allocation logic
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20210122171153.27404-1-hsiangkao@aol.com>
 <20210122171153.27404-4-hsiangkao@aol.com>
Message-ID: <fc43d559-4067-8897-6c39-7c69b9748066@aliyun.com>
Date: Sat, 6 Feb 2021 23:29:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122171153.27404-4-hsiangkao@aol.com>
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



On 2021/1/23 1:11, Gao Xiang via Linux-erofs wrote:
> From: Hu Weiwen <sehuww@mail.scut.edu.cn>
> 
> When using EROFS to pack our dataset which consists of millions of
> files, mkfs.erofs is very slow compared with mksquashfs.
> 
> The bottleneck is `erofs_balloc' and `erofs_mapbh' function, which
> iterate over all previously allocated buffer blocks, making the
> complexity of the algrithm O(N^2) where N is the number of files.
> 
> With this patch:
> 
> * global `last_mapped_block' is mantained to avoid full scan in
> `erofs_mapbh` function.
> 
> * global `mapped_buckets' maintains a list of already mapped buffer
> blocks for each type and for each possible used bytes in the last
> EROFS_BLKSIZ. Then it is used to identify the most suitable blocks in
> future `erofs_balloc', avoiding full scan. Note that not-mapped (and the
> last mapped) blocks can be expended, so we deal with them separately.
> 
> When I test it with ImageNet dataset (1.33M files, 147GiB), it takes
> about 4 hours. Most time is spent on IO.
> 
> Cc: Huang Jianan <jnhuang95@gmail.com>
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>  include/erofs/cache.h |   1 +
>  lib/cache.c           | 105 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 93 insertions(+), 13 deletions(-)
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
