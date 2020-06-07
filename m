Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBDB1F0B01
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 13:50:43 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49fvpS32vwzDqYY
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Jun 2020 21:50:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1591530640;
	bh=EUK/7J/xeZ686R5N5BbYEI//jWVhkTVbeWWH3MOnanQ=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gs34mSXCLUVRGReems4R4tuEfppUD5DWxZtfJG8dcTwHW8ND+62m1uCyg3Stt24i7
	 6azZCKH2XlJneH+r7T43b0C3Vkq3SoQds4k1nXdvXCmamf3fRRMhQWlD8AB7G1dO+F
	 T7gjgNosumsSOg2BjMfxZyB/eS3kQCnscfLkir+SktgsR/ivz2LVNcB240LLRId33Y
	 bulFXKKkPxnj/VRldZi2bfCdY8YdmYFWgtOgJ8WupeHaxnJRrIZgt6HMMzuTF776m+
	 tplb9JG5Tg8hEkeZwC8iMQyymCMVIfI6jvzY78we+0DWGF6FETrWRcd/QfUQ5XdsI+
	 HrJ9laGwpt3MQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.40;
 helo=out30-40.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=YszPmJCj; dkim-atps=neutral
Received: from out30-40.freemail.mail.aliyun.com
 (out30-40.freemail.mail.aliyun.com [115.124.30.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49fvp91ngqzDqHF
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Jun 2020 21:50:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1591530607; h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 bh=kLxW9wzWq9WrxL3y40Su5PZ406/9U5P3eC4reJAFRxQ=;
 b=YszPmJCjmdksVL5vZBijpIcDOtvLsTE8b7+JARcZ3QveuJX06wkKcN6gM5Ymp8nCq19TnIH3gaZUl6EFabAkDPqP5GkLkL+ZlYcDjrLZs+OiyBIjd2qWzFN/ypcBVwPIMtDGcV8W/oGBAuYgJbpVa1YZBsjVj/yH3bQgUPSxdA0=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07819879|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00373863-0.000560929-0.9957;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04357; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U-pXK7a_1591530605; 
Received: from 192.168.3.5(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U-pXK7a_1591530605) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 07 Jun 2020 19:50:05 +0800
Subject: Re: [PATCH v2] erofs-utils: support selinux file contexts
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20200530161127.16750-1-hsiangkao@redhat.com>
 <20200606081752.27848-1-hsiangkao@redhat.com>
Message-ID: <fc29791c-14c1-6f10-bb5b-fd31877feedf@aliyun.com>
Date: Sun, 7 Jun 2020 19:49:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200606081752.27848-1-hsiangkao@redhat.com>
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
Cc: Shung Wang <waterbird0806@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2020/6/6 16:17, Gao Xiang wrote:
> Add --file-contexts flag that allows passing a selinux
> file_context file to setup file selabels.
>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> changes since v1:
>  fix selinux error handing and wrap up selabel
>  open pointed out by Guifu;
>
>  configure.ac           |  27 +++++++++
>  include/erofs/config.h |  21 +++++++
>  include/erofs/xattr.h  |   3 +-
>  lib/config.c           |  42 +++++++++++++
>  lib/exclude.c          |  12 +---
>  lib/inode.c            |   3 +-
>  lib/xattr.c            | 130 ++++++++++++++++++++++++++++++++---------
>  man/mkfs.erofs.1       |   3 +
>  mkfs/Makefile.am       |   4 +-
>  mkfs/main.c            |  15 ++++-
>  10 files changed, 217 insertions(+), 43 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 870dfb9..5145971 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -67,6 +67,15 @@ AC_ARG_WITH(uuid,
>     [AS_HELP_STRING([--without-uuid],
>        [Ignore presence of libuuid and disable uuid support @<:@default=enabled@:>@])])
>  
> +AC_ARG_WITH(selinux,
> +   [AS_HELP_STRING([--with-selinux],
> +      [enable and build with selinux support @<:@default=no@:>@])],
> +   [case "$with_selinux" in
> +      yes|no) ;;
> +      *) AC_MSG_ERROR([invalid argument to --with-selinux])
> +      ;;
> +    esac], [with_selinux=no])
> Can "with_selinux" to be set as "auto" ? it can be decide by the host, selinux installed enable selinux feature
>
