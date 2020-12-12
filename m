Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70012D8568
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Dec 2020 10:49:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CtND800VyzDqpq
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Dec 2020 20:49:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607766584;
	bh=NpybPXXAerNZ3w7cGKQQHFoXXLsSrqFIoxkN5llaN+U=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZVS8wSH60HB5cNQ6PZohOEAY/EscsDmrcbDi2BXEXDQzEiWeYgHxGbDNlwuNnOhEO
	 UEOG2tVvXQ9LL0Lt5kFaAg2/IHh+mkhH94+SeUsKLSjWj87kh68F+r8xmLbzZEtEbd
	 IQkDaYB+T6fHeWZRhC1a7pFz/KcPT7PBdawsMPo6J7lR+9why12lkEjmXxnWkfV76e
	 6dSgN63jTBsfAu9Z1j8To9Evf0MnM9uE0Y9+ZCBAMTsJU7VA1JAAaMzf1cKilA4jxL
	 e2WMFRvire/iU2GVSsB7Ln74MfuMDgV3XEYB1RO2d7hMq5F7FtRa5IGDm/ubxW0sDH
	 0/J6mXq+nsCLQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.15;
 helo=out30-15.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=UVKJ6+AS; dkim-atps=neutral
Received: from out30-15.freemail.mail.aliyun.com
 (out30-15.freemail.mail.aliyun.com [115.124.30.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CtNCx6kTqzDqn5
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Dec 2020 20:49:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1607766554; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=01UMevydSOPS0KKT8WxR/WvVpDjmtu/+R0bibuvU1Eo=;
 b=UVKJ6+ASDRAjgZDLpYDR55Bv4IclOit//x1HxP26J+SaQ6FKzjzQUgL8zbzIckfjCXHmCgMI8JEC5RKpATwAsPQgQd4hPWiDurDCLh4Gk6d/pDMt8hsy4ibj+nI7QqGN+7csL+HNhWCEnO0DqHloPxFdRuty2BT22Y9xH8Wn6/o=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07829325|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.00305502-0.000228948-0.996716;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04394; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---0UIKTFFY_1607766553; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UIKTFFY_1607766553) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 12 Dec 2020 17:49:13 +0800
Subject: Re: [PATCH] erofs-utils: fuse: fix linking when using --with-selinux
To: David Michael <fedora.dm0@gmail.com>, linux-erofs@lists.ozlabs.org,
 bluce.liguifu@huawei.com, miaoxie@huawei.com, fangwei1@huawei.com
References: <87360dnkh4.fsf@gmail.com>
Message-ID: <8cf03720-465b-1cd9-d39f-80f0d8aca539@aliyun.com>
Date: Sat, 12 Dec 2020 17:49:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87360dnkh4.fsf@gmail.com>
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
Cc: gaoxiang25@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2020/12/11 10:29, David Michael wrote:
> The libselinux functions selabel_open and selabel_close are called
> by lib/config.c, so include libselinux in CFLAGS and LIBS to fix
> building erofsfuse.
> 
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
> 
> Hi,
> 
> Trying to build both mkfs.erofs with SELinux and erofsfuse at the same
> time (with both --enable-fuse and --with-selinux) results in the
> following linking errors:
> 
> /usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_selabel_open':
> /home/dm0/rpmbuild/BUILD/erofs-utils-1.2/lib/config.c:75: undefined reference to `selabel_open'
> /usr/bin/ld: ../lib/.libs/liberofs.a(liberofs_la-config.o): in function `erofs_exit_configure':
> /home/dm0/rpmbuild/BUILD/erofs-utils-1.2/lib/config.c:42: undefined reference to `selabel_close'
> 
> Are these programs supposed to be configured separately?  If this build
> configuration is supposed to work, this change fixes linking.
> 
> Thanks.
> 
> David
> 
>  fuse/Makefile.am | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
It's fixed
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Tested-by: Li Guifu <bluce.lee@aliyun.com>
Thanks,

