Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCB194439
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2020 17:26:55 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p9Nr4wjWzDr0v
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 03:26:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1585240012;
	bh=KMr10EHZaCZuICKyx/BZHjLfbG2FB/pS5uBNJSoMESs=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nawDTJw1rBPCJnyAWQLRv/IKji8p0nOtgFJACa+LvAk3Sy7cqkPEjGuseijn+3Qlv
	 veXdmj7AVEzk1KnqDqyyLwr6QA2cI8KBoFNCb8o79QJokMJBqJcWbrRMKs42OsHlNG
	 ddDPMp62dSi6r6GqWr0eA1GFKx1x2FLyqURNlSVH6YnQWIhlYNbKrqGr2WpbqJlbx+
	 sbsRQ18B05JKbk8bPyrWIM5vAdxtNmWEUCduxcQo1naO+M4i6x+YZQIbdGNPt3sk3X
	 z8pa3DkrLsL9H1ablRrt/3Pz9kZUmKRcbUuuCBygBElPuTeuZ9IP0VR98NhsH4N51R
	 Qoos9IB+3RW0A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.16;
 helo=out30-16.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=obtluYuD; dkim-atps=neutral
Received: from out30-16.freemail.mail.aliyun.com
 (out30-16.freemail.mail.aliyun.com [115.124.30.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p9Lw1MkNzDqyl
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2020 03:25:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1585239905; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=mRxyyVzIeLb/EokUzv1jgD+l9pzc6NQ6h6YsKIsqjPc=;
 b=obtluYuDqMX5Mtsu/ZqCPTkNyfWw0xP/ArUN3k8O5NiP01At4O2npj5VPJSgJIYWWhMPjmYD0kdSouv8cq8lxkIkGcswUG12q10TN6It1d7paPxcrqHZeZuujIE6odOTkR2+i2OaJrY21uIGAd8PCDcJpLcg0kurIiA9CM8j3xo=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07962158|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.00941547-0.000583542-0.990001;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04407; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0TthtEEh_1585239586; 
Received: from 192.168.0.103(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0TthtEEh_1585239586) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 Mar 2020 00:19:46 +0800
Subject: Re: [PATCH] erofs-utils: avoid PAGE_SIZE redefinition
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
 Li Guifu <bluce.liguifu@huawei.com>
References: <20200325082930.2025-1-hsiangkao.ref@aol.com>
 <20200325082930.2025-1-hsiangkao@aol.com>
Message-ID: <7482e592-0945-50db-a22a-95f4826d9eb5@aliyun.com>
Date: Fri, 27 Mar 2020 00:19:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325082930.2025-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
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



On 2020/3/25 16:29, Gao Xiang wrote:
> Buildroot autobuild reported a PAGE_SIZE redefinition with some
> configrations on i586 toolchain [1] (I didn't notice such report
> from erofs-utils travis CI or distribution builds before.)
> 
> In file included from config.c:11:
> ../include/erofs/internal.h:27: error: "PAGE_SIZE" redefined [-Werror]
>  #define PAGE_SIZE  (1U << PAGE_SHIFT)
> 
> In file included from ../include/erofs/defs.h:17,
>                  from ../include/erofs/config.h:12,
>                  from ../include/erofs/print.h:12,
>                  from config.c:10:
> .../sysroot/usr/include/limits.h:89: note: this is the location of the previous definition
>  #define PAGE_SIZE PAGESIZE
> 
> cc1: all warnings being treated as errors
> 
> Fix it now.
> 
> [1] http://autobuild.buildroot.net/results/340b98caa45bafd43f109002be9da59ba7f6d971
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks
