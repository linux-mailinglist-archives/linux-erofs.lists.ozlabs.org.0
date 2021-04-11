Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30835B56B
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 15:55:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJD0m0DZ8z30Bc
	for <lists+linux-erofs@lfdr.de>; Sun, 11 Apr 2021 23:55:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1618149352;
	bh=gDGWj4vaf0JEznXqr3RTpFXgymM7C0QVilt7VDLhEuA=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=b0t1tEKHMjmiN5C7wmUNaOjSVf1SeepZkw2VA6DRcl5O1T5oNgM9eZ//fP9snpdVx
	 0s8oMqsZIu8sZGcZupcjcT30EC5s6cR2Q+rRwpSiybGdeHi5ljTn6R/5367wSoh4pE
	 4ebv7A/4J9/GVtQ6YWVvbdpBUN5ncuNNkCUIQdgstcCTIsn7KGmvZgq6ZpaLTPv1XQ
	 576fIRYujejhKZJOCMtaBZyt0wMaCcLeXcsNUk4NPBipAXC10OPm8a7JuBZj920D2L
	 vY0a/6SbALETW8lb+hjc7xXXeCo/2EL0xmfPvOSh+jZEigPO6C4J0WI0dIl4FvxCv4
	 hLfteeYa3IXhA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.26;
 helo=out30-26.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=If2x6KO6; dkim-atps=neutral
X-Greylist: delayed 306 seconds by postgrey-1.36 at boromir;
 Sun, 11 Apr 2021 23:55:47 AEST
Received: from out30-26.freemail.mail.aliyun.com
 (out30-26.freemail.mail.aliyun.com [115.124.30.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJD0g5cKvz2yYn
 for <linux-erofs@lists.ozlabs.org>; Sun, 11 Apr 2021 23:55:47 +1000 (AEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07368171|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0208492-0.00327055-0.97588;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0UV9knt1_1618149033; 
Received: from 192.168.3.32(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0UV9knt1_1618149033) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 11 Apr 2021 21:50:33 +0800
Subject: Re: [PATCH v2] erofs-utils: add cmd argument to override uid/gid
To: Gao Xiang <xiang@kernel.org>, Hu Weiwen <sehuww@mail.scut.edu.cn>
References: <20210401060132.GA3827683@xiangao.remote.csb>
 <20210401113610.49094-1-sehuww@mail.scut.edu.cn>
 <20210401120102.GA30040@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-ID: <8ee275dd-79b4-9e23-a1cb-c68ca0bc1f5b@aliyun.com>
Date: Sun, 11 Apr 2021 21:50:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401120102.GA30040@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/4/1 20:01, Gao Xiang wrote:
> On Thu, Apr 01, 2021 at 07:36:10PM +0800, Hu Weiwen wrote:
>> Also added '--all-root' option to set uid and gid to root conveniently.
>>
>> This function can be useful if we want to pack some data owned by user with
>> large uid, but we want to use compact inode.
>>
>> This interface mimics that of 'mksquashfs'.
>>
>> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> 
> Yey! I've applied with the following modification,
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index e6eaef66b91c..15390f4ca9c8 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -54,8 +54,7 @@ struct erofs_configure {
>  	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>  	int c_inline_xattr_tolerance;
>  	u64 c_unix_timestamp;
> -	u32 c_uid;
> -	u32 c_gid;
> +	u32 c_uid, c_gid;
>  #ifdef WITH_ANDROID
>  	char *mount_point;
>  	char *target_out_path;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 72b7f17e1c66..d8823b539194 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -77,8 +77,8 @@ static void usage(void)
>  #ifdef HAVE_LIBSELINUX
>  	      " --file-contexts=X  specify a file contexts file to setup selinux labels\n"
>  #endif
> -	      " --force-uid=UID    set all file uids to UID\n"
> -	      " --force-gid=GID    set all file gids to GID\n"
> +	      " --force-uid=#      set all file uids to # (# = UID)\n"
> +	      " --force-gid=#      set all file gids to # (# = GID)\n"
>  	      " --all-root         make all files owned by root\n"
>  	      " --help             display this help and exit\n"
>  #ifdef WITH_ANDROID
> 
> Otherwise looks good to me,
> Reviewed-by: Gao Xiang <xiang@kernel.org>
> 

It looks good
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>

Thanks,
