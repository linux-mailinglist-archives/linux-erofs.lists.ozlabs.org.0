Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B054194438
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2020 17:26:50 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p9Nl4Lf0zDqtK
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 03:26:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1585240007;
	bh=ziNYcHMNAneungNuSMGHfw3AWzr5NyPViP6hzTAFxQw=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lS757uOT6NP2iT7//kI/CkuJhA/KHfySE4Bfsmmzl8eFME2IzuAO6xugKUszeXLp1
	 ZwsOOp59Upufj4//liz05DrZ24FPlWY2YP767pa7sw542+WepxhjBT2oZYSfTZcoZc
	 B3c2UsZNrrRAtGUN4QpXWvwNH35jhbe7gdbsINDpo9Qlyzq783xXlSs8c5adw2YYIu
	 uyQQRXVOtPdeHcbxcVxpdFPg3QmbYmG964AwQFT7lmq0bcrXPqqjdQ8KHtOCmmPIFv
	 0mTJbIXYJDb5u0NTZIzhQrgldb2Co3o8CS7aU6uyGi2O2ohxNWaFsU3TgsqEeIJSQs
	 VGbqFPMXhcL9Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.50;
 helo=out30-50.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=DvQjm2Ro; dkim-atps=neutral
Received: from out30-50.freemail.mail.aliyun.com
 (out30-50.freemail.mail.aliyun.com [115.124.30.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p9LN4BXZzDr0R
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2020 03:24:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1585239878; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=RhO40v75ALkzTgvcslMU6xUxTIf2nWNVpeDl9IEZPds=;
 b=DvQjm2RodO3PmWXr2/kFfqlcK4sf44wtkPC54D6bRNOjQ8Fb3iAATQNmLs3sCNV/S8eRsBD6dvkW8kpvK+LmKyIt+/mBYcsJDc/rnhrMk89o4Zr2oEyOe7iFG2yWzYo0U9UFHS8zGIKDBafHjGj9bAubTqq6fnhfYIn55r0xIiQ=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08249795|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_social|0.0105198-0.000360991-0.989119;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e01358; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0Tthk7Ci_1585239558; 
Received: from 192.168.0.103(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0Tthk7Ci_1585239558) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 Mar 2020 00:19:18 +0800
Subject: Re: [PATCH] erofs-utils: avoid using old compatibility type uint
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
 Li Guifu <bluce.liguifu@huawei.com>
References: <20200324081949.26355-1-hsiangkao.ref@aol.com>
 <20200324081949.26355-1-hsiangkao@aol.com>
Message-ID: <ef5f4cde-f26c-e399-5371-ab87a4d55111@aliyun.com>
Date: Fri, 27 Mar 2020 00:19:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324081949.26355-1-hsiangkao@aol.com>
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



On 2020/3/24 16:19, Gao Xiang wrote:
> This should fix the following buildroot autobuild issues
> with some configration on ARM platform [1]:
> 
> compress.c: In function 'vle_compress_one':
> compress.c:209:10: error: unknown type name 'uint'
>     const uint qh_aligned = round_down(ctx->head, EROFS_BLKSIZ);
>           ^~~~
> compress.c:210:10: error: unknown type name 'uint'
>     const uint qh_after = ctx->head - qh_aligned;
>           ^~~~
> compress.c: In function 'z_erofs_convert_to_compacted_format':
> compress.c:313:8: error: unknown type name 'uint'
>   const uint headerpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
>         ^~~~
> compress.c:316:8: error: unknown type name 'uint'
>   const uint totalidx = (legacymetasize -
>         ^~~~
> 
> [1] http://autobuild.buildroot.net/results/842a3c6416416d7badf4db9f38e3b231093a786a
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Thanks
